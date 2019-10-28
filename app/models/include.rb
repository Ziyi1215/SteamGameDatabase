class Include < ApplicationRecord
  belongs_to :game
  belongs_to :package

  def Include.delete_record(package_id)
    includes = Include.where(package_id: package_id).find_each
    includes.each do |include|
      Include.destroy(include.id)
    end
  end

  def Include.create_record(game_ids, package_id)
    if game_ids != nil
      game_ids.each do |game_id|
        Include.create game_id: game_id, package_id: package_id
      end
    end
  end
end
