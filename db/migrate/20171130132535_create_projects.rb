class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :projectName
      t.string :masterKey
      t.string :readKey
      t.string :writeKey
      t.string :website
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
