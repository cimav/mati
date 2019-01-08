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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_08_000436) do

  create_table "activity_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "agent_id"
    t.string "element_type"
    t.integer "element_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "changed_values"
    t.index ["agent_id"], name: "index_activity_logs_on_agent_id"
  end

  create_table "agents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "agent_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.integer "status"
  end

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "agent_id"
    t.string "element_type"
    t.integer "element_id"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_attachments_on_agent_id"
  end

  create_table "contract_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "contract_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_contract_items_on_contract_id"
    t.index ["item_id"], name: "index_contract_items_on_item_id"
  end

  create_table "contract_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.bigint "contract_type_id"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "notify_days"
    t.string "notify_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "cost", precision: 8, scale: 2
    t.integer "status"
    t.index ["contract_type_id"], name: "index_contracts_on_contract_type_id"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
  end

  create_table "item_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "item_field_id"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_field_id"], name: "index_item_data_on_item_field_id"
    t.index ["item_id"], name: "index_item_data_on_item_id"
  end

  create_table "item_fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "field_type"
    t.text "values"
    t.string "default"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_type_id"
  end

  create_table "item_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "relationship_id"
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["relationship_id"], name: "index_item_relationships_on_relationship_id"
  end

  create_table "item_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.bigint "item_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_type_id"], name: "index_item_types_on_item_type_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "item_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identificator"
    t.integer "impact"
    t.integer "location_id"
    t.integer "department_id"
    t.integer "used_by"
    t.integer "managed_by"
    t.datetime "assigned_on"
    t.boolean "is_loanable"
    t.index ["item_type_id"], name: "index_items_on_item_type_id"
  end

  create_table "loans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "item_id"
    t.text "notes"
    t.date "return_date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_loans_on_item_id"
    t.index ["person_id"], name: "index_loans_on_person_id"
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "address"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_locations_on_location_id"
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "email"
    t.string "phone"
    t.integer "department_id"
    t.bigint "person_id"
    t.string "timezone"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "last_name2"
    t.string "person_type"
    t.string "identificator"
    t.index ["location_id"], name: "index_people_on_location_id"
    t.index ["person_id"], name: "index_people_on_person_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "inverse"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_collaborators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "ticket_id"
    t.bigint "agent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_ticket_collaborators_on_agent_id"
    t.index ["ticket_id"], name: "index_ticket_collaborators_on_ticket_id"
  end

  create_table "ticket_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "ticket_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_ticket_items_on_item_id"
    t.index ["ticket_id"], name: "index_ticket_items_on_ticket_id"
  end

  create_table "ticket_responses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "ticket_id"
    t.integer "from"
    t.integer "to"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_responses_on_ticket_id"
  end

  create_table "tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "person_id"
    t.bigint "service_id"
    t.text "description"
    t.integer "status"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "identificator"
    t.integer "consecutive"
    t.index ["agent_id"], name: "index_tickets_on_agent_id"
    t.index ["person_id"], name: "index_tickets_on_person_id"
    t.index ["service_id"], name: "index_tickets_on_service_id"
  end

  create_table "vendors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "contact"
    t.string "email"
    t.string "phone"
    t.string "url"
    t.text "description"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "item_relationships", "relationships"
  add_foreign_key "items", "item_types"
end
