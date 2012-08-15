# -*- encoding : utf-8 -*-
class AddIndexToFeedEntryGuid < ActiveRecord::Migration
  def change
    add_index :feed_entries, :guid
  end
end
