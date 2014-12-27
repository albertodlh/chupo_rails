class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false, default: "", index: true, unique: true
      t.text :content, null: false, default: ""
      t.datetime :pubdate, index: true

      t.timestamps null: false
    end
  end
end
