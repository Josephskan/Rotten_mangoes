class SearchController < ApplicationController

  def index
    # @movie_list = Movie.find_by_sql(Movie.where("title like ? Where director like ? OR runtime_in_minutes  ", 
    #   search_query(params[:title]), search_query(params[:director]), search_time(params[:runtime_in_min]) ).to_sql)
    # @time = params[:runtime_in_min]

    # @movie_list = Movie.all
    # if params[:title]
    #   @movie_list.where("title like ?", search_query(params[:title]))
    # end
    # if params[:director]
    #   @movie_list.where("director like ?", search_query(params[:director]))
    # end
    # @movie_list.where(search_time(params[:runtime_in_min]))

    # @movie_list = (Movie.where("title like ?", search_query(params[:title])).where("director like ?", search_query(params[:director]))).where(search_time(params[:runtime_in_min]))
  
    @movie_list = Movie.search_all(params[:term]).where(search_time(params[:runtime_in_min]))
  end

  protected

  def search_time(query)
    if query == '1'
      "runtime_in_minutes > 0"
    elsif query == '2'
      "runtime_in_minutes <= 90"
    elsif query == '3'
      "runtime_in_minutes >= 90 AND runtime_in_minutes <= 120"
    elsif query == '4'
      "runtime_in_minutes >= 120 "
    end    
  end
end
