
#test users sections
Section.create(:id => 1, :name => "hedwig", :user_id => 1)
Section.create(:id => 2, :name => "harry potter", :user_id => 1)

#test users videos
Video.create(:id => 1, :name => "wig in a box", :link => "https://www.youtube.com/watch?v=E5V7_PSD4Sc",:year => "2015", :watched => "no", :section_id => 1, :user_id => 1)
Video.create(:id => 2, :name => "Sugar Daddy", :link => "https://www.youtube.com/watch?v=uIaFn5lsLd8",:year => "2015", :watched => "no", :section_id => 1, :user_id => 1) 
Video.create(:id => 3, :name => "fantastic beasts and where to find them", :link => "link", :year => "2015", :watched => "no", :section_id => 2, :user_id => 1)

#test ratings, only 5 available. 1 = easy, 5 = hard
Rating.create(:id => 1, :stars => 1)
Rating.create(:id => 2, :stars => 2)
Rating.create(:id => 3, :stars => 3)
Rating.create(:id => 4, :stars => 4)
Rating.create(:id => 5, :stars => 5)
