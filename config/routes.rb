require 'api_constraints'
require 'sidekiq/web'

Rails.application.routes.draw do

  # Open routes start
    # root to: redirect{ |params, request| "/admin?#{request.params.to_query}" }
  # Open routes end

  # Open API routes start
  # Open API routes end

  # Client routes start
  # Client routes end

  # Client API routes start
  # Client API routes end

  # Admin routes start
    # Admin Devise routes start
      devise_for :admin_users, path: 'admin', controllers: { sessions: "admin_users/sessions", registrations: "admin_users/registrations", passwords: 'admin_users/passwords' }
    # Admin Devise routes end

    namespace :admin do

      # Admin Sidekiq routes start
        authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_sidekiq).manage? } do
          mount Sidekiq::Web, at: '/sidekiq'
        end
      # Admin Sidekiq routes end

      # Admin API Documentation routes start
        authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_api).manage? } do
          mount Rswag::Ui::Engine => '/api-docs'
          mount Rswag::Api::Engine => '/api-docs'
        end
      # Admin API Documentation routes end

      # Admin Dashboard & Profile routes start
        authenticate :admin_user do
          root to: 'dashboard#index'

          resource :profile, only: [:update, :destroy] do
            member do
              get :my
              get :settings
            end
          end
        end
      # Admin Dashboard & Profile routes end

      # Admin Permissions, AdminUsers, and Groups routes end
        authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_permissions).manage? } do
          resources :permissions, only: [:index] do
            collection do
              get :search_admin_users
              get :search_groups
              get :search_permissions
              get :get_references
              post :add_references
              post :remove_references
            end
          end

          resources :admin_users do
            collection { get :search }
          end
          resources :groups do
            collection { get :search }
          end
        end
      # Admin Permissions, AdminUsers, and Groups routes end

      # Admin API start
        namespace :api, defaults: { format: 'json' } do
          scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
            devise_scope :admin_user do
              post 'sign_in' => 'session#sign_in'
              post 'sign_up' => 'registration#sign_up'
              post 'password_forgot', to: 'password#forgot'
              post 'password_reset', to: 'password#reset'
            end

            # Admin API routes start
              resources :admin_users, only: [] do
                collection do
                  put :update_info
                  get :info
                end
              end
              resources :cases
              resources :parties do
                member do
                  post :send_signature_request
                end
              end
              resources :sessions
              resources :messages
              resources :reminders
              resources :contacts
              resources :invoices do
                collection do
                  get :secret
                end
              end
              resources :documents
              resources :issues
              resources :agreements do
                member do
                  post :send_document
                end
              end
              resources :agreement_templates
              resources :subscriptions, only: [:index, :create] do
                collection do
                  get :show_payment_method
                  post :retry
                  post :unsubscribe
                  post :update_plan
                  get :history
                end
              end
            # Admin API routes end
          end
        end
      # Admin API end
    end

    # Admin Mediators routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_mediators).manage? } do
        namespace :admin do
          resources :mediators do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Case routes end

    # Admin Cases routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_cases).manage? } do
        namespace :admin do
          resources :cases do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Case routes end

    # Admin Parties routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_parties).manage? } do
        namespace :admin do
          resources :parties do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Party routes end

    # Admin Sessions routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_sessions).manage? } do
        namespace :admin do
          resources :sessions do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Session routes end

    # Admin Messages routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_messages).manage? } do
        namespace :admin do
          resources :messages do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Message routes end

    # Admin Documents routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_documents).manage? } do
        namespace :admin do
          resources :documents do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Document routes end

    # Admin Reminders routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_reminders).manage? } do
        namespace :admin do
          resources :reminders do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Reminder routes end

    # Admin Contacts routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_contacts).manage? } do
        namespace :admin do
          resources :contacts do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Contact routes end

    # Admin Invoices routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_invoices).manage? } do
        namespace :admin do
          resources :invoices do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Invoice routes end

    # Admin Issues routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_issues).manage? } do
        namespace :admin do
          resources :issues do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Issue routes end

    # Admin Agreements routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_agreements).manage? } do
        namespace :admin do
          resources :agreements do
            collection do
              get :search
            end
          end
        end
      end
    # Admin Agreement routes end

    # Admin AgreementTemplates routes start
      authenticate :admin_user, lambda { |u| Pundit.policy(u, :manage_agreement_templates).manage? } do
        namespace :admin do
          resources :agreement_templates do
            collection do
              get :search
            end
          end
        end
      end
    # Admin AgreementTemplate routes end
  # Admin routes end

  # Webhooks routes start
  namespace :webhooks do
    mount StripeEvent::Engine, at: '/invoice'
    get 'connect-oauth', to: 'connect#oauth'
  end
  # Webhooks routes end
end
