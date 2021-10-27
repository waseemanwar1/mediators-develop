require 'swagger_helper'

RSpec.describe 'Parties API', type: :request do

  path '/admin/api/parties' do

    get 'Get Parties' do

      let!(:admin_user) { create :admin_user }
      let!(:party) { create :party }

      tags 'Parties'
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
              "type": "party",
              "attributes": {
                "first_name": "John 14",
                "last_name": "Doe 14",
                "title": "Party 14",
                "company": "Company 14",
                "address": "Address 14",
                "notes": "Notes 14",
                "email": "party14@example.com",
                "phone": "00000000014",
                "street": "Street 14",
                "city": "City 14",
                "state": "State 14",
                "zip_code": "0000014",
                "country": "Country 14",
                "tags": [
                  "Tag 1",
                  "Tag 2"
                ],
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
                "contacts": {
                  "data": [
                    {
                      "id": "31",
                      "type": "contact",
                      "attributes": {
                        "first_name": "John 1",
                        "last_name": "Doe 1",
                        "contact_type": "Third Party 1"
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

    post 'Create Party' do

      let!(:admin_user) { create :admin_user }

      tags 'Parties'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'party[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'party[email]', :in => :formData, :type => :string, required: true
      parameter name: 'party[first_name]', :in => :formData, :type => :string, required: true
      parameter name: 'party[last_name]', :in => :formData, :type => :string, required: true
      parameter name: 'party[title]', :in => :formData, :type => :string
      parameter name: 'party[company]', :in => :formData, :type => :string
      parameter name: 'party[address]', :in => :formData, :type => :string
      parameter name: 'party[notes]', :in => :formData, :type => :string
      parameter name: 'party[phone]', :in => :formData, :type => :string
      parameter name: 'party[street]', :in => :formData, :type => :string
      parameter name: 'party[city]', :in => :formData, :type => :string
      parameter name: 'party[state]', :in => :formData, :type => :string
      parameter name: 'party[zip_code]', :in => :formData, :type => :string
      parameter name: 'party[country]', :in => :formData, :type => :string
      parameter name: 'party[tags][0]', :in => :formData, :type => :string, description: "Example: 'cat'"
      parameter name: 'party[tags][1]', :in => :formData, :type => :string, description: "Example: 'dog'"

      response '201', 'Success' do


        let(:data) { attributes_for :party }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "party",
            "attributes": {
              "first_name": "John 14",
              "last_name": "Doe 14",
              "title": "Party 14",
              "company": "Company 14",
              "address": "Address 14",
              "notes": "Notes 14",
              "email": "party14@example.com",
              "phone": "00000000014",
              "street": "Street 14",
              "city": "City 14",
              "state": "State 14",
              "zip_code": "0000014",
              "country": "Country 14",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
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
              "contacts": {
                "data": [
                  {
                    "id": "31",
                    "type": "contact",
                    "attributes": {
                      "first_name": "John 1",
                      "last_name": "Doe 1",
                      "contact_type": "Third Party 1"
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

        let(:data) { attributes_for :party, :empty_admin_user_id }
        let(:data) { attributes_for :party, :empty_case_id }
        let(:data) { attributes_for :party, :empty_first_name }
        let(:data) { attributes_for :party, :empty_last_name }
        let(:data) { attributes_for :party, :empty_title }
        let(:data) { attributes_for :party, :empty_company }
        let(:data) { attributes_for :party, :empty_address }
        let(:data) { attributes_for :party, :empty_notes }
        let(:data) { attributes_for :party, :empty_email }
        let(:data) { attributes_for :party, :empty_phone }
        let(:data) { attributes_for :party, :empty_street }
        let(:data) { attributes_for :party, :empty_city }
        let(:data) { attributes_for :party, :empty_state }
        let(:data) { attributes_for :party, :empty_zip_code }
        let(:data) { attributes_for :party, :empty_country }
        let(:data) { attributes_for :party, :empty_tags }
        run_test!
      end
    end

  end

  path '/admin/api/parties/{id}' do

    get 'Get Party' do

      let!(:admin_user) { create :admin_user }
      let!(:party) { create :party }

      tags 'Parties'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { party.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "party",
            "attributes": {
              "first_name": "John 14",
              "last_name": "Doe 14",
              "title": "Party 14",
              "company": "Company 14",
              "address": "Address 14",
              "notes": "Notes 14",
              "email": "party14@example.com",
              "phone": "00000000014",
              "street": "Street 14",
              "city": "City 14",
              "state": "State 14",
              "zip_code": "0000014",
              "country": "Country 14",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
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
              "contacts": {
                "data": [
                  {
                    "id": "31",
                    "type": "contact",
                    "attributes": {
                      "first_name": "John 1",
                      "last_name": "Doe 1",
                      "contact_type": "Third Party 1"
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
    end

    put 'Update Party' do

      let!(:admin_user) { create :admin_user }
      let!(:party) { create :party }
      let(:id) { party.id }

      tags 'Parties'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'party[case_id]', :in => :formData, :type => :integer
      parameter name: 'party[first_name]', :in => :formData, :type => :string
      parameter name: 'party[last_name]', :in => :formData, :type => :string
      parameter name: 'party[title]', :in => :formData, :type => :string
      parameter name: 'party[company]', :in => :formData, :type => :string
      parameter name: 'party[address]', :in => :formData, :type => :string
      parameter name: 'party[notes]', :in => :formData, :type => :string
      parameter name: 'party[email]', :in => :formData, :type => :string
      parameter name: 'party[phone]', :in => :formData, :type => :string
      parameter name: 'party[street]', :in => :formData, :type => :string
      parameter name: 'party[city]', :in => :formData, :type => :string
      parameter name: 'party[state]', :in => :formData, :type => :string
      parameter name: 'party[zip_code]', :in => :formData, :type => :string
      parameter name: 'party[country]', :in => :formData, :type => :string
      parameter name: 'party[tags][0]', :in => :formData, :type => :string, description: "Example: 'cat'"
      parameter name: 'party[tags][1]', :in => :formData, :type => :string, description: "Example: 'dog'"

      response '204', 'Updated' do

        let(:data) { attributes_for :party }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do

        let(:data) { attributes_for :party, :empty_admin_user_id }
        let(:data) { attributes_for :party, :empty_case_id }
        let(:data) { attributes_for :party, :empty_first_name }
        let(:data) { attributes_for :party, :empty_last_name }
        let(:data) { attributes_for :party, :empty_title }
        let(:data) { attributes_for :party, :empty_company }
        let(:data) { attributes_for :party, :empty_address }
        let(:data) { attributes_for :party, :empty_notes }
        let(:data) { attributes_for :party, :empty_email }
        let(:data) { attributes_for :party, :empty_phone }
        let(:data) { attributes_for :party, :empty_street }
        let(:data) { attributes_for :party, :empty_city }
        let(:data) { attributes_for :party, :empty_state }
        let(:data) { attributes_for :party, :empty_zip_code }
        let(:data) { attributes_for :party, :empty_country }
        let(:data) { attributes_for :party, :empty_tags }
        run_test!
      end
    end

    delete 'Destroy Party' do

      let!(:admin_user) { create :admin_user }
      let!(:party) { create :party }

      tags 'Parties'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do

        let(:id) { party.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

  path '/admin/api/parties/{id}/send_signature_request' do
    post 'Send Signature Request' do
      tags 'Parties'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true

      response '200', 'Success' do
        let(:data) { attributes_for :party }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end
end
