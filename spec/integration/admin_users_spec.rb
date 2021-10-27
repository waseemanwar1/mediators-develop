require 'swagger_helper'

RSpec.describe 'Admin Users API', type: :request do

  path '/admin/api/admin_users/info' do

    get 'Get Admin User Info' do
      let!(:admin_user) { create :admin_user }

      tags 'Admin Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"

      response '200', 'Success' do

          examples 'application/json' => {
            data: {
              id: "1",
              type: "admin_user",
              attribures: {
                email: "mediator@example.com",
                first_name: "Test",
                last_name: "Mediator",
                avatar: "http://142.93.11.131/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBCZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--36c2a0f4812fdd7b49e5669e18331aeb753033bd/Checked_icon_2.png?locale=en",
                hourly_rate: 100,
                company_name: "Company Name",
                phone: "0000000000",
                company_website: "https://company.website",
                address_line_1: "Address Line 1",
                address_line_2: "Address Line 2",
                postcode: "000000",
                city: "New York",
                state: "New York",
                country: "USA",
                billing_address_line_1: "Address Line 1",
                billing_address_line_2: "Address Line 2",
                billing_postcode: "000000",
                billing_city: "New York",
                billing_state: "New York",
                billing_country: "USA",
                created_at: "2020-07-02T10:46:44.223Z",
                updated_at: "2020-07-02T10:46:44.223Z",
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

  end

  path '/admin/api/admin_users/update_info' do
    put 'Update Admin User' do

      let!(:admin_user) { create :admin_user }
      let(:id) { admin_user.id }

      tags 'Admin Users'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true, description: "Use a JWT auth_token which returns after sign in"
      parameter name: 'admin_user[email]', :in => :formData, :type => :string
      parameter name: 'admin_user[password]', :in => :formData, :type => :string
      parameter name: 'admin_user[password_confirmation]', :in => :formData, :type => :string
      parameter name: 'admin_user[first_name]', :in => :formData, :type => :string
      parameter name: 'admin_user[last_name]', :in => :formData, :type => :string
      parameter name: 'admin_user[avatar]', :in => :formData, :type => :file
      parameter name: 'admin_user[hourly_rate]', :in => :formData, :type => :integer
      parameter name: 'admin_user[company_name]', :in => :formData, :type => :string
      parameter name: 'admin_user[phone]', :in => :formData, :type => :string
      parameter name: 'admin_user[company_website]', :in => :formData, :type => :string
      parameter name: 'admin_user[address_line_1]', :in => :formData, :type => :string
      parameter name: 'admin_user[address_line_2]', :in => :formData, :type => :string
      parameter name: 'admin_user[postcode]', :in => :formData, :type => :string
      parameter name: 'admin_user[city]', :in => :formData, :type => :string
      parameter name: 'admin_user[state]', :in => :formData, :type => :string
      parameter name: 'admin_user[country]', :in => :formData, :type => :string
      parameter name: 'admin_user[billing_address_line_1]', :in => :formData, :type => :string
      parameter name: 'admin_user[billing_address_line_2]', :in => :formData, :type => :string
      parameter name: 'admin_user[billing_postcode]', :in => :formData, :type => :string
      parameter name: 'admin_user[billing_city]', :in => :formData, :type => :string
      parameter name: 'admin_user[billing_state]', :in => :formData, :type => :string
      parameter name: 'admin_user[billing_country]', :in => :formData, :type => :string

      response '204', 'Updated' do
        let(:data) { attributes_for :admin_user }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

      response '422', 'Failed' do
        let(:data) { attributes_for :admin_user, :empty_first_name }
        run_test!
      end
    end
  end
end
