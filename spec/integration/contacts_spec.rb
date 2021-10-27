require 'swagger_helper'

RSpec.describe 'Contacts API', type: :request do

  path '/admin/api/contacts' do

    get 'Get Contacts' do

      let!(:admin_user) { create :admin_user }
      let!(:contact) { create :contact }

      tags 'Contacts'
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
              "type": "contact",
              "attributes": {
                "first_name": "John 14",
                "last_name": "Doe 14",
                "contact_type": "Third Person 14",
                "email": "contact14@example.com",
                "title": "Contact 14",
                "company": "Company 14",
                "phone": "0000000000",
                "address": "Address 14",
                "notes": "Notes 14",
                "street": "Street 14",
                "city": "City 14",
                "state": "State 14",
                "zip_code": "00000014",
                "country": "USA",
                "tags": [
                  "Tag 1",
                  "Tag 2"
                ],
                "created_at": "2020-07-02T10:46:49.040Z",
                "updated_at": "2020-07-02T10:46:49.040Z",
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
                "cases": {
                   "data": [
                     {
                       "id": "2",
                       "type": "case",
                       "attributes": {
                         "name": "Case 2"
                       }
                     },
                     {
                       "id": "4",
                       "type": "case",
                       "attributes": {
                         "name": "Case 4"
                       }
                     }
                   ]
                 },
                 "parties": {
                   "data": [
                     {
                       "id": "2",
                       "type": "party",
                       "attributes": {
                         "first_name": "John 2",
                         "last_name": "Doe 2"
                       }
                     },
                     {
                       "id": "4",
                       "type": "party",
                       "attributes": {
                         "first_name": "John 4",
                         "last_name": "Doe 4"
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

    post 'Create Contact' do

      let!(:admin_user) { create :admin_user }

      tags 'Contacts'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'contact[case_ids][0]', :in => :formData, :type => :integer, required: true
      parameter name: 'contact[case_ids][1]', :in => :formData, :type => :integer, required: true
      parameter name: 'contact[party_ids][0]', :in => :formData, :type => :integer, required: true
      parameter name: 'contact[party_ids][1]', :in => :formData, :type => :integer, required: true
      parameter name: 'contact[first_name]', :in => :formData, :type => :string, required: true
      parameter name: 'contact[last_name]', :in => :formData, :type => :string, required: true
      parameter name: 'contact[contact_type]', :in => :formData, :type => :string
      parameter name: 'contact[email]', :in => :formData, :type => :string
      parameter name: 'contact[title]', :in => :formData, :type => :string
      parameter name: 'contact[company]', :in => :formData, :type => :string
      parameter name: 'contact[phone]', :in => :formData, :type => :string
      parameter name: 'contact[address]', :in => :formData, :type => :string
      parameter name: 'contact[notes]', :in => :formData, :type => :string
      parameter name: 'contact[street]', :in => :formData, :type => :string
      parameter name: 'contact[city]', :in => :formData, :type => :string
      parameter name: 'contact[state]', :in => :formData, :type => :string
      parameter name: 'contact[zip_code]', :in => :formData, :type => :string
      parameter name: 'contact[country]', :in => :formData, :type => :string
      parameter name: 'contact[tags][0]', :in => :formData, :type => :string, description: "Example: 'cat'"
      parameter name: 'contact[tags][1]', :in => :formData, :type => :string, description: "Example: 'dog'"

      response '201', 'Success' do


        let(:data) { attributes_for :contact }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "contact",
            "attributes": {
              "first_name": "John 14",
              "last_name": "Doe 14",
              "contact_type": "Third Person 14",
              "email": "contact14@example.com",
              "title": "Contact 14",
              "company": "Company 14",
              "phone": "0000000000",
              "address": "Address 14",
              "notes": "Notes 14",
              "street": "Street 14",
              "city": "City 14",
              "state": "State 14",
              "zip_code": "00000014",
              "country": "USA",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
              "created_at": "2020-07-02T10:46:49.040Z",
              "updated_at": "2020-07-02T10:46:49.040Z",
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
              "cases": {
                 "data": [
                   {
                     "id": "2",
                     "type": "case",
                     "attributes": {
                       "name": "Case 2"
                     }
                   },
                   {
                     "id": "4",
                     "type": "case",
                     "attributes": {
                       "name": "Case 4"
                     }
                   }
                 ]
               },
               "parties": {
                 "data": [
                   {
                     "id": "2",
                     "type": "party",
                     "attributes": {
                       "first_name": "John 2",
                       "last_name": "Doe 2"
                     }
                   },
                   {
                     "id": "4",
                     "type": "party",
                     "attributes": {
                       "first_name": "John 4",
                       "last_name": "Doe 4"
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

        let(:data) { attributes_for :contact, :empty_admin_user_id }
        let(:data) { attributes_for :contact, :empty_case_id }
        let(:data) { attributes_for :contact, :empty_party_id }
        let(:data) { attributes_for :contact, :empty_first_name }
        let(:data) { attributes_for :contact, :empty_last_name }
        let(:data) { attributes_for :contact, :empty_contact_type }
        let(:data) { attributes_for :contact, :empty_email }
        let(:data) { attributes_for :contact, :empty_title }
        let(:data) { attributes_for :contact, :empty_company }
        let(:data) { attributes_for :contact, :empty_phone }
        let(:data) { attributes_for :contact, :empty_address }
        let(:data) { attributes_for :contact, :empty_notes }
        let(:data) { attributes_for :contact, :empty_street }
        let(:data) { attributes_for :contact, :empty_city }
        let(:data) { attributes_for :contact, :empty_state }
        let(:data) { attributes_for :contact, :empty_zip_code }
        let(:data) { attributes_for :contact, :empty_country }
        let(:data) { attributes_for :contact, :empty_tags }
        run_test!
      end
    end

  end

  path '/admin/api/contacts/{id}' do

    get 'Get Contact' do

      let!(:admin_user) { create :admin_user }
      let!(:contact) { create :contact }

      tags 'Contacts'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do


        let(:id) { contact.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "contact",
            "attributes": {
              "first_name": "John 14",
              "last_name": "Doe 14",
              "contact_type": "Third Person 14",
              "email": "contact14@example.com",
              "title": "Contact 14",
              "company": "Company 14",
              "phone": "0000000000",
              "address": "Address 14",
              "notes": "Notes 14",
              "street": "Street 14",
              "city": "City 14",
              "state": "State 14",
              "zip_code": "00000014",
              "country": "USA",
              "tags": [
                "Tag 1",
                "Tag 2"
              ],
              "created_at": "2020-07-02T10:46:49.040Z",
              "updated_at": "2020-07-02T10:46:49.040Z",
              "case_name": "Case 14",
              "party_name": "Party 14",
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
              "cases": {
                 "data": [
                   {
                     "id": "2",
                     "type": "case",
                     "attributes": {
                       "name": "Case 2"
                     }
                   },
                   {
                     "id": "4",
                     "type": "case",
                     "attributes": {
                       "name": "Case 4"
                     }
                   }
                 ]
               },
               "parties": {
                 "data": [
                   {
                     "id": "2",
                     "type": "party",
                     "attributes": {
                       "first_name": "John 2",
                       "last_name": "Doe 2"
                     }
                   },
                   {
                     "id": "4",
                     "type": "party",
                     "attributes": {
                       "first_name": "John 4",
                       "last_name": "Doe 4"
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

    put 'Update Contact' do

      let!(:admin_user) { create :admin_user }
      let!(:contact) { create :contact }
      let(:id) { contact.id }

      tags 'Contacts'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'contact[case_ids][0]', :in => :formData, :type => :integer
      parameter name: 'contact[case_ids][1]', :in => :formData, :type => :integer
      parameter name: 'contact[party_ids][0]', :in => :formData, :type => :integer
      parameter name: 'contact[party_ids][1]', :in => :formData, :type => :integer
      parameter name: 'contact[first_name]', :in => :formData, :type => :string
      parameter name: 'contact[last_name]', :in => :formData, :type => :string
      parameter name: 'contact[contact_type]', :in => :formData, :type => :string
      parameter name: 'contact[email]', :in => :formData, :type => :string
      parameter name: 'contact[title]', :in => :formData, :type => :string
      parameter name: 'contact[company]', :in => :formData, :type => :string
      parameter name: 'contact[phone]', :in => :formData, :type => :string
      parameter name: 'contact[address]', :in => :formData, :type => :string
      parameter name: 'contact[notes]', :in => :formData, :type => :string
      parameter name: 'contact[street]', :in => :formData, :type => :string
      parameter name: 'contact[city]', :in => :formData, :type => :string
      parameter name: 'contact[state]', :in => :formData, :type => :string
      parameter name: 'contact[zip_code]', :in => :formData, :type => :string
      parameter name: 'contact[country]', :in => :formData, :type => :string
      parameter name: 'contact[tags][0]', :in => :formData, :type => :string, description: "Example: 'cat'"
      parameter name: 'contact[tags][1]', :in => :formData, :type => :string, description: "Example: 'dog'"

      response '204', 'Updated' do

        let(:data) { attributes_for :contact }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do

        let(:data) { attributes_for :contact, :empty_admin_user_id }
        let(:data) { attributes_for :contact, :empty_case_id }
        let(:data) { attributes_for :contact, :empty_party_id }
        let(:data) { attributes_for :contact, :empty_first_name }
        let(:data) { attributes_for :contact, :empty_last_name }
        let(:data) { attributes_for :contact, :empty_contact_type }
        let(:data) { attributes_for :contact, :empty_email }
        let(:data) { attributes_for :contact, :empty_title }
        let(:data) { attributes_for :contact, :empty_company }
        let(:data) { attributes_for :contact, :empty_phone }
        let(:data) { attributes_for :contact, :empty_address }
        let(:data) { attributes_for :contact, :empty_notes }
        let(:data) { attributes_for :contact, :empty_street }
        let(:data) { attributes_for :contact, :empty_city }
        let(:data) { attributes_for :contact, :empty_state }
        let(:data) { attributes_for :contact, :empty_zip_code }
        let(:data) { attributes_for :contact, :empty_country }
        let(:data) { attributes_for :contact, :empty_tags }
        run_test!
      end
    end

    delete 'Destroy Contact' do

      let!(:admin_user) { create :admin_user }
      let!(:contact) { create :contact }

      tags 'Contacts'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do

        let(:id) { contact.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

end
