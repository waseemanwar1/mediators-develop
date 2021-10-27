require 'swagger_helper'

RSpec.describe 'Cases API', type: :request do

  path '/admin/api/cases' do

    get 'Get Cases' do

      let!(:admin_user) { create :admin_user }
      let!(:case) { create :case }

      tags 'Cases'
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
          "data": [
            {
              "id": "14",
              "type": "case",
              "attributes": {
                "program": "Program 14",
                "name": "Case 14",
                "description": "Case description 14",
                "tags": [
                  "Tag 1",
                  "Tag 2"
                ],
                "status": "Active",
                "created_at": "2020-07-02T10:46:45.058Z",
                "updated_at": "2020-07-02T10:46:45.058Z",
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
                "parties": {
                  "data": [
                    {
                      "id": "32",
                      "type": "party",
                      "attributes": {
                        "first_name": "Igor",
                        "last_name": "Pavlov"
                      }
                    }
                  ]
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

    post 'Create Case' do

      let!(:admin_user) { create :admin_user }

      tags 'Cases'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'case[name]', :in => :formData, :type => :string, required: true
      parameter name: 'case[program]', :in => :formData, :type => :string
      parameter name: 'case[description]', :in => :formData, :type => :string
      parameter name: 'case[tags][0]', :in => :formData, :type => :string, description: "Example: 'cat'"
      parameter name: 'case[tags][1]', :in => :formData, :type => :string, description: "Example: 'dog'"
      parameter name: 'case[status]', :in => :formData, enum: ["Active", "Not Active"]

      response '201', 'Success' do

        let(:data) { attributes_for :case }

        examples 'application/json' => {
          "data": {
            "id": "1",
            "type": "case",
            "attributes": {
              "program": "Program 1",
              "name": "Case 1",
              "description": "Case description 1",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
              "status": "Active",
              "created_at": "2020-07-02T10:46:44.679Z",
              "updated_at": "2020-07-02T10:46:44.679Z",
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
              "parties": {
                "data": [
                  {
                    "id": "32",
                    "type": "party",
                    "attributes": {
                      "first_name": "Igor",
                      "last_name": "Pavlov"
                    }
                  }
                ]
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
        let(:data) { attributes_for :case, :empty_program }
        let(:data) { attributes_for :case, :empty_name }
        let(:data) { attributes_for :case, :empty_description }
        let(:data) { attributes_for :case, :empty_tags }
        run_test!
      end
    end

  end

  path '/admin/api/cases/{id}' do

    get 'Get Case' do

      let!(:admin_user) { create :admin_user }
      let!(:case) { create :case }

      tags 'Cases'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { case_id }

        examples 'application/json' => {
          "data": {
            "id": "1",
            "type": "case",
            "attributes": {
              "program": "Program 1",
              "name": "Case 1",
              "description": "Case description 1",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
              "status": "Active",
              "created_at": "2020-07-02T10:46:44.679Z",
              "updated_at": "2020-07-02T10:46:44.679Z",
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
              "parties": {
                "data": [
                  {
                    "id": "32",
                    "type": "party",
                    "attributes": {
                      "first_name": "Igor",
                      "last_name": "Pavlov"
                    }
                  }
                ]
              }
            },
            "relationships": {
              "admin_user": {
                "data": {
                  "id": "2",
                  "type": "admin_user"
                }
              }
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

    put 'Update Case' do

      let!(:admin_user) { create :admin_user }
      let!(:case) { create :case }
      let(:id) { case_id }

      tags 'Cases'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'case[name]', :in => :formData, :type => :string
      parameter name: 'case[program]', :in => :formData, :type => :string
      parameter name: 'case[description]', :in => :formData, :type => :string
      parameter name: 'case[tags][0]', :in => :formData, :type => :string, description: "Example: 'cat'"
      parameter name: 'case[tags][1]', :in => :formData, :type => :string, description: "Example: 'dog'"
      parameter name: 'case[status]', :in => :formData, enum: ["Active", "Not Active"]

      response '204', 'Updated' do
        let(:data) { attributes_for :case }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do
        let(:data) { attributes_for :case, :empty_admin_user_id }
        let(:data) { attributes_for :case, :empty_program }
        let(:data) { attributes_for :case, :empty_name }
        let(:data) { attributes_for :case, :empty_description }
        let(:data) { attributes_for :case, :empty_tags }
        run_test!
      end
    end

    delete 'Destroy Case' do

      let!(:admin_user) { create :admin_user }
      let!(:case) { create :case }

      tags 'Cases'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do
        let(:id) { case_id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

end
