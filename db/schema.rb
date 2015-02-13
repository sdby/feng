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

ActiveRecord::Schema.define(:version => 20150126085340) do

  create_table "applications", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "job_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "applications", ["employee_id", "job_id"], :name => "index_applications_on_employee_id_and_job_id", :unique => true
  add_index "applications", ["employee_id"], :name => "index_applications_on_employee_id"
  add_index "applications", ["job_id"], :name => "index_applications_on_job_id"

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "resume"
    t.string   "attachment"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "employees", ["email"], :name => "index_employees_on_email", :unique => true
  add_index "employees", ["remember_token"], :name => "index_employees_on_remember_token"

  create_table "employers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "contact"
    t.string   "phone"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "employers", ["email"], :name => "index_employers_on_email", :unique => true
  add_index "employers", ["remember_token"], :name => "index_employers_on_remember_token"

  create_table "jobs", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "employer_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "status",      :default => true
  end

  add_index "jobs", ["employer_id", "created_at"], :name => "index_jobs_on_employer_id_and_created_at"

end
