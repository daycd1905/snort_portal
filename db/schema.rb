# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_26_093144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data", primary_key: ["sid", "cid"], force: :cascade do |t|
    t.integer "sid", null: false
    t.bigint "cid", null: false
    t.text "data_payload"
  end

  create_table "detail", primary_key: "detail_type", id: :integer, limit: 2, default: nil, force: :cascade do |t|
    t.text "detail_text", null: false
  end

  create_table "encoding", primary_key: "encoding_type", id: :integer, limit: 2, default: nil, force: :cascade do |t|
    t.text "encoding_text", null: false
  end

  create_table "event", primary_key: ["sid", "cid"], force: :cascade do |t|
    t.integer "sid", null: false
    t.bigint "cid", null: false
    t.integer "signature", null: false
    t.datetime "timestamp", null: false
    t.index ["signature"], name: "signature_idx"
    t.index ["timestamp"], name: "timestamp_idx"
  end

  create_table "icmphdr", primary_key: ["sid", "cid"], force: :cascade do |t|
    t.integer "sid", null: false
    t.bigint "cid", null: false
    t.integer "icmp_type", limit: 2, null: false
    t.integer "icmp_code", limit: 2, null: false
    t.integer "icmp_csum"
    t.integer "icmp_id"
    t.integer "icmp_seq"
    t.index ["icmp_type"], name: "icmp_type_idx"
  end

  create_table "iphdr", primary_key: ["sid", "cid"], force: :cascade do |t|
    t.integer "sid", null: false
    t.bigint "cid", null: false
    t.bigint "ip_src", null: false
    t.bigint "ip_dst", null: false
    t.integer "ip_ver", limit: 2
    t.integer "ip_hlen", limit: 2
    t.integer "ip_tos", limit: 2
    t.integer "ip_len"
    t.integer "ip_id"
    t.integer "ip_flags", limit: 2
    t.integer "ip_off"
    t.integer "ip_ttl", limit: 2
    t.integer "ip_proto", limit: 2, null: false
    t.integer "ip_csum"
    t.index ["ip_dst"], name: "ip_dst_idx"
    t.index ["ip_src"], name: "ip_src_idx"
  end

  create_table "opt", primary_key: ["sid", "cid", "optid"], force: :cascade do |t|
    t.integer "sid", null: false
    t.bigint "cid", null: false
    t.integer "optid", limit: 2, null: false
    t.integer "opt_proto", limit: 2, null: false
    t.integer "opt_code", limit: 2, null: false
    t.integer "opt_len"
    t.text "opt_data"
  end

  create_table "permission_users", force: :cascade do |t|
    t.integer "permission_id"
    t.integer "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["permission_id", "role_id"], name: "index_permission_users_on_permission_id_and_role_id"
    t.index ["permission_id"], name: "index_permission_users_on_permission_id"
    t.index ["role_id"], name: "index_permission_users_on_role_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "subject_class"
    t.string "action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reference", primary_key: "ref_id", id: :serial, force: :cascade do |t|
    t.integer "ref_system_id", null: false
    t.text "ref_tag", null: false
  end

  create_table "reference_system", primary_key: "ref_system_id", id: :serial, force: :cascade do |t|
    t.text "ref_system_name"
  end

  create_table "role_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_role_users_on_role_id"
    t.index ["user_id", "role_id"], name: "index_role_users_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_role_users_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schema", primary_key: "vseq", id: :integer, default: nil, force: :cascade do |t|
    t.datetime "ctime", null: false
  end

  create_table "sensor", primary_key: "sid", id: :serial, force: :cascade do |t|
    t.text "hostname"
    t.text "interface"
    t.text "filter"
    t.integer "detail", limit: 2
    t.integer "encoding", limit: 2
    t.bigint "last_cid", null: false
  end

  create_table "sig_class", primary_key: "sig_class_id", id: :serial, force: :cascade do |t|
    t.text "sig_class_name", null: false
    t.index ["sig_class_name"], name: "sig_class_name_idx"
  end

  create_table "sig_reference", primary_key: ["sig_id", "ref_seq"], force: :cascade do |t|
    t.integer "sig_id", null: false
    t.integer "ref_seq", null: false
    t.integer "ref_id", null: false
  end

  create_table "signature", primary_key: "sig_id", id: :serial, force: :cascade do |t|
    t.text "sig_name", null: false
    t.bigint "sig_class_id"
    t.bigint "sig_priority"
    t.bigint "sig_rev"
    t.bigint "sig_sid"
    t.bigint "sig_gid"
    t.index ["sig_class_id"], name: "sig_class_idx"
    t.index ["sig_name"], name: "sig_name_idx"
  end

  create_table "snort_rules", force: :cascade do |t|
    t.string "action"
    t.string "protocol"
    t.string "src_address"
    t.string "src_port"
    t.string "direction"
    t.string "dest_address"
    t.string "dest_port"
    t.boolean "status", default: true
    t.text "options", default: "{}"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action"], name: "index_snort_rules_on_action"
    t.index ["dest_address"], name: "index_snort_rules_on_dest_address"
    t.index ["dest_port"], name: "index_snort_rules_on_dest_port"
    t.index ["protocol"], name: "index_snort_rules_on_protocol"
    t.index ["src_address"], name: "index_snort_rules_on_src_address"
    t.index ["src_port"], name: "index_snort_rules_on_src_port"
    t.index ["status"], name: "index_snort_rules_on_status"
  end

  create_table "tcphdr", primary_key: ["sid", "cid"], force: :cascade do |t|
    t.integer "sid", null: false
    t.bigint "cid", null: false
    t.integer "tcp_sport", null: false
    t.integer "tcp_dport", null: false
    t.bigint "tcp_seq"
    t.bigint "tcp_ack"
    t.integer "tcp_off", limit: 2
    t.integer "tcp_res", limit: 2
    t.integer "tcp_flags", limit: 2, null: false
    t.integer "tcp_win"
    t.integer "tcp_csum"
    t.integer "tcp_urp"
    t.index ["tcp_dport"], name: "tcp_dport_idx"
    t.index ["tcp_flags"], name: "tcp_flags_idx"
    t.index ["tcp_sport"], name: "tcp_sport_idx"
  end

  create_table "udphdr", primary_key: ["sid", "cid"], force: :cascade do |t|
    t.integer "sid", null: false
    t.bigint "cid", null: false
    t.integer "udp_sport", null: false
    t.integer "udp_dport", null: false
    t.integer "udp_len"
    t.integer "udp_csum"
    t.index ["udp_dport"], name: "udp_dport_idx"
    t.index ["udp_sport"], name: "udp_sport_idx"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "phone"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
