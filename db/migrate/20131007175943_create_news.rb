class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :user, index: true
      t.string :title, null: false, default: ''
      t.text :link   , null: false, default: ''
      t.text :text

      t.timestamps
    end
  end
end
