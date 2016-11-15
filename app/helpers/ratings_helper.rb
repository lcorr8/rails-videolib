module RatingsHelper
  def rating_stars(rating)
    Rating.find(rating.rating_id).stars
  end
end
