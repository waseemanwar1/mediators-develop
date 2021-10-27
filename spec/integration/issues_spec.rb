require 'swagger_helper'

RSpec.describe 'Issues API', type: :request do

  path '/admin/api/issues' do

    get 'Get Issues' do

      let!(:admin_user) { create :admin_user }
      let!(:issue) { create :issue }

      tags 'Issues'
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
              "type": "issue",
              "attributes": {
                "title": "Issue 14",
                "description": "Description 14",
                "resolution_title": "Resolution 14",
                "resolution_description": "Resolution Description 14",
                "mediators_notes_title": "Notes 14",
                "mediators_notes_description": "Notes Description 14",
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
                },
                "party": {
                  "data": {
                    "id": "1",
                    "type": "party",
                    "attributes": {
                      "first_name": "John 1",
                      "last_name": "Doe 1"
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

    post 'Create Issue' do

      let!(:admin_user) { create :admin_user }

      tags 'Issues'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'issue[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'issue[party_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'issue[title]', :in => :formData, :type => :string, required: true
      parameter name: 'issue[description]', :in => :formData, :type => :string
      parameter name: 'issue[resolution_title]', :in => :formData, :type => :string
      parameter name: 'issue[resolution_description]', :in => :formData, :type => :string
      parameter name: 'issue[mediators_notes_title]', :in => :formData, :type => :string
      parameter name: 'issue[mediators_notes_description]', :in => :formData, :type => :string
      parameter name: 'issue[agreement]', :in => :formData, :type => :string

      response '201', 'Success' do


        let(:data) { attributes_for :issue }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "issue",
            "attributes": {
              "title": "Issue 14",
              "description": "Description 14",
              "resolution_title": "Resolution 14",
              "resolution_description": "Resolution Description 14",
              "mediators_notes_title": "Notes 14",
              "mediators_notes_description": "Notes Description 14",
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
              },
              "party": {
                "data": {
                  "id": "1",
                  "type": "party",
                  "attributes": {
                    "first_name": "John 1",
                    "last_name": "Doe 1"
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

        let(:data) { attributes_for :issue, :empty_admin_user_id }
        let(:data) { attributes_for :issue, :empty_case_id }
        let(:data) { attributes_for :issue, :empty_party_id }
        let(:data) { attributes_for :issue, :empty_title }
        let(:data) { attributes_for :issue, :empty_description }
        let(:data) { attributes_for :issue, :empty_resolution_title }
        let(:data) { attributes_for :issue, :empty_resolution_description }
        let(:data) { attributes_for :issue, :empty_mediators_notes_title }
        let(:data) { attributes_for :issue, :empty_mediators_notes_description }
        let(:data) { attributes_for :issue, :empty_agreement }
        run_test!
      end
    end

  end

  path '/admin/api/issues/{id}' do

    get 'Get Issue' do

      let!(:admin_user) { create :admin_user }
      let!(:issue) { create :issue }

      tags 'Issues'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { issue.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "issue",
            "attributes": {
              "title": "Issue 14",
              "description": "Description 14",
              "resolution_title": "Resolution 14",
              "resolution_description": "Resolution Description 14",
              "mediators_notes_title": "Notes 14",
              "mediators_notes_description": "Notes Description 14",
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
              },
              "party": {
                "data": {
                  "id": "1",
                  "type": "party",
                  "attributes": {
                    "first_name": "John 1",
                    "last_name": "Doe 1"
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

    put 'Update Issue' do

      let!(:admin_user) { create :admin_user }
      let!(:issue) { create :issue }
      let(:id) { issue.id }

      tags 'Issues'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'issue[case_id]', :in => :formData, :type => :integer
      parameter name: 'issue[party_id]', :in => :formData, :type => :integer
      parameter name: 'issue[title]', :in => :formData, :type => :string
      parameter name: 'issue[description]', :in => :formData, :type => :string
      parameter name: 'issue[resolution_title]', :in => :formData, :type => :string
      parameter name: 'issue[resolution_description]', :in => :formData, :type => :string
      parameter name: 'issue[mediators_notes_title]', :in => :formData, :type => :string
      parameter name: 'issue[mediators_notes_description]', :in => :formData, :type => :string
      parameter name: 'issue[agreement]', :in => :formData, :type => :string

      response '204', 'Updated' do

        let(:data) { attributes_for :issue }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do

        let(:data) { attributes_for :issue, :empty_admin_user_id }
        let(:data) { attributes_for :issue, :empty_case_id }
        let(:data) { attributes_for :issue, :empty_party_id }
        let(:data) { attributes_for :issue, :empty_title }
        let(:data) { attributes_for :issue, :empty_description }
        let(:data) { attributes_for :issue, :empty_resolution_title }
        let(:data) { attributes_for :issue, :empty_resolution_description }
        let(:data) { attributes_for :issue, :empty_mediators_notes_title }
        let(:data) { attributes_for :issue, :empty_mediators_notes_description }
        let(:data) { attributes_for :issue, :empty_agreement }
        run_test!
      end
    end

    delete 'Destroy Issue' do

      let!(:admin_user) { create :admin_user }
      let!(:issue) { create :issue }

      tags 'Issues'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do

        let(:id) { issue.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

end
