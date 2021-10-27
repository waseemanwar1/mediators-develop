require 'swagger_helper'

RSpec.describe 'Messages API', type: :request do

  path '/admin/api/messages' do

    get 'Get Messages' do

      let!(:admin_user) { create :admin_user }
      let!(:message) { create :message }

      tags 'Messages'
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
              "type": "message",
              "attributes": {
                "subject": "Subject 14",
                "sent_at": "2020-07-02",
                "content": "Content 14",
                "from": "From 14",
                "to": "To 14",
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

    post 'Create Message' do

      let!(:admin_user) { create :admin_user }

      tags 'Messages'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'message[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'message[party_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'message[content]', :in => :formData, :type => :string

      response '201', 'Success' do

        let(:data) { attributes_for :message }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "message",
            "attributes": {
              "subject": "Subject 14",
              "sent_at": "2020-07-02",
              "content": "Content 14",
              "from": "From 14",
              "to": "To 14",
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

        let(:data) { attributes_for :message, :empty_admin_user_id }
        let(:data) { attributes_for :message, :empty_case_id }
        let(:data) { attributes_for :message, :empty_party_id }
        let(:data) { attributes_for :message, :empty_subject }
        let(:data) { attributes_for :message, :empty_sent_at }
        let(:data) { attributes_for :message, :empty_content }
        let(:data) { attributes_for :message, :empty_from }
        let(:data) { attributes_for :message, :empty_to }
        run_test!
      end
    end

  end

  path '/admin/api/messages/{id}' do

    get 'Get Message' do

      let!(:admin_user) { create :admin_user }
      let!(:message) { create :message }

      tags 'Messages'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do

        let(:id) { message.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "message",
            "attributes": {
              "subject": "Subject 14",
              "sent_at": "2020-07-02",
              "content": "Content 14",
              "from": "From 14",
              "to": "To 14",
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

    # put 'Update Message' do
    #
    #   let!(:admin_user) { create :admin_user }
    #   let!(:message) { create :message }
    #   let(:id) { message.id }
    #
    #   tags 'Messages'
    #   consumes 'multipart/form-data'
    #
    #   parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
    #   parameter name: 'id', :in => :path, :type => :integer, required: true
    #   parameter name: 'message[case_id]', :in => :formData, :type => :integer
    #   parameter name: 'message[party_id]', :in => :formData, :type => :integer
    #   parameter name: 'message[subject]', :in => :formData, :type => :string
    #   parameter name: 'message[sent_at]', :in => :formData, :type => :string
    #   parameter name: 'message[content]', :in => :formData, :type => :string
    #   parameter name: 'message[from]', :in => :formData, :type => :string
    #   parameter name: 'message[to]', :in => :formData, :type => :string
    #
    #   response '204', 'Updated' do
    #
    #     let(:data) { attributes_for :message }
    #     run_test!
    #   end
    #
    #   response '401', 'Unauthorized' do
    #     let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
    #     run_test!
    #   end
    #
    #   response '422', 'Failed' do
    #
    #     let(:data) { attributes_for :message, :empty_admin_user_id }
    #     let(:data) { attributes_for :message, :empty_case_id }
    #     let(:data) { attributes_for :message, :empty_party_id }
    #     let(:data) { attributes_for :message, :empty_subject }
    #     let(:data) { attributes_for :message, :empty_sent_at }
    #     let(:data) { attributes_for :message, :empty_content }
    #     let(:data) { attributes_for :message, :empty_from }
    #     let(:data) { attributes_for :message, :empty_to }
    #     run_test!
    #   end
    # end
    #
    # delete 'Destroy Message' do
    #
    #   let!(:admin_user) { create :admin_user }
    #   let!(:message) { create :message }
    #
    #   tags 'Messages'
    #   consumes 'application/json'
    #   produces 'application/json'
    #
    #   parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
    #   parameter name: :id, :in => :path, :type => :integer, required: true
    #
    #   response '204', 'Success' do
    #
    #     let(:id) { message.id }
    #     run_test!
    #   end
    #
    #   response '401', 'Unauthorized' do
    #     let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
    #     run_test!
    #   end
    # end

  end

end
