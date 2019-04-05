# == Schema Information
#
# Table name: albums
#
#  id           :bigint(8)        not null, primary key
#  title        :string           not null
#  year         :integer          not null
#  band_id      :integer          not null
#  studio_album :boolean          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Album < ApplicationRecord
    validates :title, :year, :studio_album, presence: true

    after_initialize :set_default_studio_album

    belongs_to :band

    private
    def set_default_studio_album
        self.studio_album ||= true
    end
end
