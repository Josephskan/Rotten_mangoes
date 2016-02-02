class AddColumnToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :upload_movie_image, :string
  end
end
