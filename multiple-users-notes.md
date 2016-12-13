
[x]1. remove extra attributes from tables
[x]  -videos:
[x]    .watched: this will now be a join table
[x]    .embed_link: this is now created dynamically with an iframe, no need to store it in the db in order to display the video.
[x]    .notes_ids: ot currently using the notes model, only using the ratings
[x]  -users:
[x]    .section_ids: do i need this? how will the section model relate to the video model? section's have videos, videos belong to sections
[x]  -sections:
[x]    .user_id: sections don't have user's now, they belong to everybody and everybody can see them?   
[x]    .video_ids: AR takes care of this, so it's not needed. 
[x]2. create join tables
[x]  -a join table to show if a user has watched a video already
[x]    .id, video_id:integer, user_id:integer, watched:boolean
[x]  -a join table to show a user's rating of the video
[x]    .id, rating_id, video_id, reason.
[x]3. edit AR relationships and validations
[x]  -videos:
[x]    .remove belongs to user
[x]    .add has_many :user_watched
[x]    .add has_many :watched, through: :user_watched
[x]    .remove validates watched
[x]  -sections:
[x]    .remove belongs to user
[x]  -users:
[x]    .remove has many sections, and videos through sections
[x]    .remove has many notes
[x]    .add has_many :user_watched
[x]    .add has_many :watched, through: :user_watched
[x]  -user_watched:
[x]    .add belongs_to :videos
[x]    .add belongs_to :users
[x]    .add validates :watched, presence: true
[x]    .validates :video_id, presence: true
[x]    .validates :user_id, presence: true
[x]4. Edit controllers to reflect past changes
[x]  -videos:
[x]    .remove set user from show, new. not being used
[x]    .remove watched, embed_link, notes_ids, user_id*** from video_params. not being used
[x]    .remove assignment of user in create action
[x]    .change edit,update who can edit a video? who can delete a video?***
[x]    .mark video watched has to move to wherever the join table controller logic goes next
[x]  - sections:
[x]    .remove set user from create, . not being used.***
[x]    .users can only delete sections if they are an admin (also only when they are empty, check join table for other user's view status, if other user's have viewed the video, or plan to view it, don't delete.)
[x]    .dont scope sections by user on index action. users should be able to see all sections
[x]  -ratings:
[x]    .show rating action, scope by user
[x]  -watched: create watched controller
[x]    .create a watched controller, instead of having the info in the video controller, if you do this then move the ratings info into the video controller as well.
[x]    .set video, user, watched attribute
[x]    .use build in th new and create action.
[x]    .scope watched to user, only one allowed per user. redirect with errors when one is already present and user tries to create it anyway
[x]5. edit views to reflect controller changes
[x]  -videos:
[x]    .show view status edited to reflect the info from the join table
[x]    .add border color to indicate view status on video show view
[x]    .edit ratings to reflect the join table. Show your ratings with reason. 
[x]    .Add an average rating from other users.
[x]  -sections:
[x]    .make sure to add the view check mark from font awesome to the section view
[x]  -user page? 
[x]    .allow admins to change the status of another user to flatiron student 
[x]6. add stats & study suggestion page 
[x]  .general video total count
[x]  .flatiron video total count
[x]  .general video watched count
[x]  .private video watched count
[x]  .progress bar for general videos - http://getbootstrap.com/components/#progress
[x]  .progress bar for private videos - http://getbootstrap.com/components/#progress
[x]  .most watched videos (top 10 by everyone)  
[x]  .hardest videos (top 10 rated 5 by everyone)
[x]  .videos you rated 5-difficult, in order to study topics that were already hard for you (study_suggestions)
[x]7. edit views for final look
[x]  - all pages: 
[x]    .show what type of user you are.
[x]    .make view for the secret stats pages
[x]    .style all links with black letters and green underline? or all green with green underline?
[x]    .style titles h1 and h2 green and numbers in the section page green as well.
[x]    .style h3 black
[x]    .add footer
[x]  - section page
[x]    .only show the cohorts if you are a flatiron student
[x]  - video show
[x]    .call reason 'notes' to yourself.
[x]7. Add conditionals to views
[x]    .if ratings present, show, else nothing
[x]    .if no one has rated a video show empty stars
[x]8. test views
[x]    .stats page
[x]      .when you have seen 0 flatiron videos
[x]      .when you have seen 0 general videos
[x]      .0 most watched videos
[x]      .less than 10, most watched videos
[x]      .top 10 most watched videos
[x]      .0 hardest videos (5 stars)
[x]      .less than 10, hardest  videos
[x]      .top 10 hardest videos
[x]      .when you have rated 0 videos with 5 stars
[x]      .when you have rated some videos with 5 stars, to watch again
[x]    .sections page
[x]      .name all general and public videos, general videos for consistency in code bc "public" interferes with the public method
[x]      .show general videos in 2 rows, make them dynamic
[x]    .create video rating page
[x]      .show error when the text area is empty
[x]      . use pundit permissions on needed actions 
[x]9. Admin users panel
[x]    .make a route and mark it in spec file
[x]10. spec.md requirements
[x]    .make a route for a class level scope and a page to fulfill reqs. stats page does not count
[x]   .include nested resource index
[x]    .include a nested form writing to an associated model using a custom attribute writer, make sure to use nested url
[x]       -build a "add a video to this section" to meet this requirement
[x]       -button right by the edit/delete section buttons
[x]       -must have a nested url
[x]       -must have a custom writer: uses section custom writer that was previously written

refactor:
[x] organize css and note what is doing what
[x] note work on controllers
[x]refactor views 
  [x]refactor repeated views into partials
  [x]refactor db logic to controllers and only have variables
  [x]move logic that formats views and has to be shared in more than one spot into helpers
[x]refactor controllers
  [x]move db logic to models and use method names
[x]abstract code in model    
  
[] add 2 general videos per section to seed file
[x] make a request button to request flatiron status.
[x] apply the request button
[x] note everything
[x] check all files for duplicate code, and refactor it.

extras:
build feature to request status change.

*** Determine:
-videos
  -who can add a video? : Anybody
  -who can edit a video? :only the admin, regular user's can only report a problem with the video
  -who can delete a video? :only the admin, regular user's can only report a problem with the video
  -will you need videos to have user_id for permissions? no you can use permissions instead.
  -how many ratings will you be allowed to leave a video?: only one
  -are video ratings reasons from other users useful to you? :maybe, but only yours should show
  -who can delete sections? only when they are empty?: admins only, once they are empty.
















