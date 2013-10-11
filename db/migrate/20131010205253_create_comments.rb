class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :news, index: true
      t.string :title, null: false, default: ''
      t.text :text, null: false, default: ''

      t.timestamps
    end
  end
end
