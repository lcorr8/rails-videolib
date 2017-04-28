$( function(){
  sectionsIndex()
  sectionVideosIndex()
})

// bind cicks for sections, and section videos
function sectionsIndex(){
  $(".sections button").on("click", function(){
    $('.sections').html('')
    $(".sections").append(`<h2>Sections</h2>`)
    $.ajax({
      method: "GET",
      url: `/sections.json`
    }).success(function(data){
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
  $(document).on("click", "li.section-index", function(event){
    var sectionId = $(this).data("id")
    var sectionName = $(this).text()
    $.ajax({
      method: "GET",
      url: `/sections/${sectionId}.json`
    }).success(function(data){
        var videos = data
        $('.section-videos').html('')
        $(".section-videos").append(`<h2>${sectionName} Videos</h2>`)
        videos.forEach(function(video){
          var newVideo = new SectionVideo(video.id, video.name)
          var formattedVideo = newVideo.formatSectionVideo()
          $(".section-videos").append(formattedVideo)
        })
      })
  })
}

// section, video model object using constructor function
function Section(id, name, videos){
  this.id = id,
  this.name = name
  this.videos = videos
}
//should this be a sectionvideo so that i can create video objects with more attributes for the show page?
// function Video(id, name){
//   this.id = id,
//   this.name = name
// }
function SectionVideo(id, name){
  this.id = id,
  this.name = name
}

// section, video prototype to format js model object
Section.prototype.formatSection = function(){
  var sectionHtml = ""
  sectionHtml += `<h3><li data-id=${this.id} class="section-index">` + this.name + "</li></h3>"
  return sectionHtml
}
SectionVideo.prototype.formatSectionVideo = function(){
  var sectionVideoHtml = ""
  sectionVideoHtml += `<a href="#"><h3><li class="video-index" data-id=${this.id}>${this.name}</li></h3></a>`
  return sectionVideoHtml
}

