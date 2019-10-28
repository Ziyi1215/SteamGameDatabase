class Support < ApplicationRecord
  belongs_to :game
  belongs_to :language

  def Support.delete_record(game_id)
    supports = Support.where(game_id: game_id).find_each
    supports.each do |support|
      Support.destroy(support.id)
    end
  end

  def Support.create_record(game_id, language_ids)
    if language_ids != nil
      language_ids.each do |language_id|
        Support.create language_id: language_id, game_id: game_id
      end
    end
  end
end
