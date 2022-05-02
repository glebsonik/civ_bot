class User < ApplicationRecord
  validates_presence_of :username, :chat_name
  validates_uniqueness_of :username
end