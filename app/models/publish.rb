class Publish < ApplicationRecord
  belongs_to :game
  belongs_to :publisher

  def Publish.delete_record(publisher_id)
    publishers = Publish.where(publisher_id: publisher_id).find_each
    publishers.each do |publisher|
      Publish.destroy(publisher.id)
    end
  end
end
