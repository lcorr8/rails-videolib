module VideosHelper

  def embed_html(url)
    if url.include?("youtube")
      @youtube_video_id = url.split("=").last
      content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{@youtube_video_id}")
    elsif url.include?("amazonaws")
      #aws video just make an iframe with link as dynamic source
      content_tag(:iframe, nil, src: "#{url}")
    end
  end

  def watched_videos_percentage(watched, total)
    (watched.count * 100) / total.count
  end
end
