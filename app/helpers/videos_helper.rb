module VideosHelper

  def embed_html_from_youtube(youtube_url)
    @youtube_video_id = youtube_url.split("=").last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{@youtube_video_id}")
    #<iframe width="560" height="315" src="https://www.youtube.com/embed/E5V7_PSD4Sc" frameborder="0" allowfullscreen></iframe>
  end
end
