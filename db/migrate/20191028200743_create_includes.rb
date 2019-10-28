class CreateIncludes < ActiveRecord::Migration[5.1]
  def change
    create_table :includes do |t|
      t.belongs_to :package, index: true
      t.belongs_to :game, index: true

      t.timestamps
    end
  end
end
