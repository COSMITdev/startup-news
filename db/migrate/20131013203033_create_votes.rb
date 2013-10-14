class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :news, index: true
      t.boolean :is_up, null: false, default: true
      t.string :ip, null: false, default: ""

      t.timestamps
    end
  end
end
