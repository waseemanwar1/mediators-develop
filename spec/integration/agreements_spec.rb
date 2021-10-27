require 'swagger_helper'

RSpec.describe 'Agreements API', type: :request do

  path '/admin/api/agreements' do

    get 'Get Agreements' do

      let!(:admin_user) { create :admin_user }
      let!(:agreement) { create :agreement }

      tags 'Agreements'
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
                "type": "agreement",
                "attributes": {
                  "name": "Agreement 1",
                  "content": "Content 1",
                  "created_at": "2020-07-02T10:47:04.147Z",
                  "updated_at": "2020-07-02T10:47:04.147Z",
                  "file": "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--6723a13852bd9f682435002737d382f766627241/Check%20mark.png",
                  "admin_user": {
                    "data": {
                      "id": "2",
                      "type": "admin_user",
                      "attributes": {
                        "first_name": "Test",
                        "last_name": "Mediator"
                      }
                    }
                  },
                  "case": {
                    "data": {
                      "id": "1",
                      "type": "case",
                      "attributes": {
                        "name": "Case 1"
                      }
                    }
                  }
                },
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

    post 'Create Agreement' do

      let!(:admin_user) { create :admin_user }

      tags 'Agreements'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'agreement[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'agreement[agreement_template_id]', :in => :formData, :type => :integer
      parameter name: 'agreement[name]', :in => :formData, :type => :string, required: true
      parameter name: 'agreement[content]', :in => :formData, :type => :string

      response '201', 'Success' do

        let(:data) { attributes_for :agreement }

        examples 'application/json' => {
          data: {
            "id": "1",
            "type": "agreement",
            "attributes": {
              "name": "Agreement 1",
              "content": "Content 1",
              "created_at": "2020-07-02T10:47:04.147Z",
              "updated_at": "2020-07-02T10:47:04.147Z",
              "file": "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--6723a13852bd9f682435002737d382f766627241/Check%20mark.png",
              "admin_user": {
                "data": {
                  "id": "2",
                  "type": "admin_user",
                  "attributes": {
                    "first_name": "Test",
                    "last_name": "Mediator"
                  }
                }
              },
              "case": {
                "data": {
                  "id": "1",
                  "type": "case",
                  "attributes": {
                    "name": "Case 1"
                  }
                }
              }
            },
          }
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do
        let(:data) { attributes_for :agreement, :empty_admin_user_id }
        let(:data) { attributes_for :agreement, :empty_case_id }
        let(:data) { attributes_for :agreement, :empty_name }
        let(:data) { attributes_for :agreement, :empty_content }
        run_test!
      end
    end

  end

  path '/admin/api/agreements/{id}' do

    get 'Get Agreement' do

      let!(:admin_user) { create :admin_user }
      let!(:agreement) { create :agreement }

      tags 'Agreements'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { agreement.id }

        examples 'application/json' => {
          data: {
            "id": "1",
            "type": "agreement",
            "attributes": {
              "name": "Agreement 1",
              "content": "Content 1",
              "created_at": "2020-07-02T10:47:04.147Z",
              "updated_at": "2020-07-02T10:47:04.147Z",
              "file": "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--6723a13852bd9f682435002737d382f766627241/Check%20mark.png",
              "admin_user": {
                "data": {
                  "id": "2",
                  "type": "admin_user",
                  "attributes": {
                    "first_name": "Test",
                    "last_name": "Mediator"
                  }
                }
              },
              "case": {
                "data": {
                  "id": "1",
                  "type": "case",
                  "attributes": {
                    "name": "Case 1"
                  }
                }
              }
            },
          }
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

    put 'Update Agreement' do

      let!(:admin_user) { create :admin_user }
      let!(:agreement) { create :agreement }
      let(:id) { agreement.id }

      tags 'Agreements'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'agreement[case_id]', :in => :formData, :type => :integer
      parameter name: 'agreement[agreement_template_id]', :in => :formData, :type => :integer
      parameter name: 'agreement[name]', :in => :formData, :type => :string
      parameter name: 'agreement[content]', :in => :formData, :type => :string

      response '204', 'Updated' do
        let(:data) { attributes_for :agreement }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do
        let(:data) { attributes_for :agreement, :empty_admin_user_id }
        let(:data) { attributes_for :agreement, :empty_case_id }
        let(:data) { attributes_for :agreement, :empty_name }
        let(:data) { attributes_for :agreement, :empty_content }
        run_test!
      end
    end

    delete 'Destroy Agreement' do

      let!(:admin_user) { create :admin_user }
      let!(:agreement) { create :agreement }

      tags 'Agreements'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do
        let(:id) { agreement.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

  path '/admin/api/agreements/{id}/send_document' do
    post 'Send Agreement Document' do
      tags 'Agreements'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true

      response '200', 'Success' do
        let(:data) { attributes_for :agreement }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end

end
