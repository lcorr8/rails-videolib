$( function(){
  sectionsIndex();
  sectionVideosIndex()
})

// bind cicks for sections, and section videos
function sectionsIndex(){
  $(".sections button").on("click", function(){
    $('.sections').html('')
    $(".sections").append(`<h2>Sections</h2>`)
    fetch(`/api/sections`)
      .then(function(response) {
        return response.json()
      })
      .then(function(data) {
        data.forEach(function(section) {
          var newSection = new Section(section.id, section.name, section.videos)
          var formattedSection = newSection.formatSection()
          $('.sections').append(formattedSection)
        })
      })
  })
}

function sectionVideosIndex() {
  // make the json response into a js model object, with a prototype method that formats them
  //format shouldd include checkmark for vatched videos
  $(document).on("click", "li.section-show", function(event){
    var sectionId = $(this).data("id")
    var sectionName = $(this).text()
    $.ajax({
      method: "GET",
      url: `/api/sections/${sectionId}/videos`
    }).success(function(data){
        var videos = data
        $('.section-videos').html('')
        $(".section-videos").append(`<h2>${sectionName} Videos</h2>`)
        videos.forEach(function(video){
          var newVideo = new Video(video.id, video.name)
          var formattedVideo = newVideo.formatSectionVideo()
          $(".section-videos").append(formattedVideo)
        })
        //$("#games").html("")
      })
    // fetch('/api/sections/' + sectionId + '/videos')
    // .then(function(response){
    //   console.log(response)
    //   return response.json()
    // }).then(function(data){
    //   console.log(data)
    // })
  })
}
// section, video model object using constructor function
function Section(id, name, videos){
  this.id = id,
  this.name = name
  this.videos = videos
}

function Video(id, name){
  this.id = id,
  this.name = name
}

// section, video prototype to format js model object
Section.prototype.formatSection = function(){
  var sectionHtml = ""
  sectionHtml += `<h3><li data-id=${this.id} class="section-show">` + this.name + "</li></h3>"
  return sectionHtml
}
Video.prototype.formatSectionVideo = function(){
  var sectionVideoHtml = ""
  sectionVideoHtml += `<h3><li class="video" data-id=${this.id}>${this.name}</li></h3>`
  return sectionVideoHtml
}

