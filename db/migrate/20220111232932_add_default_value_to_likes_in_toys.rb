class AddDefaultValueToLikesInToys < ActiveRecord::Migration[6.1]
  def change
    change_column :toys, :likes, :integer, :default => 0
  end
end
