# == Schema Information
#
# Table name: tracks
#
#  id            :bigint(8)        not null, primary key
#  title         :string           not null
#  album_id      :integer          not null
#  ord           :integer          not null
#  lyrics        :text
#  regular_track :boolean          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Track < ApplicationRecord
end
