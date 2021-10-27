require 'swagger_helper'

RSpec.describe 'Agreement Templates API', type: :request do

  path '/admin/api/agreement_templates' do

    get 'Get Agreement Templates' do

      let!(:admin_user) { create :admin_user }
      let!(:agreement_template) { create :agreement_template }

      tags 'Agreement Templates'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'query', in: :query, type: :string, description: "Elasticsearch query string. See https://github.com/ankane/searchkick for more details."
      parameter name: 'match', in: :query, type: :string, description: "Elasticsearch match option, variants: word, word_start, word_middle, word_end, text_start, text_middle, text_end. See https://github.com/ankane/searchkick for more details."
      parameter name: 'order_by', in: :query, type: :string, description: "Elasticsearch order_by option, example: id. See https://github.com/ankane/searchkick for more details."
      parameter name: 'order', in: :query, type: :string, description: "Elasticsearch order option, variants: asc, desc. See https://github.com/ankane/searchkick for more details."
      parameter name: 'page', in: :query, type: :integer, description: "Elasticsearch pagination page number, example: 1. See https://github.com/ankane/searchkick for more details."
      parameter name: 'per', in: :query, type: :integer, description: "Elasticsearch pagination per page number, example: 20. See https://github.com/ankane/searchkick for more details."
      parameter name: 'where', in: :query, type: :object, description: "Elasticsearch where object, example: { created_at: { gte: Time.now } }. See https://github.com/ankane/searchkick for more details."


      response '200', 'Success' do

          examples 'application/json' => {
            data: [
              {
                "id": "1",
                "type": "agreement_template",
                "attributes": {
                  "name": "Agreement Template 1",
                  "content": "Content 1",
                  "created_at": "2020-07-02T10:47:04.147Z",
                  "updated_at": "2020-07-02T10:47:04.147Z"
                }
              }
            ]
          }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end

  end

  path '/admin/api/agreement_templates/{id}' do

    get 'Get Agreement Template' do

      let!(:admin_user) { create :admin_user }
      let!(:agreement_template) { create :agreement_template }

      tags 'Agreement Templates'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { agreement_template.id }

          examples 'application/json' => {
            data: {
              "id": "1",
              "type": "agreement_template",
              "attributes": {
                "name": "Agreement Template 1",
                "content": "Content 1",
                "created_at": "2020-07-02T10:47:04.147Z",
                "updated_at": "2020-07-02T10:47:04.147Z"
              }
            }
          }

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

end
