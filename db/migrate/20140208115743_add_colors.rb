class AddColors < ActiveRecord::Migration
  def change
    add_column :shares, :header_background_color, :string
    add_column :shares, :header_text_color, :string
  end
end
