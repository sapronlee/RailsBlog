# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120820032454) do

  create_table "albums", :force => true do |t|
    t.string   "name",          :limit => 30,                 :null => false
    t.integer  "permission_cd", :limit => 1,                  :null => false
    t.string   "description",   :limit => 200
    t.string   "password",      :limit => 100
    t.integer  "photos_count",                 :default => 0
    t.integer  "cover",                        :default => 0
    t.integer  "is_default",                   :default => 0
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "albums", ["name"], :name => "index_albums_on_name", :unique => true

  create_table "blogs", :force => true do |t|
    t.integer  "category_id"
    t.string   "title",       :limit => 200,                :null => false
    t.string   "keywords",    :limit => 100
    t.string   "description", :limit => 100
    t.text     "body",                                      :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "user_id",                    :default => 0
  end

  create_table "categories", :force => true do |t|
    t.string   "name",        :limit => 100,                :null => false
    t.string   "url",         :limit => 50,                 :null => false
    t.string   "slug",        :limit => 100,                :null => false
    t.integer  "order",                      :default => 0
    t.integer  "blogs_count",                :default => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true
  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true
  add_index "categories", ["url"], :name => "index_categories_on_url", :unique => true

  create_table "logs", :force => true do |t|
    t.integer  "recordable_id"
    t.string   "recordable_type"
    t.string   "action",          :limit => 50
    t.string   "message",         :limit => 500
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "media", :force => true do |t|
    t.string   "name",                    :limit => 30,                 :null => false
    t.string   "description",             :limit => 200
    t.string   "attachment",                                            :null => false
    t.string   "attachment_name"
    t.integer  "attachment_size",                        :default => 0
    t.string   "attachment_content_type"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "album_id"
    t.string   "name",               :limit => 30,                 :null => false
    t.string   "description",        :limit => 200
    t.string   "image",                                            :null => false
    t.string   "image_name"
    t.integer  "image_size",                        :default => 0
    t.string   "image_content_type"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

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

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "real_name",  :limit => 20
    t.string   "phone",      :limit => 11
    t.date     "birthday"
    t.integer  "gender_cd",                :default => 0
    t.integer  "title_cd",                 :default => 0
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "", :null => false
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
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
