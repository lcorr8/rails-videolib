
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

[]4. Edit controllers to reflect past changes
[]  -videos:
[x]    .remove set user from show, new. not being used
[x]    .remove watched, embed_link, notes_ids, user_id*** from video_params. not being used
[x]    .remove assignment of user in create action
[]    .change edit,update who can edit a video? who can delete a video?***
[]    .mark video watched has to move to wherever the join table controller logic goes next

[]  - sections:
[x]    .remove set user from create, . not being used.***
[x]    .remove set section from show, only allow on edit, update, destroy so users can only delete sections they have created themselves (also only when they are empty, check join table for other user's view status, if other user's have viewed the video, or plan to view it, don't delete.)
[]    .dont scope sections by user on index action. users should be able to see all sections

[]  -ratings:
[]    .show rating action, scope by user

[]  -watched: create watched controller
[]    .create a watched controller, instead of having the info in the video controller, if you do this then move the ratings info into the video controller as well.
[]    .set video and star_rating
[]    .use build in th new and create action.
[]    .scope watched to user, only one allowed per user. make sure to use find_or_create

[]5. edit views to reflect controller changes
[]  -videos:
[]    .show view status edited to reflect the info from the join table
[]    .add the view check mark from font awesome to the video show view
[]    .edit ratings to reflect the join table. Show your ratings with reason. Add an average rating from other users.
[]    .show your ratings, and an average of the other user's ratings.
[]  -sections:
[]    .make sure to add the view check mark from font awesome to the section view 
[]  -user page?  
 

*** Determine:
-videos
  -who can add a video? : Anybody
  -who can edit a video? :only the admin, regular user's can only report a problem with the video
  -who can delete a video? :only the admin, regular user's can only report a problem with the video
  -will you need videos to have user_id for permissions? no you can use permissions instead.
  -how many ratings will you be allowed to leave a video?: only one
  -are video ratings reasons from other users useful to you? :maybe, but only yours should show
  -who can delete sections? only when they are empty?: admins only, once they are empty.