require 'webmock'
require 'rest-client'

include WebMock::API
WebMock.enable!

class Quest
  URL = "http://examplepg.com/transaction"
  stub_request(:post, URL).to_return(body: "u_-Ky1MrqYrvq8wRurFD7-xOtBx2BEstuK9utkRcTLMaFsjs_vnIshYxie3c5a3TGw4hK1RK0Dmj_vStphwJ3jtUte4xbefaFiMC2IjdEFXuEV-1K96KTNm0NDIvIfeQLcpxRi9jpgJa-gRceq1a7YxbEn2_wxmWp_JznXqsKvYyEvsMFsppDnuZdV1AP_h8sJfRwgoQT0SviPrcetdYbGEH2FID416vjtb_v3FDvRoFQQJ5Q7mQ6nMBvqwXncfybZGGGGGxBuCsir8sqVVhWz6W1Xtjbam1BE50Tb6DHq2tEI9aPtRiQ0UWJ59pit0W")

  def self.send_request message
    RestClient.post(URL, { msg: message }, headers={})
  end

end
