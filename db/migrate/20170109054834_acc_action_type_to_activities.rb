class AccActionTypeToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :action_type, :integer
  end
end
