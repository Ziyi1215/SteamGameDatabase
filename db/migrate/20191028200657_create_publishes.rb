class CreatePublishes < ActiveRecord::Migration[5.1]
  def change
    create_table :publishes do |t|
      t.belongs_to :publisher, index: true
      t.belongs_to :game, index: true, unique: true

      t.timestamps
    end
  end
end
