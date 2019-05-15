require 'openssl'

require_relative 'EnHash'

class Crypt
  KEY = "Q9fbkBF8au24C9wshGRW9ut8ecYpyXye5vhFLtHFdGjRg3a4HxPYRfQaKutZx5N4"
  IV = "qwertyuiopasdfghjklzxcvbnm"
  # KEY & IV should both be ENV variables

  def self.encrypt_and_encode param_string
    cipher = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.encrypt
    cipher.key = KEY
    cipher.iv = IV
    cipher_text = cipher.update(param_string) + cipher.final
    EnHash.encodeIt(cipher_text)
  end

  def self.decode_and_decrypt secure_response
    to_decrypt = EnHash.decodeIt(secure_response)
    cipher = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.decrypt
    cipher.key = KEY
    cipher.iv = IV
    cipher_text = cipher.update(to_decrypt) + cipher.final
  end
end
