require 'swagger_helper'

RSpec.describe 'Invoices API', type: :request do

  path '/admin/api/invoices' do

    get 'Get Invoices' do

      let!(:admin_user) { create :admin_user }
      let!(:invoice) { create :invoice }

      tags 'Invoices'
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
              "type": "invoice",
              "attributes": {
                "name": "Invoice 14",
                "time": 30,
                "amount": 10000,
                "date": "2020-07-02",
                "due_date": "2020-07-02",
                "status": "Created",
                "created_at": "2020-07-02T10:46:55.437Z",
                "updated_at": "2020-07-02T10:46:55.437Z",
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

    post 'Create Invoice' do

      let!(:admin_user) { create :admin_user }

      tags 'Invoices'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'invoice[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'invoice[party_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'invoice[name]', :in => :formData, :type => :string, required: true
      parameter name: 'invoice[amount]', :in => :formData, :type => :integer, required: true
      parameter name: 'invoice[time]', :in => :formData, :type => :string
      parameter name: 'invoice[date]', :in => :formData, :type => :string
      parameter name: 'invoice[due_date]', :in => :formData, :type => :string

      response '201', 'Success' do

        let(:data) { attributes_for :invoice }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "invoice",
            "attributes": {
              "name": "Invoice 14",
              "time": 30,
              "amount": 10000,
              "date": "2020-07-02",
              "due_date": "2020-07-02",
              "status": "Created",
              "created_at": "2020-07-02T10:46:55.437Z",
              "updated_at": "2020-07-02T10:46:55.437Z",
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

        let(:data) { attributes_for :invoice, :empty_admin_user_id }
        let(:data) { attributes_for :invoice, :empty_case_id }
        let(:data) { attributes_for :invoice, :empty_party_id }
        let(:data) { attributes_for :invoice, :empty_name }
        let(:data) { attributes_for :invoice, :empty_time }
        let(:data) { attributes_for :invoice, :empty_amount }
        let(:data) { attributes_for :invoice, :empty_date }
        let(:data) { attributes_for :invoice, :empty_due_date }
        let(:data) { attributes_for :invoice, :empty_status }
        run_test!
      end
    end

  end

  path '/admin/api/invoices/{id}' do

    get 'Get Invoice' do

      let!(:admin_user) { create :admin_user }
      let!(:invoice) { create :invoice }

      tags 'Invoices'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do


        let(:id) { invoice.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "invoice",
            "attributes": {
              "name": "Invoice 14",
              "time": 30,
              "amount": 10000,
              "date": "2020-07-02",
              "due_date": "2020-07-02",
              "status": "Created",
              "created_at": "2020-07-02T10:46:55.437Z",
              "updated_at": "2020-07-02T10:46:55.437Z",
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

    put 'Update Invoice' do

      let!(:admin_user) { create :admin_user }
      let!(:invoice) { create :invoice }
      let(:id) { invoice.id }

      tags 'Invoices'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'invoice[case_id]', :in => :formData, :type => :integer
      parameter name: 'invoice[party_id]', :in => :formData, :type => :integer
      parameter name: 'invoice[name]', :in => :formData, :type => :string
      parameter name: 'invoice[amount]', :in => :formData, :type => :integer
      parameter name: 'invoice[time]', :in => :formData, :type => :string
      parameter name: 'invoice[date]', :in => :formData, :type => :string
      parameter name: 'invoice[due_date]', :in => :formData, :type => :string

      response '204', 'Updated' do

        let(:data) { attributes_for :invoice }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do

        let(:data) { attributes_for :invoice, :empty_admin_user_id }
        let(:data) { attributes_for :invoice, :empty_case_id }
        let(:data) { attributes_for :invoice, :empty_party_id }
        let(:data) { attributes_for :invoice, :empty_name }
        let(:data) { attributes_for :invoice, :empty_time }
        let(:data) { attributes_for :invoice, :empty_amount }
        let(:data) { attributes_for :invoice, :empty_date }
        let(:data) { attributes_for :invoice, :empty_due_date }
        let(:data) { attributes_for :invoice, :empty_status }
        run_test!
      end
    end

    delete 'Destroy Invoice' do

      let!(:admin_user) { create :admin_user }
      let!(:invoice) { create :invoice }

      tags 'Invoices'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do

        let(:id) { invoice.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

  path '/admin/api/invoices/secret' do
    get 'Get Secret' do

      let!(:admin_user) { create :admin_user }
      let!(:invoice) { create :invoice }

      tags 'Invoices'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :token, :in => :header, :type => :string, required: true, description: "Use an invoice token"

      response '200', 'Success' do

        let(:token) { invoice.id }

        examples 'application/json' => {
          secret: "pi_1H0bldJDA0jmlwUvtQLGcCBa_secret_0uDyfsgFhsjZ7H4pjDzXGAvcK"
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
