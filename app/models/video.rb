class Video < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true, format: { with: /\Ahttps?:\/\/(?:www\.)?youtube\.com\/embed\/([^\s&]+)/, message: "is not a valid YouTube URL" }
end
