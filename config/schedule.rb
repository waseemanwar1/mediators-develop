env :PATH, ENV['PATH']

every 1.hours do
  runner "PdcFlowTransactionReportSender.perform_later"
end
