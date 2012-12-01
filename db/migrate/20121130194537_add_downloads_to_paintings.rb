class AddDownloadsToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :downloads, :integer
  end
end
