class AddIndexToFeedEntrySource < ActiveRecord::Migration
  def change
    add_index :feed_entries, :source
    add_index :feed_entries, [:source, :guid]
  end
end
