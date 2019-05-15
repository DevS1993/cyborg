require 'digest'
require 'base64'

class EnHash

  def self.hashIt param_string
    Digest::SHA1.hexdigest param_string
  end

  def self.encodeIt param_string
    Base64.urlsafe_encode64(param_string)
  end

  def self.decodeIt(secure_response)
    Base64.urlsafe_decode64(secure_response)
  end

end