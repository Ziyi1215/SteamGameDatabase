class Develop < ApplicationRecord
  belongs_to :game
  belongs_to :developer

  def Develop.delete_record(developer_id)
    develops = Develop.where(developer_id: developer_id).find_each
    develops.each do |develop|
      Develop.destroy(develop.id)
    end
  end

  def Develop.create_record(developer_id, game_ids)
    if game_ids != nil
      game_ids.each do |game_id|
        Develop.create game_id: game_id, developer_id: developer_id
      end
    end
  end
end
