$( function(){
  videoShow();
  backToSections();

})

// bind cicks for sections, and section videos
function videoShow(){
  $(document).on("click", ".video-index", function(event){
    event.preventDefault()
    var videoId = $(this).data("id")
    //
    $.ajax({
      method: "GET",
      url: `/api/videos/${videoId}`
    }).success(function(data){
        var video = data
        $('#template-container').empty()
        var newVideo = new Video(video.id, video.name, video.link, video.flatiron, video.section.id, video.section.name, video.users)
        var formattedVideo = newVideo.formatVideo()
        $("#template-container").append(formattedVideo)
        youtubeScript()
      })
    history.pushState(null,null, `/videos/${videoId}`)
  })
}

function Video(id, name, link, flatiron, sectionId, sectionName, users){
  this.id = id,
  this.name = name,
  this.link = link,
  this.flatiron = flatiron,
  this.sectionId = sectionId,
  this.sectionName = sectionName
  this.users = users
}

Video.prototype.watchedByCurrentUser = function() {
  for (i=0; i< this.users.length; i++) {
    if (this.users[i].id === currentUser()){
      return true
    }
  } 
}

Video.prototype.formatVideo = function() {
  if (this.link.includes("youtube")) {
    var youtubeId = this.link.split("=").slice(-1)[0]
    var url = `//www.youtube.com/embed/${youtubeId}`
  } else { 
  // if (this.link.includes("amazonaws")) {
    var url = this.link
  }
  
  var videoUsers = this.users
  var klass = "video-not-watched"
  
  if (this.watchedByCurrentUser()) {
    var klass = "video-watched"
  } else {
    var klass = "video-not-watched"
  }

  var videoHtml = ""

  videoHtml += `<div class="container center video-info-container">`
    videoHtml += `<span class="pull-left">`
      videoHtml += `<h1>Section: <a href="">${this.sectionName}</a></h1>`
      videoHtml += `<h2>Video: <a href="">${this.name}</a></h2>`
    videoHtml += `</span>`  
  videoHtml += `</div>`

  videoHtml += `<div class="video-container" data-video-id=${this.id}>`
    videoHtml += `<div class=${klass}>`
      videoHtml += `<iframe id="player" src=${url}></iframe>`
    videoHtml += `</div>`
  videoHtml += `</div>`
  videoHtml += `<br>`

  videoHtml += `<div class="buttons-container">`
    videoHtml += `<button id="back-to-sections" data-section-id=${this.sectionId} class="btn rounded-outline-btn">Back to Sections</button>`
    videoHtml += `<button id="view-notes" data-video-id=${this.id} class="btn rounded-outline-btn">View Notes</button>`
  videoHtml += `</div>`

  videoHtml += `<br>`
  
  videoHtml += `<div class="input-group" id="new-note-container">`
    videoHtml += `<textarea id="note-textarea" class="form-control custom-control" rows="2" style="resize:none"></textarea>`
    videoHtml += `<span class="input-group-addon btn rounded-outline-btn" id="add-new-note">Send</span>`
  videoHtml += `</div>`
 

  videoHtml += `<br>`

  videoHtml += `<div class="notes-container"></div>`

  videoHtml += `<script></script>`


  return videoHtml
}

function youtubeScript(){
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  var player;
  function onYouTubeIframeAPIReady() {
    console.log("youtube api is ready")
                          //id of the iframe, in this case "player"
    player = new YT.Player('player', { 
      height: '390',
      width: '640',
      videoId: 'M7lc1UVf-VE', //youtube id
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange
      }
    });
  }

  // 4. The API will call this function when the video player is ready.
  function onPlayerReady(event) {
    event.target.playVideo();
  }

  // 5. The API calls this function when the player's state changes.
  //    The function indicates that when playing a video (state=1),
  //    the player should play for six seconds and then stop.
  var done = false;
  function onPlayerStateChange(event) {
    if (event.data == YT.PlayerState.PLAYING && !done) {
      setTimeout(stopVideo, 6000);
      done = true;
    }
  }

  function stopVideo() {
    player.stopVideo();
  }

}


function currentUser(){
  var id = $('.current-user').data("id")
  return id
}

// bind clicks for buttons: back to sections,
function backToSections() {
  $(document).on("click", "#back-to-sections", function(e){
    //no need to prevent event on jquery button
    $.ajax({
      method: "GET",
      url: `/api/sections`
    }).success(function(data){
      var sections = data
      $("#template-container").html('')
      //adds html from sections index view. is there a better way to do this?
      $("#template-container").append('<div class="container-fluid"><div class="row"><div class="col-md-6"><ol class="sections"></ol></div><div class="col-md-6"><ol class="section-videos"></ol></div></div></div>')
      $(".sections").append(`<h2>Sections</h2>`)
      //part of the sections.js sectionsIndex()
      data.forEach(function(section) {
          var newSection = new Section(section.id, section.name, section.videos)
          var formattedSection = newSection.formatSection()
          $('.sections').append(formattedSection)
        })
      $(window).scrollTop(0);
      //at this point flow joins previous js code in sections.js 
      //for when a section is clicked to display the videos
    })
  })
}





