module ApplicationHelper
  def gravatar_url(email, size)
    gravatar = Digest::MD5::hexdigest(email).downcase
    "https://www.gravatar.com/avatar/#{gravatar}.png?s=#{size}"
  end

  def embed_video(url)
    video_id = url.split('v=').last
    content_tag(:iframe, '', src: "//www.youtube.com/embed/#{video_id}")
  end
end
