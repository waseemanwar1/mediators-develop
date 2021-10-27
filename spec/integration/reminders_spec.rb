require 'swagger_helper'

RSpec.describe 'Reminders API', type: :request do

  path '/admin/api/reminders' do

    get 'Get Reminders' do

      let!(:admin_user) { create :admin_user }
      let!(:reminder) { create :reminder }

      tags 'Reminders'
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
              "type": "reminder",
              "attributes": {
                "name": "Reminder 14",
                "description": "Description 14",
                "priority": "Important",
                "due_date": "2020-07-03",
                "status": "Active",
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
                },
                "contact": {
                  "data": {
                    "id": "1",
                    "type": "contact",
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

    post 'Create Reminder' do

      let!(:admin_user) { create :admin_user }

      tags 'Reminders'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'reminder[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'reminder[party_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'reminder[contact_id]', :in => :formData, :type => :integer
      parameter name: 'reminder[name]', :in => :formData, :type => :string, required: true
      parameter name: 'reminder[description]', :in => :formData, :type => :string
      parameter name: 'reminder[due_date]', :in => :formData, :type => :string
      parameter name: 'reminder[priority]', :in => :formData, enum: ["Important", "No Matter"]
      parameter name: 'reminder[status]', :in => :formData, enum: ["Active", "Archive"]

      response '201', 'Success' do


        let(:data) { attributes_for :reminder }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "reminder",
            "attributes": {
              "name": "Reminder 14",
              "description": "Description 14",
              "priority": "Important",
              "due_date": "2020-07-03",
              "status": "Active",
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
              },
              "contact": {
                "data": {
                  "id": "1",
                  "type": "contact",
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

        let(:data) { attributes_for :reminder, :empty_admin_user_id }
        let(:data) { attributes_for :reminder, :empty_case_id }
        let(:data) { attributes_for :reminder, :empty_party_id }
        let(:data) { attributes_for :reminder, :empty_name }
        let(:data) { attributes_for :reminder, :empty_description }
        let(:data) { attributes_for :reminder, :empty_priority }
        let(:data) { attributes_for :reminder, :empty_due_date }
        let(:data) { attributes_for :reminder, :empty_contact }
        let(:data) { attributes_for :reminder, :empty_status }
        run_test!
      end
    end

  end

  path '/admin/api/reminders/{id}' do

    get 'Get Reminder' do

      let!(:admin_user) { create :admin_user }
      let!(:reminder) { create :reminder }

      tags 'Reminders'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { reminder.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "reminder",
            "attributes": {
              "name": "Reminder 14",
              "description": "Description 14",
              "priority": "Important",
              "due_date": "2020-07-03",
              "status": "Active",
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
              },
              "contact": {
                "data": {
                  "id": "1",
                  "type": "contact",
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

    put 'Update Reminder' do

      let!(:admin_user) { create :admin_user }
      let!(:reminder) { create :reminder }
      let(:id) { reminder.id }

      tags 'Reminders'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'reminder[case_id]', :in => :formData, :type => :integer
      parameter name: 'reminder[party_id]', :in => :formData, :type => :integer
      parameter name: 'reminder[contact_id]', :in => :formData, :type => :integer
      parameter name: 'reminder[name]', :in => :formData, :type => :string
      parameter name: 'reminder[description]', :in => :formData, :type => :string
      parameter name: 'reminder[due_date]', :in => :formData, :type => :string
      parameter name: 'reminder[priority]', :in => :formData, enum: ["Important", "No Matter"]
      parameter name: 'reminder[status]', :in => :formData, enum: ["Active", "Archive"]

      response '204', 'Updated' do

        let(:data) { attributes_for :reminder }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do

        let(:data) { attributes_for :reminder, :empty_admin_user_id }
        let(:data) { attributes_for :reminder, :empty_case_id }
        let(:data) { attributes_for :reminder, :empty_party_id }
        let(:data) { attributes_for :reminder, :empty_name }
        let(:data) { attributes_for :reminder, :empty_description }
        let(:data) { attributes_for :reminder, :empty_priority }
        let(:data) { attributes_for :reminder, :empty_due_date }
        let(:data) { attributes_for :reminder, :empty_contact }
        let(:data) { attributes_for :reminder, :empty_status }
        run_test!
      end
    end

    delete 'Destroy Reminder' do

      let!(:admin_user) { create :admin_user }
      let!(:reminder) { create :reminder }

      tags 'Reminders'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do

        let(:id) { reminder.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

end
