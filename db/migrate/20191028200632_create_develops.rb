class CreateDevelops < ActiveRecord::Migration[5.1]
  def change
    create_table :develops do |t|
      t.belongs_to :developer, index: true
      t.belongs_to :game, index: true, unique: true

      t.timestamps
    end
  end
end
