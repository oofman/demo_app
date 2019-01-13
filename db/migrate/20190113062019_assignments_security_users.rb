class AssignmentsSecurityUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :champions_tags, :id => false do |t|
      t.integer :champion_id
      t.integer :tag_id
    end
  end
end
