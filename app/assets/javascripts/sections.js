$( function(){
  $(".sections").on("click", function(){
    $('.sections').html('')
    fetch(`/api/sections`)
      .then(function(response) {
        return response.json()
      })
      .then(function(data) {
        console.log(data)

        $('.sections').append(data[0].name)
      })

  })
})