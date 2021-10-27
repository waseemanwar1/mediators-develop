# EN locale seeds start
I18n.locale = :en
# Permissions start
permission_settings = Permission.find_or_create_by(name: 'Permission Settings', description: 'Can configure user permissions', key: 'permission_settings')
manage_sidekiq = Permission.find_or_create_by(name: 'Manage Sidekiq', description: 'Can manage Sidekiq', key: 'manage_sidekiq')
manage_mediators = Permission.find_or_create_by(name: 'Manage Mediators', description: 'Can manage Mediators', key: 'manage_mediators')
manage_cases = Permission.find_or_create_by(name: 'Manage Cases', description: 'Can manage Cases', key: 'manage_cases')
manage_parties = Permission.find_or_create_by(name: 'Manage Parties', description: 'Can manage Parties', key: 'manage_parties')
manage_sessions = Permission.find_or_create_by(name: 'Manage Sessions', description: 'Can manage Sessions', key: 'manage_sessions')
manage_messages = Permission.find_or_create_by(name: 'Manage Messages', description: 'Can manage Messages', key: 'manage_messages')
manage_documents = Permission.find_or_create_by(name: 'Manage Documents', description: 'Can manage Documents', key: 'manage_documents')
manage_reminders = Permission.find_or_create_by(name: 'Manage Reminders', description: 'Can manage Reminders', key: 'manage_reminders')
manage_contacts = Permission.find_or_create_by(name: 'Manage Contacts', description: 'Can manage Contacts', key: 'manage_contacts')
manage_invoices = Permission.find_or_create_by(name: 'Manage Invoices', description: 'Can manage Invoices', key: 'manage_invoices')
manage_issues = Permission.find_or_create_by(name: 'Manage Issues', description: 'Can manage Issues', key: 'manage_issues')
manage_agreements = Permission.find_or_create_by(name: 'Manage Agreements', description: 'Can manage Agreements', key: 'manage_agreements')
manage_agreement_templates = Permission.find_or_create_by(name: 'Manage AgreementTemplates', description: 'Can manage AgreementTemplates', key: 'manage_agreement_templates')
manage_api = Permission.find_or_create_by(name: 'Manage API', description: 'Can manage API', key: 'manage_api')
# Permissions end

admin_group = Group.find_or_create_by(name: 'Admin')
developer_group = Group.find_or_create_by(name: 'Developer')
mediator_group = Group.find_or_create_by(name: 'Mediator')
admin_user = AdminUser.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.first_name = 'John'
  user.last_name = 'Doe'
end
# EN locale seeds stop

# RU locale seeds start
I18n.locale = :ru
# Permissions update start
permission_settings.update_attributes(name: 'Настройки прав', description: 'Может управлять правами пользователей')
manage_sidekiq.update_attributes(name: 'Управлять Sidekiq', description: 'Может управлять Sidekiq')
manage_mediators.update_attributes(name: 'Управлять Mediators', description: 'Может управлять Mediators')
manage_cases.update_attributes(name: 'Управлять Cases', description: 'Может управлять Cases')
manage_parties.update_attributes(name: 'Управлять Parties', description: 'Может управлять Parties')
manage_sessions.update_attributes(name: 'Управлять Sessions', description: 'Может управлять Sessions')
manage_messages.update_attributes(name: 'Управлять Messages', description: 'Может управлять Messages')
manage_documents.update_attributes(name: 'Управлять Documents', description: 'Может управлять Documents')
manage_reminders.update_attributes(name: 'Управлять Reminders', description: 'Может управлять Reminders')
manage_contacts.update_attributes(name: 'Управлять Contacts', description: 'Может управлять Contacts')
manage_invoices.update_attributes(name: 'Управлять Invoices', description: 'Может управлять Invoices')
manage_issues.update_attributes(name: 'Управлять Issues', description: 'Может управлять Issues')
manage_agreements.update_attributes(name: 'Управлять Agreements', description: 'Может управлять Agreements')
manage_agreement_templates.update_attributes(name: 'Управлять AgreementTemplates', description: 'Может управлять AgreementTemplates')
manage_api.update_attributes(name: 'Управлять API', description: 'Может управлять API')
# Permissions update end

admin_group.update_attributes(name: 'Админ')
developer_group.update_attributes(name: 'Разработчик')
mediator_group.update_attributes(name: 'Медиатор')
# RU locale seeds end

# Default references start
# Add permissions to the group start
admin_group.permissions << permission_settings unless admin_group.permissions.where(id: permission_settings.id).present?
admin_group.permissions << manage_sidekiq unless admin_group.permissions.where(id: manage_sidekiq.id).present?
admin_group.permissions << manage_mediators unless admin_group.permissions.where(id: manage_mediators.id).present?
admin_group.permissions << manage_cases unless admin_group.permissions.where(id: manage_cases.id).present?
admin_group.permissions << manage_parties unless admin_group.permissions.where(id: manage_parties.id).present?
admin_group.permissions << manage_sessions unless admin_group.permissions.where(id: manage_sessions.id).present?
admin_group.permissions << manage_messages unless admin_group.permissions.where(id: manage_messages.id).present?
admin_group.permissions << manage_documents unless admin_group.permissions.where(id: manage_documents.id).present?
admin_group.permissions << manage_reminders unless admin_group.permissions.where(id: manage_reminders.id).present?
admin_group.permissions << manage_contacts unless admin_group.permissions.where(id: manage_contacts.id).present?
admin_group.permissions << manage_invoices unless admin_group.permissions.where(id: manage_invoices.id).present?
admin_group.permissions << manage_issues unless admin_group.permissions.where(id: manage_issues.id).present?
admin_group.permissions << manage_agreements unless admin_group.permissions.where(id: manage_agreements.id).present?
admin_group.permissions << manage_agreement_templates unless admin_group.permissions.where(id: manage_agreement_templates.id).present?
admin_group.permissions << manage_api unless admin_group.permissions.where(id: manage_api.id).present?
# Add permissions to the group end
admin_group.save

admin_user.groups << admin_group unless admin_user.groups.where(id: admin_group.id).present?
admin_user.save
# Default references end

#
# # Test data start
# test_mediator_user = AdminUser.find_or_create_by(email: 'mediator@example.com') do |user|
#   user.password = 'password'
#   user.first_name = 'Test'
#   user.last_name = 'Mediator'
#   user.hourly_rate = 100
#   user.company_name = "Company Name"
#   user.phone = "0000000000"
#   user.company_website = "https://company.website"
#   user.address_line_1 = 'Address Line 1'
#   user.address_line_2 = 'Address Line 2'
#   user.postcode = '000000'
#   user.city = 'New York'
#   user.state = 'New York'
#   user.country = 'USA'
# end
#
# (1..30).each do |i|
#   Case.find_or_create_by(name: "Case #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.program = "Program #{i}"
#     object.name = "Case #{i}"
#     object.description = "Case description #{i}"
#     object.tags = ["Tag 1", "Tag 2"]
#     object.status = "Active"
#   end
# end
#
# test_case = Case.first
#
# (1..30).each do |i|
#   Party.find_or_create_by(title: "Party #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.first_name = "John #{i}"
#     object.last_name = "Doe #{i}"
#     object.title = "Party #{i}"
#     object.company = "Company #{i}"
#     object.address = "Address #{i}"
#     object.notes = "Notes #{i}"
#     object.email = "party#{i}@example.com"
#     object.phone = "000000000#{i}"
#     object.street = "Street #{i}"
#     object.city = "City #{i}"
#     object.state = "State #{i}"
#     object.zip_code = "00000#{i}"
#     object.country = "Country #{i}"
#     object.tags = ["Tag 1", "Tag 2"]
#   end
# end
#
# test_party = Party.first
#
# (1..30).each do |i|
#   Session.find_or_create_by(name: "Session #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.party_id = test_party.id
#     object.name = "Session #{i}"
#     object.due_date = Date.today + 1.day
#     object.time_start = Time.now.to_s(:time)
#     object.time_finish = Time.now.to_s(:time)
#     object.session_type = "Online"
#     object.location = "Location #{i}"
#     object.tags = ["Tag 1", "Tag 2"]
#     object.rate_type = "Hourly"
#     object.rate = 1000
#   end
# end
#
# (1..30).each do |i|
#   Message.find_or_create_by(subject: "Subject #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.party_id = test_party.id
#     object.subject = "Subject #{i}"
#     object.sent_at = DateTime.now
#     object.content = "Content #{i}"
#     object.from = "From #{i}"
#     object.to = "To #{i}"
#   end
# end
#
# (1..30).each do |i|
#   Document.find_or_create_by(file_name: "File Name #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.file_name = "File Name #{i}"
#     object.description = "Description #{i}"
#     object.date = DateTime.now
#     object.author = "Author #{i}"
#   end
# end
#
# (1..30).each do |i|
#   Contact.find_or_create_by(title: "Contact #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.party_id = test_party.id
#     object.first_name = "John #{i}"
#     object.last_name = "Doe #{i}"
#     object.contact_type = "Third Person #{i}"
#     object.email = "contact#{i}@example.com"
#     object.title = "Contact #{i}"
#     object.company = "Company #{i}"
#     object.phone = "0000000000"
#     object.address = "Address #{i}"
#     object.notes = "Notes #{i}"
#     object.street = "Street #{i}"
#     object.city = "City #{i}"
#     object.state = "State #{i}"
#     object.zip_code = "000000#{i}"
#     object.country = "USA"
#     object.tags = ["Tag 1", "Tag 2"]
#   end
# end
#
# test_contact = Contact.first
#
# (1..30).each do |i|
#   Reminder.find_or_create_by(name: "Reminder #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.party_id = test_party.id
#     object.contact_id = test_contact.id
#     object.name = "Reminder #{i}"
#     object.description = "Description #{i}"
#     object.priority = "Important"
#     object.due_date = Date.today + 1.day
#     object.status = "Active"
#   end
# end
#
# (1..30).each do |i|
#   Invoice.find_or_create_by(name: "Invoice #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.party_id = test_party.id
#     object.name = "Invoice #{i}"
#     object.time = 30
#     object.amount = 10000
#     object.date = Date.today
#     object.due_date = Date.today
#   end
# end
#
# (1..30).each do |i|
#   Issue.find_or_create_by(title: "Issue #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.party_id = test_party.id
#     object.title = "Issue #{i}"
#     object.description = "Description #{i}"
#     object.resolution_title = "Resolution #{i}"
#     object.resolution_description = "Resolution Description #{i}"
#     object.mediators_notes_title = "Notes #{i}"
#     object.mediators_notes_description = "Notes Description #{i}"
#     object.agreement = "Agreement #{i}"
#   end
# end
#
# (1..30).each do |i|
#   Agreement.find_or_create_by(name: "Agreement #{i}") do |object|
#     object.admin_user_id = test_mediator_user.id
#     object.case_id = test_case.id
#     object.name = "Agreement #{i}"
#     object.content = "Content #{i}"
#   end
# end
#
# (1..30).each do |i|
#   AgreementTemplate.find_or_create_by(name: "Agreement Template #{i}") do |object|
#     object.name = "Agreement Template #{i}"
#     object.content = "Content #{i}"
#     object.public = true
#   end
# end
# # Test data end
