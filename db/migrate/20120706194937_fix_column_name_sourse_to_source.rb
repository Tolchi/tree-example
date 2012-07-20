# -*- encoding : utf-8 -*-
class FixColumnNameSourseToSource < ActiveRecord::Migration
  def change
    rename_column :feed_entries, :sourse, :source
  end
end
