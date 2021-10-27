class PdcFlowTransactionReportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Party.where(pdcflow_status: "PENDING").find_each do |party|
      sender = PdcFlowTransactionReportSender.new
      sender.send(party)
    end
  end
end
