class PopulateStyleForBeers < ActiveRecord::Migration[7.0]
  def up
    Beer.all.each do |b|
      b.style_id = Style.find_by(name: b.old_style).id
      b.save
    end
  end

  def down
    Beer.all.each do |b|
      b.style_id = nil
      b.save
    end
  end
end
