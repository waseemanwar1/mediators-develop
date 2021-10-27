require 'swagger_helper'

RSpec.describe 'Sessions API', type: :request do

  path '/admin/api/sessions' do

    get 'Get Sessions' do

      let!(:admin_user) { create :admin_user }
      let!(:session) { create :session }

      tags 'Sessions'
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
              "type": "session",
              "attributes": {
                "name": "Session 14",
                "due_date": "2020-07-03",
                "time_start": "2000-01-01T13:46:00.000Z",
                "time_finish": "2000-01-01T13:46:00.000Z",
                "session_type": "Online",
                "location": "Location 14",
                "tags": [
                  "Tag 1",
                  "Tag 2"
                ],
                "rate_type": "Hourly",
                "rate": 1000,
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

    post 'Create Session' do

      let!(:admin_user) { create :admin_user }

      tags 'Sessions'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'session[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'session[party_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'session[name]', :in => :formData, :type => :string, required: true
      parameter name: 'session[due_date]', :in => :formData, :type => :string, required: true
      parameter name: 'session[time_start]', :in => :formData, :type => :string, required: true
      parameter name: 'session[time_finish]', :in => :formData, :type => :string, required: true
      parameter name: 'session[session_type]', :in => :formData, :type => :string, enum: ["Online", "Offline"]
      parameter name: 'session[location]', :in => :formData, :type => :string
      parameter name: 'session[tags]', :in => :formData, :type => :string, description: "Example: [{'value':'cat'}, {'value':'dog'}]"
      parameter name: 'session[rate_type]', :in => :formData, :type => :string, enum: ["Hourly", "Weekly"]
      parameter name: 'session[rate]', :in => :formData, :type => :integer

      response '201', 'Success' do

        let(:data) { attributes_for :session }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "session",
            "attributes": {
              "name": "Session 14",
              "due_date": "2020-07-03",
              "time_start": "2000-01-01T13:46:00.000Z",
              "time_finish": "2000-01-01T13:46:00.000Z",
              "session_type": "Online",
              "location": "Location 14",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
              "rate_type": "Hourly",
              "rate": 1000,
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

        let(:data) { attributes_for :session, :empty_admin_user_id }
        let(:data) { attributes_for :session, :empty_case_id }
        let(:data) { attributes_for :session, :empty_party_id }
        let(:data) { attributes_for :session, :empty_name }
        let(:data) { attributes_for :session, :empty_due_date }
        let(:data) { attributes_for :session, :empty_time_start }
        let(:data) { attributes_for :session, :empty_time_finish }
        let(:data) { attributes_for :session, :empty_session_type }
        let(:data) { attributes_for :session, :empty_location }
        let(:data) { attributes_for :session, :empty_tags }
        let(:data) { attributes_for :session, :empty_rate_type }
        let(:data) { attributes_for :session, :empty_rate }
        run_test!
      end
    end

  end

  path '/admin/api/sessions/{id}' do

    get 'Get Session' do

      let!(:admin_user) { create :admin_user }
      let!(:session) { create :session }

      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { session.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "session",
            "attributes": {
              "name": "Session 14",
              "due_date": "2020-07-03",
              "time_start": "2000-01-01T13:46:00.000Z",
              "time_finish": "2000-01-01T13:46:00.000Z",
              "session_type": "Online",
              "location": "Location 14",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
              "rate_type": "Hourly",
              "rate": 1000,
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

    put 'Update Session' do

      let!(:admin_user) { create :admin_user }
      let!(:session) { create :session }
      let(:id) { session.id }

      tags 'Sessions'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'session[case_id]', :in => :formData, :type => :integer
      parameter name: 'session[party_id]', :in => :formData, :type => :integer
      parameter name: 'session[name]', :in => :formData, :type => :string
      parameter name: 'session[due_date]', :in => :formData, :type => :string
      parameter name: 'session[time_start]', :in => :formData, :type => :string
      parameter name: 'session[time_finish]', :in => :formData, :type => :string
      parameter name: 'session[session_type]', :in => :formData, :type => :string, enum: ["Online", "Offline"]
      parameter name: 'session[location]', :in => :formData, :type => :string
      parameter name: 'session[tags]', :in => :formData, :type => :string, description: "Example: [{'value':'cat'}, {'value':'dog'}]"
      parameter name: 'session[rate_type]', :in => :formData, :type => :string, enum: ["Hourly", "Weekly"]
      parameter name: 'session[rate]', :in => :formData, :type => :integer

      response '204', 'Updated' do

        let(:data) { attributes_for :session }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do

        let(:data) { attributes_for :session, :empty_admin_user_id }
        let(:data) { attributes_for :session, :empty_case_id }
        let(:data) { attributes_for :session, :empty_party_id }
        let(:data) { attributes_for :session, :empty_name }
        let(:data) { attributes_for :session, :empty_due_date }
        let(:data) { attributes_for :session, :empty_time_start }
        let(:data) { attributes_for :session, :empty_time_finish }
        let(:data) { attributes_for :session, :empty_session_type }
        let(:data) { attributes_for :session, :empty_location }
        let(:data) { attributes_for :session, :empty_tags }
        let(:data) { attributes_for :session, :empty_rate_type }
        let(:data) { attributes_for :session, :empty_rate }
        run_test!
      end
    end

    delete 'Destroy Session' do

      let!(:admin_user) { create :admin_user }
      let!(:session) { create :session }

      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do

        let(:id) { session.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

end
