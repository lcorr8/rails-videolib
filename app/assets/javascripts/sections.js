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
        console.log(data)
        //$('.sections').html("")
        for (i=0; i< data.length; i++) {
          var newSection = new Section(data[i].id, data[i].name)
          $('.sections').append($('<li></li>').text(newSection.name))
        }

        //$('.sections').append(data[0].name)
      })
  })
}

// section model object using constructor function
function Section(id, name){
  this.id = id,
  this.name = name
}