class PdcFlowDocumentSender
  def initialize
    @uri = URI.parse('https://wssignaturedemo.pdc4u.com/SignatureService/api/v2_0/documents')
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  def send(agreement)
    begin
      file_path = ActiveStorage::Blob.service.path_for agreement.file.key

      file = File.open(file_path, "rb")
      contents = file.read
      file.close
      fileData = Base64.strict_encode64(contents)

      data = {
        'documentName' => agreement.name,
        'documentBase64String' => fileData
      }

      headers={}
      headers['Content-Type'] = 'application/json'
      headers['Content-Length'] = data.to_json.length.to_s

      request = Net::HTTP::Post.new(@uri.to_s, headers)
      request.basic_auth Equisettle::Application.credentials.pdcflow_username, Equisettle::Application.credentials.pdcflow_password
      request.body = data.to_json
      response = @http.request(request)


      if response.code == "200"
        data = JSON.parse(response.body)
        agreement.update(pdcflow_document_id: data["documentId"])
        return response.code
      else
        return response.code
      end
    rescue => e
      return e
    end
  end
end
