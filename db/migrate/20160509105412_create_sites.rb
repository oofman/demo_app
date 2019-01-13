class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :key, null: false

      t.timestamps
    end

    add_index :sites, :key, unique: true
  end
end
