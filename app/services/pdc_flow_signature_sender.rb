class PdcFlowSignatureSender
  def initialize
    @uri = URI.parse('https://wssignaturedemo.pdc4u.com/SignatureService/api/v2_0/signatures')
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  def send(agreement, party)
    begin
      pin = rand(99999999).to_s

      data = {
        firstName: party.first_name,
        lastName: party.last_name,
        verificationPin: pin,
        description: "#{agreement.name}",
        document:  {
          documentId: agreement.pdcflow_document_id,
          overlayId: ''
        },
        imageUpload: {
          imageUploadDescription: 'Take a picture of some form of identification',
          imageUploadRequested: true
        },
        standaloneSignatureRequested: true
      };

      headers={}
      headers['Content-Type'] = 'application/json'
      headers['Content-Length'] = data.to_json.length.to_s

      request = Net::HTTP::Post.new(@uri.to_s, headers)
      request.basic_auth Equisettle::Application.credentials.pdcflow_username, Equisettle::Application.credentials.pdcflow_password
      request.body = data.to_json
      response = @http.request(request)


      if response.code == "200"
        body = JSON.parse(response.body)
        party.update(
          pdcflow_signature_id: body["signatureId"],
          pdcflow_signature_link: body['signatureUrl'],
          pdcflow_verification_pin: pin,
          pdcflow_status: body['status']
        )
        SendPinMailer.send_message(party.id, body['signatureUrl'], pin)
        return response.code
      else
        return response.code
      end
    rescue => e
      return e
    end
  end
end
