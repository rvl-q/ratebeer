class RenameStyleFromBeers < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :beers, :style, :old_style
  end

  def self.down
    rename_column :beers, :old_style, :style
  end
end
