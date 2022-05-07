module Encryptor
  class Encryptor
    class << self
      def encrypt(message)
        ActiveSupport::MessageEncryptor.new(chat_key).encrypt_and_sign(message)
      end

      def decrypt(message)
        ActiveSupport::MessageEncryptor.new(chat_key).decrypt_and_verify(message)
      end

      def chat_key
        Rails.application.credentials.user_chat_key
      end
    end
  end
end