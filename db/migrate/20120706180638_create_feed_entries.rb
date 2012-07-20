# -*- encoding : utf-8 -*-
class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.string :name
      t.text :summary
      t.string :url
      t.datetime :published_at
      t.string :guid
      t.string :hash
      t.string :sourse

      t.timestamps
    end
  end
end
