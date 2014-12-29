class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :user, null: false, default: "Chupo", index: true
      t.string :email, null: false, default: "", index: true
      t.string :website, null: false, default: ""
      t.text :content, null: false, default: ""
      t.datetime :pubdate
      t.string :status, null: false, default: "P"

      t.timestamps null: false
    end
  end
end
