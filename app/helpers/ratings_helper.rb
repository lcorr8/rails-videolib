module RatingsHelper
  def rating_stars(rating)
    Rating.find(rating.id).stars
  end
end
