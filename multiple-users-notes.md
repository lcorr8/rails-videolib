
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

[]6. add stats & study suggestion page 
[x]  .general video total count
[x]  .flatiron video total count
[x]  .general video watched count
[x]  .private video watched count
[x]  .progress bar for general videos - http://getbootstrap.com/components/#progress
[x]  .progress bar for private videos - http://getbootstrap.com/components/#progress
[x]  .most watched videos (top 10 by everyone)  
[x]  .hardest videos (top 10 rated 5 by everyone)
[x]  .videos you rated 5-difficult, in order to study topics that were already hard for you (study_suggestions)

  optional helpers:
  [] have any users rated a given video? to display 0 colored stars.   

[]7. edit views for final look
[]  - all pages: 
[x]    .show what type of user you are.
[]    .make a request button to request flatiron status.
[]    .make view for the secret stats pages
[]    .style all links with black letters and green underline? or all green with green underline?
[]    .style titles green and numbers in the section page green as well

[]7. Add conditionals to views
      . if ratings present, show, else nothing
      .if
      

  
 

*** Determine:
-videos
  -who can add a video? : Anybody
  -who can edit a video? :only the admin, regular user's can only report a problem with the video
  -who can delete a video? :only the admin, regular user's can only report a problem with the video
  -will you need videos to have user_id for permissions? no you can use permissions instead.
  -how many ratings will you be allowed to leave a video?: only one
  -are video ratings reasons from other users useful to you? :maybe, but only yours should show
  -who can delete sections? only when they are empty?: admins only, once they are empty.



Pundit:
  users, videos, sections, watched join table, ratings join table,
  - add pundit to gemfile. gem 'pundit'
  - include Pundit, in the application controller above the protect from forgery.
  -bundle install
  -run the generator rails g pundit:install
  -restart rails to pickup changes
  -stub out policies:
    normal users: are allowe to view non flatiron videos. or flatiron public videos.
    flatiron students: allowed to see private flatiron videos.
    admin: allowed to edit sections and videos.
  -create policy files in the app/policies directory.
    class VideoPolicy < ApplicationPolicy
    end
  - generate migration to add role to users table. rails generate migration AddRoleToUsers role:integer
   
  -implement the policy within the controller by using authorize.
    def update
      @video = Video.find(1)
      authorize @video
      #perform the update
      end 
  -implement the policy within the views by using the policy constructing helper pundit offers
    <% if policy(@post).update? %>
      <%= link_to "Edit post", edit_post_path(@post) %>
    <% end %> 
  -add flatiron attribute to videos so videos can be scoped by pundit.
  -implement scope by adding a class Scope < Scope inside your policy class. Then write the resolve scopes
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:published => true)
      end
    end  
  -implement the scope within the views by using the policy scope helper
    <% policy_scope(@user.videos).each do |video| %>
      <p><%= link_to video.name, video_path(video) %></p>
    <% end %>





  -add role enum to user model
  -write policy governing user model
    -normal: can read all videos and sections. can add videos and section.
    -admin: can edit, and delete all videos and sections.
  -add authentication and authorization filters to user's controller. only administrators can update or destroy users.

    












