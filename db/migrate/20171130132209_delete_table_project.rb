class DeleteTableProject < ActiveRecord::Migration[5.1]
  def change
  	drop_table :projects,force: :cascade
  end
end
