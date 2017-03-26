$( function(){
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
          $('.sections').append($('<li></li>').text(data[i].name))
        }

        //$('.sections').append(data[0].name)
      })
  })
})