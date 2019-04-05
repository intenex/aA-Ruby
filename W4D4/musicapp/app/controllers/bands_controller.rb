class BandsController < ApplicationController
    def index
        @bands = Band.all
        render :index
    end

    def create
        @band = Band.new(band_params)
        if @band.save
            redirect_to band_url(@band)
        else
            flash[:errors] = @band.errors.full_messages
            redirect_to new_band_url
        end
    end

    def new
        @band = Band.new # if you use the same form as edit
        render :new
    end
    
    def edit
        @band = Band.find_by(id: params[:id])
        if @band
            render :edit
        else
            flash[:errors] = ["There is no band with that id."]
            redirect_to bands_url
        end
    end

    def show
        @band = Band.find_by(id: params[:id])
        render :show
    end

    def update
        @band = Band.find_by(id: params[:id])
        if @band
            if @band.update(band_params)
                redirect_to band_url(@band)
            else
                flash[:errors] = @band.errors.full_messages
                redirect_to edit_band_url(@band)
            end
        else
            flash[:errors] = ["There is no band with that id."]
            redirect_to bands_url
        end
    end

    def destroy
        @band = Band.find_by(id: params[:id])
        if @band.destroy
            redirect_to bands_url
        else
            flash[:errors] = @band.errors.full_messages
            redirect_to band_url(@band)
        end
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end
