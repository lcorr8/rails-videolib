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
  if (this.link.includes("youtube")) {
    var youtubeId = this.link.split("=").slice(-1)[0]
    var url = `//www.youtube.com/embed/${youtubeId}`
  } else { 
  // if (this.link.includes("amazonaws")) {
    var url = this.link
  }

  var videoHtml = ""
  videoHtml += `<h1>Section: ${this.sectionName}</h1>`
  videoHtml += `<h2>Video: ${this.name}</h2>`

  videoHtml += `<div class="video-container">`
  videoHtml += `<iframe src=${url}></iframe>`
  videoHtml += `</div>`

  return videoHtml
}

//from youtube embed page
//<iframe width="560" height="315" src="https://www.youtube.com/embed/Cbtm3aRiGxU" frameborder="0" allowfullscreen></iframe>



