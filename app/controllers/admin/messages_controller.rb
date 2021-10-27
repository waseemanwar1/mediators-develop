class Admin::MessagesController < Admin::AdminController
  inherit_resources
  include DefaultMethods

  def create
    @message = CurrentAdmin.user.messages.new(permitted_params[:message])
    @message.subject = "Case: #{@message.case_id}, #{@message.admin_user.username} message."
    @message.from = @message.admin_user.email
    @message.to = @message.party.email
    create! do |format|
      MessageMailer.send_message(@message.id).deliver_later
    end
  end

private
  def permitted_params
    params.permit(message:
      [
        :admin_user_id,
        :case_id,
        :party_id,
        :subject,
        :sent_at,
        :content,
        :read,
        :from,
        :to,
      ]
    )
  end
end
