class ShareBelongsToUser < ActiveRecord::Migration
  def change
    add_reference :shares, :user, index: true
  end
end
