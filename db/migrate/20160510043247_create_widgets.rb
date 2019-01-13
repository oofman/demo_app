class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :type, null: false
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
