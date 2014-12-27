class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title, null: false, default: ""
      t.string :youtube_id, null: false, default: ""

      t.timestamps null: false
    end
  end
end
