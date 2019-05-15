require_relative 'User'
require_relative 'EnHash'
require_relative 'Crypt'
require_relative 'Quest'

class Main

  def self.start_exec
    params = User.getInput
  
    param_string = ""
    params.keys.each do |key|
      param_string << "#{key}=#{params[key]}|"
    end
    param_string << "hash=#{EnHash.hashIt(param_string)}"
    secure_string = Crypt.encrypt_and_encode(param_string)
    response = Quest.send_request(secure_string)
    decypted_response = Crypt.decode_and_decrypt(response.body)

    self.verify_response(decypted_response)
  end

  def self.verify_response response
    arrOfSplit = response.split("hash=")
    if EnHash.hashIt(arrOfSplit[0]).eql?(arrOfSplit[1])
      arrOfSplit[0].split("|").each{|item| p item }
    else
      puts "Unable to verify the integrity of the response received."
    end
  end

end

Main.start_exec
