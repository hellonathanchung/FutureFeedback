class RemovePostIdFromTags < ActiveRecord::Migration[6.0]
  def change
    remove_index :tags, :post_id
    remove_column :tags, :post_id, :string
  end
end
