class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :content_url
      t.string :header_url

      t.timestamps
    end
  end
end
