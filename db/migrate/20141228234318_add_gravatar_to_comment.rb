class AddGravatarToComment < ActiveRecord::Migration
  def change
    add_column :comments, :gravatar, :text, null: false, default: ""
  end
end
