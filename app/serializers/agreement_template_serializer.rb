class AgreementTemplateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :content,
              :created_at, :updated_at
end
