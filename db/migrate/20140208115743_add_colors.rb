class AddColors < ActiveRecord::Migration
  def change
    add_column :shares, :header_background_color, :string, :default => '#111111'
    add_column :shares, :header_text_color, :string, :default => '#eeeeee'
  end
end
