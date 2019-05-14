require 'digest'
require 'openssl'
require 'base64'
require 'webmock'
require 'rest-client'

include WebMock::API
WebMock.enable!

class Test

  KEY = "Q9fbkBF8au24C9wshGRW9ut8ecYpyXye5vhFLtHFdGjRg3a4HxPYRfQaKutZx5N4"
  IV = "qwertyuiopasdfghjklzxcvbnm"
  URL = "http://examplepg.com/transaction"
  stub_request(:post, URL).to_return(body: "u_-Ky1MrqYrvq8wRurFD7-xOtBx2BEstuK9utkRcTLMaFsjs_vnIshYxie3c5a3TGw4hK1RK0Dmj_vStphwJ3jtUte4xbefaFiMC2IjdEFXuEV-1K96KTNm0NDIvIfeQLcpxRi9jpgJa-gRceq1a7YxbEn2_wxmWp_JznXqsKvYyEvsMFsppDnuZdV1AP_h8sJfRwgoQT0SviPrcetdYbGEH2FID416vjtb_v3FDvRoFQQJ5Q7mQ6nMBvqwXncfybZGGGGGxBuCsir8sqVVhWz6W1Xtjbam1BE50Tb6DHq2tEI9aPtRiQ0UWJ59pit0W")

  def self.start_exec
    params = {
      "bank_ifsc_code" => "ICIC0000001",
      "bank_account_number" => "11111111",
      "amount" => "10000.00",
      "merchant_transaction_ref" => "txn001",
      "transaction_date" => "2014-11-14",
      "payment_gateway_merchant_reference" => "merc001",
    }
    param_string = ""
    params.keys.each do |key|
      param_string << "#{key}=#{params[key]}|"
    end
    hash = Test.getSHAOne(param_string)
    param_string << "hash=#{hash}"
    secure_string = Test.encrypt_and_encode(param_string)
    response = RestClient.post(URL, { msg: secure_string }, headers={})
    secure_response = Test.decode_and_decrypt(response.body)
    arrTest = secure_response.split("hash=")
    if Test.getSHAOne(arrTest[0]).eql?(arrTest[1])
      arrTest[0].split("|").each{|item| p item }
    end
  end

  def self.getSHAOne param_string
    Digest::SHA1.hexdigest param_string
  end

  def self.encrypt_and_encode param_string
    cipher = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.encrypt
    cipher.key = KEY
    cipher.iv = IV
    cipher_text = cipher.update(param_string) + cipher.final
    Base64.urlsafe_encode64(cipher_text)
  end

  def self.decode_and_decrypt secure_response
    to_decrypt = Base64.urlsafe_decode64(secure_response)
    cipher = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.decrypt
    cipher.key = KEY
    cipher.iv = IV
    cipher_text = cipher.update(to_decrypt) + cipher.final
  end
end

Test.start_exec
