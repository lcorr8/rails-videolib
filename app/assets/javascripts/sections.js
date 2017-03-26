$( function(){
  sectionsIndex()
})

function sectionsIndex(){
  $(".sections button").on("click", function(){
    $('.sections').html('')
    fetch(`/api/sections`)
      .then(function(response) {
        return response.json()
      })
      .then(function(data) {
        data.forEach(function(section) {
          var newSection = new Section(section.id, section.name)
          var formattedSection = newSection.formatSection()
          $('.sections').append(formattedSection)
        })
      })
  })
}

// section model object using constructor function
function Section(id, name){
  this.id = id,
  this.name = name
}

// section prototype to format js model object
Section.prototype.formatSection = function(){
  var sectionHtml = ""
  sectionHtml += "<h3><li>" + this.name + "</li></h3>"
  return sectionHtml
}