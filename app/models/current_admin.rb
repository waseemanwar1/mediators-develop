class CurrentAdmin < ActiveSupport::CurrentAttributes
  attribute :user, :request, :groups, :username, :root_path, :permission_keys, :avatar

  def user=(user)
    super
    self.groups = user.groups
    self.username = user.username
    self.avatar = user.avatar
    self.root_path = Rails.application.routes.url_helpers.admin_root_path
    self.permission_keys = Permission.joins(:groups).where( groups: { id: user.groups.pluck(:id) } ).pluck(:key)
  end

  def request=(request)
    super
  end

  def has_permission?(permission)
    permission_keys.include?(permission) if permission_keys
  end

  def aside_items
    [
      # Aside items start
      Admin::Pages::Asides::Items::ItemComponent.new(
        I18n.t('admin.aside.items.home'),
        url: Rails.application.routes.url_helpers.admin_root_path,
        icon: "flaticon-home-2"
      ),
      Admin::Pages::Asides::Items::SubmenuComponent.new(
        I18n.t('admin.aside.items.users'),
        icon: "flaticon2-group",
        items: Group.all.map do |group|
          Admin::Pages::Asides::Items::SubmenuItemComponent.new(
            group.to_s.pluralize,
            url: Rails.application.routes.url_helpers.admin_admin_users_path(group: group),
            show: Pundit.policy(user, :manage_permissions).manage?
          )
        end
      ),
      Admin::Pages::Asides::Items::SubmenuComponent.new(
        I18n.t('admin.aside.items.tables'),
        icon: "flaticon2-list-3",
        items: [
          # Admin::Pages::Asides::Items::ItemComponent.new(
          #   I18n.t('admin.aside.items.mediators'),
          #   url: Rails.application.routes.url_helpers.admin_mediators_path,
          #   icon: "flaticon-users",
          #   show: Pundit.policy(user, :manage_mediators).manage?
          # ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.cases'),
            url: Rails.application.routes.url_helpers.admin_cases_path,
            icon: "flaticon-network",
            show: Pundit.policy(user, :manage_cases).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.parties'),
            url: Rails.application.routes.url_helpers.admin_parties_path,
            icon: "flaticon-users",
            show: Pundit.policy(user, :manage_parties).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.sessions'),
            url: Rails.application.routes.url_helpers.admin_sessions_path,
            icon: "flaticon-time",
            show: Pundit.policy(user, :manage_sessions).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.messages'),
            url: Rails.application.routes.url_helpers.admin_messages_path,
            icon: "flaticon-multimedia-2",
            show: Pundit.policy(user, :manage_messages).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.documents'),
            url: Rails.application.routes.url_helpers.admin_documents_path,
            icon: "flaticon-interface-11",
            show: Pundit.policy(user, :manage_documents).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.reminders'),
            url: Rails.application.routes.url_helpers.admin_reminders_path,
            icon: "flaticon-alert",
            show: Pundit.policy(user, :manage_reminders).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.contacts'),
            url: Rails.application.routes.url_helpers.admin_contacts_path,
            icon: "flaticon-user-ok",
            show: Pundit.policy(user, :manage_contacts).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.invoices'),
            url: Rails.application.routes.url_helpers.admin_invoices_path,
            icon: "flaticon-coins",
            show: Pundit.policy(user, :manage_invoices).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.issues'),
            url: Rails.application.routes.url_helpers.admin_issues_path,
            icon: "flaticon-exclamation-1",
            show: Pundit.policy(user, :manage_issues).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.agreements'),
            url: Rails.application.routes.url_helpers.admin_agreements_path,
            icon: "flaticon-interface-5",
            show: Pundit.policy(user, :manage_agreements).manage?
          ),
          Admin::Pages::Asides::Items::ItemComponent.new(
            I18n.t('admin.aside.items.agreement_templates'),
            url: Rails.application.routes.url_helpers.admin_agreement_templates_path,
            icon: "flaticon-tabs",
            show: Pundit.policy(user, :manage_agreement_templates).manage?
          ),
        ]
      ),
      # Aside items end
    ]
  end

  def aside_actions
    [
      # Aside actions start
      Admin::Pages::Asides::Actions::IconLinkComponent.new(
				url: Rails.application.routes.url_helpers.admin_permissions_path,
				icon: "flaticon2-user-1",
				show: Pundit.policy(user, :manage_permissions).manage?
      ),
      Admin::Pages::Asides::Actions::IconLinkComponent.new(
				url: Rails.application.routes.url_helpers.admin_sidekiq_web_path,
				icon: "flaticon2-hourglass-1",
        show: Pundit.policy(user, :manage_sidekiq).manage?
      ),
			Admin::Pages::Asides::Actions::IconLinkComponent.new(
				url: Rails.application.routes.url_helpers.admin_rswag_api_path,
				icon: "flaticon-more-1",
			  show: Pundit.policy(user, :manage_api).manage?
			),
      # Aside actions end
    ]
  end
end
