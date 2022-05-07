class AddSteamNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :steam_name, :string
  end
end
