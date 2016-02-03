class SearchController < ApplicationController

  def index
    @movie_list = Movie.find_by_sql(Movie.where("title like ?", "%#{params[:title]}%").to_sql)
  end
end
