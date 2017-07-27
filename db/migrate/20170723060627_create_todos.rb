class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :title

      t.timestamps
    end
    add_reference :todos, :creator, references: :users
    add_foreign_key :todos, :users, column: :creator_id
  end
end
