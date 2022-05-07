class AddSilentModeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :silent_mode, :boolean, default: false
  end
end
