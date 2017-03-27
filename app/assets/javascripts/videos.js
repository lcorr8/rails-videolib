$( function(){
  videoShow();
})

// bind cicks for sections, and section videos
function videoShow(){
  $(document).on("click", ".video-index", function(event){
    event.preventDefault()
    var videoId = $(this).data("id")
    //console.log("clicked on a video")
    $.ajax({
      method: "GET",
      url: `/api/videos/${videoId}`
    }).success(function(data){
        var video = data
        $('#template-container').empty()
        var newVideo = new Video(video.id, video.name, video.link, video.flatiron, video.section.id, video.section.name)
        var formattedVideo = newVideo.formatVideo()
        $("#template-container").append(formattedVideo)
      })
    history.pushState(null,null, `/videos/${videoId}`)
  })
}

function Video(id, name, link, flatiron, sectionId, sectionName){
  this.id = id,
  this.name = name,
  this.link = link,
  this.flatiron = flatiron,
  this.sectionId = sectionId,
  this.sectionName = sectionName
}

Video.prototype.formatVideo = function() {
  var videoHtml = ""
  videoHtml += `Section: ${this.sectionName}<br>`
  videoHtml += `Video: ${this.name}<br>`
  videoHtml += `Link: ${this.link}<br>`
  return videoHtml
}