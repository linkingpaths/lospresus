# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100418114814) do

  create_table "capitulos", :force => true do |t|
    t.integer  "presupuesto_id"
    t.integer  "capitulo"
    t.decimal  "ingresos",       :precision => 10, :scale => 2
    t.decimal  "gastos",         :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "capitulos", ["presupuesto_id", "capitulo"], :name => "index_capitulos_on_presupuesto_id_and_capitulo"

  create_table "demograficas", :force => true do |t|
    t.integer  "municipio_id"
    t.integer  "ano"
    t.integer  "total"
    t.integer  "mujeres"
    t.integer  "hombres"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "demograficas", ["ano"], :name => "index_demograficas_on_ano"

  create_table "municipios", :force => true do |t|
    t.string   "nombre"
    t.string   "provincia"
    t.integer  "codigo_ine"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "municipios", ["codigo_ine"], :name => "index_municipios_on_codigo_ine"

  create_table "presupuestos", :force => true do |t|
    t.integer  "municipio_id"
    t.integer  "ano"
    t.decimal  "total_ingresos"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total_gastos",   :precision => 10, :scale => 2
  end

  add_index "presupuestos", ["ano"], :name => "index_presupuestos_on_ano"
  add_index "presupuestos", ["municipio_id"], :name => "index_presupuestos_on_municipio_id"

end
