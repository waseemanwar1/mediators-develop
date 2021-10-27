class PdcFlowTransactionReportSender
  def send(party)
    begin
      # @uri = URI.parse("https://wssignaturedemo.pdc4u.com/SignatureService/api/v2_0/transactionReports/#{party.pdcflow_signature_id}?reportType=FULL")
      @uri = URI.parse("https://wssignaturedemo.pdc4u.com/SignatureService/api/v2_0/signatures/#{party.pdcflow_signature_id}")
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true

      request = Net::HTTP::Get.new(@uri.to_s)
      request.basic_auth Equisettle::Application.credentials.pdcflow_username, Equisettle::Application.credentials.pdcflow_password
      response = @http.request(request)

      if response.code == "200"
        body = JSON.parse(response.body)
        party.update(pdcflow_status: body['status'])
        return response.code
      else
        return response.code
      end
    rescue => e
      return e
    end
  end
end
