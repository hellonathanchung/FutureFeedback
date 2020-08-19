class RemovePostIdFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :post_id, :integer
  end
end
