require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do

  path '/admin/api/sign_in' do

    post 'Sign in User' do

      let!(:admin_user) { create(:admin_user) }

      tags 'Authentication'
      consumes 'multipart/form-data'

      parameter name: 'admin_user[email]', :in => :formData, :type => :string, required: true
      parameter name: 'admin_user[password]', :in => :formData, :type => :string, required: true

      response '200', 'Sign in success' do

        let(:data) { attributes_for :admin_user }

        schema type: :object,
          properties: {
            auth_token: { type: :string },
            admin_user: {
              type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string }
              }
            }
          },
          required: [ 'auth_token', 'admin_user' ]

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data['admin_user']['id']).to eq(admin_user.id)
          expect(data['admin_user']['email']).to eq(admin_user.email)
        end

      end

      response '401', 'Sign in error' do
        let(:data) { attributes_for :admin_user, :empty_email }
        run_test!
      end

      response '401', 'Sign up error' do
        let(:data) { attributes_for :admin_user, :empty_password }
        run_test!
      end

    end

  end

  path '/admin/api/sign_up' do

    post 'Sign up User' do

      tags 'Authentication'
      consumes 'multipart/form-data'

      parameter name: 'admin_user[email]', :in => :formData, :type => :string, required: true
      parameter name: 'admin_user[password]', :in => :formData, :type => :string, required: true
      parameter name: 'admin_user[password_confirmation]', :in => :formData, :type => :string, required: true

      response '201', 'Sign up success' do

        let(:data) { attributes_for :admin_user }

        schema type: :object,
          properties: {
            auth_token: { type: :string },
            admin_user: {
              type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string },
              }
            }
          },
          required: [ 'auth_token', 'admin_user' ]

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['admin_user']['email']).to eq(data[:email])
        end

      end

      response '401', 'Sign up error' do
        let(:data) { attributes_for :admin_user, :empty_email }
        run_test!
      end

      response '401', 'Sign up error' do
        let(:data) { attributes_for :admin_user, :empty_password }
        run_test!
      end

      response '401', 'Sign up error' do
        let(:data) { attributes_for :admin_user, :empty_password_confirmation }
        run_test!
      end
    end

  end

  path '/admin/api/password_forgot' do
    post 'Password Forgot' do

      tags 'Authentication'
      consumes 'multipart/form-data'

      parameter name: 'admin_user[email]', :in => :formData, :type => :string, required: true

      response '200', "Password Forgot Success" do
        let(:data) { attributes_for :admin_user }
        run_test!
      end

      response '404', "Password Forgot No Found" do
        let(:data) { attributes_for :admin_user, :wrong_email }
        run_test!
      end

    end
  end

  path '/admin/api/password_reset' do
    post 'Password Reset' do

      tags 'Authentication'
      consumes 'multipart/form-data'

      parameter name: :token, :in => :header, :type => :string, required: true, description: "Use token from a path"
      parameter name: 'admin_user[password]', :in => :formData, :type => :string, required: true
      parameter name: 'admin_user[password_confirmation]', :in => :formData, :type => :string, required: true

      response '200', "Password Reset Success" do
        let(:data) { attributes_for :admin_user }
        run_test!
      end

      response '404', "Password Reset No Found" do
        let(:data) { attributes_for :admin_user, :wrong_token }
        run_test!
      end

    end
  end
end
