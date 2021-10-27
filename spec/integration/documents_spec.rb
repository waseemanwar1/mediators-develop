require 'swagger_helper'

RSpec.describe 'Documents API', type: :request do

  path '/admin/api/documents' do

    get 'Get Documents' do

      let!(:admin_user) { create :admin_user }
      let!(:document) { create :document }

      tags 'Documents'
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
              "type": "document",
              "attributes": {
                "file_name": "File Name 14",
                "description": "Description 14",
                "date": "2020-07-02",
                "author": "Author 14",
                "created_at": "2020-07-02T10:46:48.188Z",
                "updated_at": "2020-07-02T10:46:48.188Z",
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
                "file": "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--6723a13852bd9f682435002737d382f766627241/Check%20mark.png"
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

    post 'Create Document' do

      let!(:admin_user) { create :admin_user }

      tags 'Documents'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'document[case_id]', :in => :formData, :type => :integer, required: true
      parameter name: 'document[file_name]', :in => :formData, :type => :string, required: true
      parameter name: 'document[description]', :in => :formData, :type => :string
      parameter name: 'document[date]', :in => :formData, :type => :string
      parameter name: 'document[author]', :in => :formData, :type => :string
      parameter name: 'document[file]', :in => :formData, :type => :file

      response '201', 'Success' do


        let(:data) { attributes_for :document }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "document",
            "attributes": {
              "file_name": "File Name 14",
              "description": "Description 14",
              "date": "2020-07-02",
              "author": "Author 14",
              "created_at": "2020-07-02T10:46:48.188Z",
              "updated_at": "2020-07-02T10:46:48.188Z",
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
              "file": "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--6723a13852bd9f682435002737d382f766627241/Check%20mark.png"
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

        let(:data) { attributes_for :document, :empty_admin_user_id }
        let(:data) { attributes_for :document, :empty_case_id }
        let(:data) { attributes_for :document, :empty_file_name }
        let(:data) { attributes_for :document, :empty_description }
        let(:data) { attributes_for :document, :empty_date }
        let(:data) { attributes_for :document, :empty_author }
        run_test!
      end
    end

  end

  path '/admin/api/documents/{id}' do

    get 'Get Document' do

      let!(:admin_user) { create :admin_user }
      let!(:document) { create :document }

      tags 'Documents'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '200', 'Success' do


        let(:id) { document.id }

        examples 'application/json' => {
          "data": {
            "id": "14",
            "type": "document",
            "attributes": {
              "file_name": "File Name 14",
              "description": "Description 14",
              "date": "2020-07-02",
              "author": "Author 14",
              "created_at": "2020-07-02T10:46:48.188Z",
              "updated_at": "2020-07-02T10:46:48.188Z",
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
              "file": "http://localhost:3000/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--6723a13852bd9f682435002737d382f766627241/Check%20mark.png"
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

    put 'Update Document' do

      let!(:admin_user) { create :admin_user }
      let!(:document) { create :document }
      let(:id) { document.id }

      tags 'Documents'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'id', :in => :path, :type => :integer, required: true
      parameter name: 'document[case_id]', :in => :formData, :type => :integer
      parameter name: 'document[file_name]', :in => :formData, :type => :string
      parameter name: 'document[description]', :in => :formData, :type => :string
      parameter name: 'document[date]', :in => :formData, :type => :string
      parameter name: 'document[author]', :in => :formData, :type => :string
      parameter name: 'document[file]', :in => :formData, :type => :file

      response '204', 'Updated' do

        let(:data) { attributes_for :document }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do

        let(:data) { attributes_for :document, :empty_admin_user_id }
        let(:data) { attributes_for :document, :empty_case_id }
        let(:data) { attributes_for :document, :empty_file_name }
        let(:data) { attributes_for :document, :empty_description }
        let(:data) { attributes_for :document, :empty_date }
        let(:data) { attributes_for :document, :empty_author }
        run_test!
      end
    end

    delete 'Destroy Document' do

      let!(:admin_user) { create :admin_user }
      let!(:document) { create :document }

      tags 'Documents'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: :id, :in => :path, :type => :integer, required: true

      response '204', 'Success' do

        let(:id) { document.id }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end
    end

  end

end
