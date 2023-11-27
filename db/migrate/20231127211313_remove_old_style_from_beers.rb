class RemoveOldStyleFromBeers < ActiveRecord::Migration[7.0]
  change_table :beers do |t|
    t.remove :old_style
  end
end
