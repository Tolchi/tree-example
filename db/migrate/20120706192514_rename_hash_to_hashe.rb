# -*- encoding : utf-8 -*-
class RenameHashToHashe < ActiveRecord::Migration
  def change
    rename_column :feed_entries, :hash, :hashe
  end
end
