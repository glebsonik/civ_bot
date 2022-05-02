class AddChatIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :chat_name, :string
  end
end
