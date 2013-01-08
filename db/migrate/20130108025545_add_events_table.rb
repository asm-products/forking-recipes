class AddEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |e|
      e.references :user
      e.references :recipe
      e.text :action

      e.timestamps
    end
  end
end
