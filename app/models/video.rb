
class Video < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true, format: { with: /\Ahttps?:\/\/(?:www\.)?youtube\.com\/embed\/([^\s&]+)/, message: "is not a valid YouTube URL" }

  # def thumbnail_url
  #   video_id = url.split('v=').last
  #   youtube_client = YouTubeApi.client
  #   video_info = youtube_client.video_by(video_id: video_id)
  #   video_info.thumbnail_url
  # end
end
