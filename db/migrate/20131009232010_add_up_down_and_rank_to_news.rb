class AddUpDownAndRankToNews < ActiveRecord::Migration
  def change
    add_column :news, :up, :integer, null: false, default: 0
    add_column :news, :down, :integer, null: false, default: 0
    add_column :news, :rank, :float, null: false, default: 0
  end
end
