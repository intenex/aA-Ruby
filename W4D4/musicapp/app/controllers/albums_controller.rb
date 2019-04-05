class AlbumsController < ApplicationController
    def new
        @bands = Band.all
        @album = Album.new
        @band = Band.find_by(id: params[:band_id]) # this is prefixed as this is a nested route love it
        render :new
    end

    def create
        @album = Album.new(album_params)
        if @album.save
            redirect_to album_url(@album)
        else
            flash[:errors] = @album.errors.full_messages
            redirect_to new_band_album
        end
    end

    def edit
        @album = Album.find_by(id: params[:id])
        if @album
            render :edit
        else
            flash[:errors] = ["There is no album with that id."]
            redirect_to bands_url
        end
    end

    def show
        @album = Album.find_by(id: params[:id])
        if @album
            render :edit
        else
            flash[:errors] = ["There is no album with that id."]
            redirect_to bands_url
        end
    end

    def update
        @album = Album.find_by(id: params[:id])
        if @album
            if @album.update(album_params)
                redirect_to album_url(@album)
            else
                flash[:errors] = @album.errors.full_messages
                redirect_to edit_album_url(@album)
            end
        else
            flash[:errors] = ["There is no album with that id."]
            redirect_to bands_url
        end
    end

    def destroy
        @album = Album.find_by(id: params[:id])
        if @album
            if @album.destroy
                redirect_to bands_url
            else
                flash[:errors] = @album.errors.full_messages
                redirect_to album_url(@album)
            end
        else
            flash[:errors] = ["There is no album with that id."]
            redirect_to bands_url
        end
    end

    private
    def album_params
        params.require(:album).permit(:band_id, :title, :year, :studio_album)
    end
end
