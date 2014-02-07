class AddHeaderContentToShare < ActiveRecord::Migration
  def change
    add_column :shares, :header_content, :string
  end
end
