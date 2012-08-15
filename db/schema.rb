# -*- encoding : utf-8 -*-
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120814152423) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "icon"
    t.string   "slug"
    t.integer  "companies_count", :default => 0, :null => false
  end

  add_index "categories", ["id", "lft", "rgt"], :name => "index_categories_on_id_and_lft_and_rgt"
  add_index "categories", ["lft", "id"], :name => "index_categories_on_lft_and_id"
  add_index "categories", ["name", "lft"], :name => "index_categories_on_name_and_lft"
  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true
  add_index "categories", ["parent_id", "lft", "rgt"], :name => "index_categories_on_parent_id_and_lft_and_rgt"
  add_index "categories", ["parent_id", "name", "lft"], :name => "index_categories_on_parent_id_and_name_and_lft"
  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["slug"], :name => "index_categories_on_slug"
  add_index "categories", ["updated_at"], :name => "index_categories_on_updated_at"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "direccion"
    t.string   "tel"
    t.integer  "category_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "cel"
    t.string   "otro_contacto"
    t.string   "misc"
    t.string   "homepage"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "piso"
    t.string   "depto"
    t.string   "ciudad"
    t.string   "provincia"
    t.string   "slug"
  end

  add_index "companies", ["category_id"], :name => "index_companies_on_category_id"
  add_index "companies", ["cel"], :name => "index_companies_on_cel"
  add_index "companies", ["direccion"], :name => "index_companies_on_direccion"
  add_index "companies", ["homepage"], :name => "index_companies_on_homepage"
  add_index "companies", ["name"], :name => "index_companies_on_name", :unique => true
  add_index "companies", ["slug"], :name => "index_companies_on_slug"
  add_index "companies", ["tel"], :name => "index_companies_on_tel"

  create_table "feed_entries", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.string   "hashe"
    t.string   "source"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "feed_entries", ["guid"], :name => "index_feed_entries_on_guid"
  add_index "feed_entries", ["source", "guid"], :name => "index_feed_entries_on_source_and_guid"
  add_index "feed_entries", ["source"], :name => "index_feed_entries_on_source"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
