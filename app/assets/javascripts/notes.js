$(function(){
  bindClickToNotesIndex();
  createNote();
})

function bindClickToNotesIndex(){
  $(document).on("click", '#view-notes', function(e){
    e.preventDefault()
    getNotes()
  })
}

function getNotes(){
  var id = $(".video-container").data("video-id")
    //make requets to api
    $.ajax({
      method: "GET",
      url: `/api/videos/${id}/notes`
    }).success(function(data){
      var notes = data
      $(".notes-container").html('')
      $(".notes-container").append( $("<p>Your Notes:</p>"))
      $(".notes-container").append( $('<div class="video-notes"></div>'))
      
      for (i=0; i< notes.length; i++) {
        var note = new Note(notes[i].content)
        var formattedNote = note.formatNote()
        $(".video-notes").append(formattedNote)
      }
    })
}

function Note(content){
  this.content = content
}

Note.prototype.formatNote = function() {
  var html = ""
  html += `<li>${this.content}</li>`
  return html
}

function createNote(){
  //bind click, prevent default,
  $(document).on("click", '#add-new-note', function(e){
    //e.preventDefault()
    //take content, user id, video id, from field
    var noteContent = $("#note-textarea").val()
    var userId = currentUser()
    var videoId = $(".video-container").data("video-id")
    //pass info a create route
    $.ajax({
      method: "POST",
      url: `/videos/${videoId}/notes`,
      data: {'note': {'content': `${noteContent}`}},
      headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')}
    }).success(function(data){
      //alert("Post successful")
      //update notes index
      getNotes()
      //clear text area
      $("#note-textarea").val("")
    })
  })
}




