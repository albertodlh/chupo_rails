class AddTagToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tag, :string, null: false, default: ""
  end
end
