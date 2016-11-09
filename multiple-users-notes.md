
1.remove extra attributes from tables
  -videos:
    .watched: this will now be a join table
    .embed_link: this is now created dynamically with an iframe, no need to store it in the db in order to display the video.
    .notes_ids: ot currently using the notes model, only using the ratings
  -users:
    .section_ids: do i need this? how will the section model relate to the video model? section's have videos, videos belong to sections
  -sections:
    .user_id: sections don't have user's now, they belong to everybody and everybody can see them?   
    .video_ids: AR takes care of this, so it's not needed. 
