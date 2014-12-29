class ChangesGravatarFieldType < ActiveRecord::Migration
  def change
    change_column :comments, :gravatar, :string, null: false, default: ""
  end
end
