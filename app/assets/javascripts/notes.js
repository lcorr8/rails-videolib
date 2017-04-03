$(function(){
  notesIndex();
})

function notesIndex(){
  $(document).on("click", '#view-notes', function(e){
    e.preventDefault()
    var id = $(this).data("id")
    //make requets to api
    $.ajax({
      method: "GET",
      url: `/api/videos/${id}/notes`
    }).success(function(data){
      var notes = data
      $(".video-notes").html('')
      $(".video-notes").before("<p>Your Notes:</p>")
      for (i=0; i< notes.length; i++) {
        var note = new Note(notes[i].content)
        var formattedNote = note.formatNote()
        $(".video-notes").append(formattedNote)
      }
    })
  })
}

function Note(content){
  this.content = content
}

Note.prototype.formatNote = function() {
  var html = ""
  html += `<li><p>${this.content}</p></li>`
  return html
}