# id: integer
# admin_user: references
# case: references
# name: string
# content: text
# pdcflow_document_id: string
# pdcflow_signature_id: string
# pdcflow_signature_link: text
# pdcflow_verification_pin: string
# created_at: datetime
# updated_at: datetime
class Agreement < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================
  alias_attribute :sid,  :id

  # == Extensions ===========================================================
  searchkick word_start: [:name, :content]

  # == Relationships ========================================================
  has_one_attached :file
  has_one_attached :pdcflow_result
  belongs_to :admin_user
  belongs_to :case
  belongs_to :agreement_template, optional: true

  # == Validations ==========================================================
  validates_presence_of :name, :case_id
  validates :case_id, uniqueness: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_save :set_content_from_template
  before_save :generate_pdf

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def to_s; name; end

  def set_content_from_template
    if self.agreement_template_id_changed?
      template = AgreementTemplate.find(self.agreement_template_id)
      content = template.content

      parties = self.case.parties

      username = self.admin_user.username
      hourly_rate = (self.admin_user.hourly_rate / 100).to_s
      date = Date.today
      day = date.day.to_s
      month = date.strftime('%B')
      year = date.year.to_s
      party1_username = parties[0].to_s
      party2_username = parties[1].to_s

      result = content.gsub("%{username}", username)
      result = result.gsub("%{hourly_rate}", hourly_rate)
      result = result.gsub("%{day}", day)
      result = result.gsub("%{month}", month)
      result = result.gsub("%{year}", year)
      result = result.gsub("%{party1_username}", party1_username)
      result = result.gsub("%{party2_username}", party2_username)
      result = result.gsub("%{date}", date.to_s)

      agreements_text = ""
      self.case.issues.each_with_index do |issue, i|
        agreements_text << "<br> #{i+1}. #{issue.agreement}"
      end
      result = result.gsub("%{agreements}", agreements_text)

      self.content = result
    end
  end

  def generate_pdf
    if self.content_changed?
      kit = PDFKit.new(self.content, :page_size => 'Letter')
      kit.stylesheets << Rails.root.join('app', 'assets', 'stylesheets', 'pdf.css') # 'quill/dist/quill.snow.css'

      pdf = kit.to_pdf

      self.file.attach(io: StringIO.new(pdf), filename: "test.pdf", content_type: "application/pdf")
    end
  end

  def search_data
    {
      sid: sid,
      updated_at: updated_at,
      created_at: created_at,
      admin_user_id: admin_user_id,
      case_id: case_id,
      agreement_template_id: agreement_template_id,
      name: name,
      content: content,
    }
  end
end
