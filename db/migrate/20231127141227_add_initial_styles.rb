class AddInitialStyles < ActiveRecord::Migration[7.0]
  def up
    Beer.all.map(&:style).uniq.each do |s|
      Style.create(name: s, description: "A beer style.")
    end
  end

  def down
    Style.delete_all
  end
end
