$( function(){
  bindVideoShow();
  backToSections();
  removeView();
  addViewStatus();

})

// bind clicks for sections, and section videos
function bindVideoShow(){
  $(document).on("click", ".video-index", function(event){
    event.preventDefault()
    var videoId = $(this).data("id")
    videoShow(videoId)
  })
}

function videoShow(id){
  var videoId = id
  $.ajax({
      method: "GET",
      url: `/videos/${videoId}.json`
    }).success(function(data){
        var video = data
        $('#template-container').empty()
        var newVideo = new Video(video.id, video.name, video.link, video.flatiron, video.section.id, video.section.name, video.users)
        var formattedVideo = newVideo.formatVideo()
        $("#template-container").append(formattedVideo)
      })
    history.pushState(null,null, `/videos/${videoId}`)
}

//refactor into passing attributes, and iterating over attributes[key]= value to assign them
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

  //refactor into one string, template literal style
  var videoHtml = `
  <div class="container center video-info-container">
     <span class="pull-left">
     <h1>Section: <a href="">${this.sectionName}</a></h1>
      <h2>Video: <a href="">${this.name}</a></h2>
    </span> 
  </div>
  <div class="video-container" data-video-id=${this.id}>
    <div class=${klass}>
      <iframe id="player" src=${url}></iframe>
      //<div id="player"></div>
    </div>
  </div>
  <br>
  <div class="buttons-container">
    <button id="back-to-sections" data-section-id=${this.sectionId} class="btn rounded-outline-btn">Back to Sections</button>
    <button id="view-notes" class="btn rounded-outline-btn">View Notes</button>`
      if (this.watchedByCurrentUser()){
      videoHtml += `<button id="remove-view" class="btn rounded-outline-btn">Delete View Status</button>`
    } else {
      //mark video watched button
      videoHtml += `<button id="add-view-status" class="btn rounded-outline-btn">Mark Video Watched</button>`
      } 
  videoHtml += `
  </div>
  <br>
  <div class="input-group" id="new-note-container">
    <textarea id="note-textarea" class="form-control custom-control" rows="2" style="resize:none" placeholder="Add a video note here..."></textarea>
    <span class="input-group-addon btn rounded-outline-btn" id="add-new-note">Send</span>
  </div>
  <br>
  <div class="notes-container"></div>`

  return videoHtml
}

Video.prototype.formatSectionVideo = function(){
  var sectionVideoHtml = ``
  sectionVideoHtml += `<a href="#"><h3><li class="video-index" data-id=${this.id}><span>${this.name}</span>`
  if (this.watchedByCurrentUser()) {
    sectionVideoHtml += `  <i class="fa fa-check-square-o"></i>`
  }
  sectionVideoHtml += `</li></h3></a>`
  
  return sectionVideoHtml
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
      url: `/sections.json`,
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

//binds click to remove view, jquery button
function removeView() {
  $(document).on("click", "#remove-view", function(e){
    //e.preventDefault()
    var videoId = $(".video-container").data("video-id")
    $.ajax({
      method: "POST",
      url: `/videos/${videoId}/watched/delete.json`,
      data: {video: { watched: false }},
      headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')}
    }).success(function(data){
      videoShow(videoId)
    })
  })
}

//bind mark video watched jquery button (by adding a view status true to the join table)
function addViewStatus(){
  $(document).on("click", "#add-view-status", function(e){
    //e.preventDefault()
    var videoId = $(".video-container").data("video-id")
    $.ajax({
      method: "POST",
      url: `/videos/${videoId}/watched.json`,
      data: {video: { watched: true }},
      headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')}
    }).success(function(data){
      videoShow(videoId)
    })
  })
}