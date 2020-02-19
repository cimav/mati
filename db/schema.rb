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

ActiveRecord::Schema.define(version: 2020_02_19_194057) do

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
    t.bigint "person_id"
    t.integer "agent_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.index ["person_id"], name: "index_agents_on_person_id"
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

  create_table "aux", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "i", default: 0, null: false
    t.string "p", limit: 282
  end

  create_table "change_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "change_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["change_id"], name: "index_change_items_on_change_id"
    t.index ["item_id"], name: "index_change_items_on_item_id"
  end

  create_table "change_problems", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "change_id"
    t.bigint "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["change_id"], name: "index_change_problems_on_change_id"
    t.index ["problem_id"], name: "index_change_problems_on_problem_id"
  end

  create_table "change_responses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "change_id"
    t.integer "from"
    t.integer "to"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["change_id"], name: "index_change_responses_on_change_id"
  end

  create_table "change_tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "change_id"
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["change_id"], name: "index_change_tickets_on_change_id"
    t.index ["ticket_id"], name: "index_change_tickets_on_ticket_id"
  end

  create_table "changes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "consecutive"
    t.string "identificator"
    t.bigint "agent_id"
    t.bigint "person_id"
    t.text "description"
    t.text "reason"
    t.text "impact"
    t.text "rollout_plan"
    t.text "backout_plan"
    t.integer "change_type"
    t.integer "risk_type"
    t.date "start_date_planned"
    t.date "end_date_planned"
    t.date "start_date_real"
    t.date "end_date_real"
    t.integer "status"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_changes_on_agent_id"
    t.index ["person_id"], name: "index_changes_on_person_id"
  end

  create_table "ci", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "id", default: 0, null: false
    t.string "af01_cve_interna", limit: 18, collation: "latin1_swedish_ci"
    t.string "identificator"
    t.integer "af01_fecha_compra"
    t.decimal "af01_costo", precision: 14, scale: 2
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
    t.boolean "has_access_controls"
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
    t.integer "received_by"
    t.date "received_date"
    t.text "return_notes"
    t.integer "loaned_by"
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
    t.string "path"
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

  create_table "permissions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "person_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "agent_id"
    t.integer "status"
    t.datetime "removed_date"
    t.text "removed_notes"
    t.integer "removed_by"
    t.index ["item_id"], name: "index_permissions_on_item_id"
    t.index ["person_id"], name: "index_permissions_on_person_id"
  end

  create_table "problem_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "problem_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_problem_items_on_item_id"
    t.index ["problem_id"], name: "index_problem_items_on_problem_id"
  end

  create_table "problem_responses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "problem_id"
    t.integer "from"
    t.integer "to"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_problem_responses_on_problem_id"
  end

  create_table "problem_tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "problem_id"
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_problem_tickets_on_problem_id"
    t.index ["ticket_id"], name: "index_problem_tickets_on_ticket_id"
  end

  create_table "problems", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "consecutive"
    t.string "identificator"
    t.bigint "agent_id"
    t.bigint "person_id"
    t.text "description"
    t.text "cause"
    t.text "impact"
    t.text "symptom"
    t.text "solution"
    t.integer "status"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_problems_on_agent_id"
    t.index ["person_id"], name: "index_problems_on_person_id"
  end

  create_table "project_changes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "change_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["change_id"], name: "index_project_changes_on_change_id"
    t.index ["project_id"], name: "index_project_changes_on_project_id"
  end

  create_table "project_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_project_items_on_item_id"
    t.index ["project_id"], name: "index_project_items_on_project_id"
  end

  create_table "project_problems", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_project_problems_on_problem_id"
    t.index ["project_id"], name: "index_project_problems_on_project_id"
  end

  create_table "project_tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "project_id"
    t.date "start_date"
    t.date "due_date"
    t.string "description"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "agent_id"
    t.index ["project_id"], name: "index_project_tasks_on_project_id"
  end

  create_table "project_tickets", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_tickets_on_project_id"
    t.index ["ticket_id"], name: "index_project_tickets_on_ticket_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "consecutive"
    t.string "identificator"
    t.bigint "agent_id"
    t.bigint "person_id"
    t.text "description"
    t.date "start_date_planned"
    t.date "end_date_planned"
    t.date "start_date_real"
    t.date "end_date_real"
    t.integer "priority"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_projects_on_agent_id"
    t.index ["person_id"], name: "index_projects_on_person_id"
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

  create_table "surveys", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "ticket_id"
    t.integer "rating"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.index ["ticket_id"], name: "index_surveys_on_ticket_id"
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

  create_table "tokens", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "xxx", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "af01_cve_interna", limit: 18, collation: "latin1_swedish_ci"
    t.integer "af01_fecha_compra"
    t.decimal "af01_costo", precision: 14, scale: 2
  end

  add_foreign_key "item_relationships", "relationships"
  add_foreign_key "items", "item_types"
end
