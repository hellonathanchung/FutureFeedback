class DropPostTagsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :posts_tags
  end
end
