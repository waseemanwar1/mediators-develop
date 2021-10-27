require 'swagger_helper'

RSpec.describe 'Subscriptions API', type: :request do

  path '/admin/api/subscriptions' do
    get 'Get Subscriptions' do

      tags 'Subscriptions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true

      response '200', 'Success' do

        examples 'application/json' => [
          {
            "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
            "object": "plan",
            "active": true,
            "aggregate_usage": nil,
            "amount": 10000,
            "amount_decimal": "10000",
            "billing_scheme": "per_unit",
            "created": 1593172062,
            "currency": "usd",
            "interval": "year",
            "interval_count": 1,
            "livemode": false,
            "metadata": {},
            "name": "Yearly Basic Plan",
            "nickname": nil,
            "product": "prod_HXKhzUid1c87CM",
            "statement_descriptor": nil,
            "tiers": nil,
            "tiers_mode": nil,
            "transform_usage": nil,
            "trial_period_days": nil,
            "usage_type": "licensed"
          }
        ]

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end

    post 'Create Subscription' do

      tags 'Subscriptions'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true
      parameter name: 'plan_id', :in => :formData, :type => :string, required: true
      parameter name: 'payment_method_id', :in => :formData, :type => :string, required: true

      response '200', 'Success' do

        examples 'application/json' => {
          "id": "sub_HZlIwTz0aIyn7f",
          "object": "subscription",
          "application_fee_percent": nil,
          "billing": "charge_automatically",
          "billing_cycle_anchor": 1593732272,
          "billing_thresholds": nil,
          "cancel_at": nil,
          "cancel_at_period_end": false,
          "canceled_at": nil,
          "collection_method": "charge_automatically",
          "created": 1593732272,
          "current_period_end": 1625268272,
          "current_period_start": 1593732272,
          "customer": "cus_HZZ4T8JCStoNd5",
          "days_until_due": nil,
          "default_payment_method": nil,
          "default_source": nil,
          "default_tax_rates": [],
          "discount": nil,
          "ended_at": nil,
          "invoice_customer_balance_settings": {
            "consume_applied_balance_on_void": true
          },
          "items": {
            "object": "list",
            "data": [
              {
                "id": "si_HZlIRvMKgDiSGo",
                "object": "subscription_item",
                "billing_thresholds": nil,
                "created": 1593732273,
                "metadata": {},
                "plan": {
                  "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                  "object": "plan",
                  "active": true,
                  "aggregate_usage": nil,
                  "amount": 10000,
                  "amount_decimal": "10000",
                  "billing_scheme": "per_unit",
                  "created": 1593172062,
                  "currency": "usd",
                  "interval": "year",
                  "interval_count": 1,
                  "livemode": false,
                  "metadata": {},
                  "name": "Yearly Basic Plan",
                  "nickname": nil,
                  "product": "prod_HXKhzUid1c87CM",
                  "statement_descriptor": nil,
                  "tiers": nil,
                  "tiers_mode": nil,
                  "transform_usage": nil,
                  "trial_period_days": nil,
                  "usage_type": "licensed"
                },
                "price": {
                  "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                  "object": "price",
                  "active": true,
                  "billing_scheme": "per_unit",
                  "created": 1593172062,
                  "currency": "usd",
                  "livemode": false,
                  "lookup_key": nil,
                  "metadata": {},
                  "nickname": nil,
                  "product": "prod_HXKhzUid1c87CM",
                  "recurring": {
                    "aggregate_usage": nil,
                    "interval": "year",
                    "interval_count": 1,
                    "trial_period_days": nil,
                    "usage_type": "licensed"
                  },
                  "tiers_mode": nil,
                  "transform_quantity": nil,
                  "type": "recurring",
                  "unit_amount": 10000,
                  "unit_amount_decimal": "10000"
                },
                "quantity": 1,
                "subscription": "sub_HZlIwTz0aIyn7f",
                "tax_rates": []
              }
            ],
            "has_more": false,
            "total_count": 1,
            "url": "/v1/subscription_items?subscription=sub_HZlIwTz0aIyn7f"
          },
          "latest_invoice": {
            "id": "in_1H0blcJDA0jmlwUvmIEnUhz1",
            "object": "invoice",
            "account_country": "US",
            "account_name": nil,
            "amount_due": 10000,
            "amount_paid": 10000,
            "amount_remaining": 0,
            "application_fee": nil,
            "attempt_count": 1,
            "attempted": true,
            "auto_advance": false,
            "billing": "charge_automatically",
            "billing_reason": "subscription_update",
            "charge": "ch_1H0bldJDA0jmlwUvh47tnngg",
            "closed": true,
            "collection_method": "charge_automatically",
            "created": 1593732272,
            "currency": "usd",
            "custom_fields": nil,
            "customer": "cus_HZZ4T8JCStoNd5",
            "customer_address": nil,
            "customer_email": "mediator@example.com",
            "customer_name": nil,
            "customer_phone": nil,
            "customer_shipping": nil,
            "customer_tax_exempt": "none",
            "customer_tax_ids": [],
            "date": 1593732272,
            "default_payment_method": nil,
            "default_source": nil,
            "default_tax_rates": [],
            "description": nil,
            "discount": nil,
            "due_date": nil,
            "ending_balance": 0,
            "finalized_at": 1593732272,
            "footer": nil,
            "forgiven": false,
            "hosted_invoice_url": "https://pay.stripe.com/invoice/acct_1AFjyCJDA0jmlwUv/invst_HZlIlFNum4WFA2RzCo1WeW7HsKgGH89",
            "invoice_pdf": "https://pay.stripe.com/invoice/acct_1AFjyCJDA0jmlwUv/invst_HZlIlFNum4WFA2RzCo1WeW7HsKgGH89/pdf",
            "lines": {
              "object": "list",
              "data": [
                {
                  "id": "sub_HZlIwTz0aIyn7f",
                  "object": "line_item",
                  "amount": 10000,
                  "currency": "usd",
                  "description": nil,
                  "discountable": true,
                  "livemode": false,
                  "metadata": {},
                  "period": {
                    "end": 1625268272,
                    "start": 1593732272
                  },
                  "plan": {
                    "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                    "object": "plan",
                    "active": true,
                    "aggregate_usage": nil,
                    "amount": 10000,
                    "amount_decimal": "10000",
                    "billing_scheme": "per_unit",
                    "created": 1593172062,
                    "currency": "usd",
                    "interval": "year",
                    "interval_count": 1,
                    "livemode": false,
                    "metadata": {},
                    "name": "Yearly Basic Plan",
                    "nickname": nil,
                    "product": "prod_HXKhzUid1c87CM",
                    "statement_descriptor": nil,
                    "tiers": nil,
                    "tiers_mode": nil,
                    "transform_usage": nil,
                    "trial_period_days": nil,
                    "usage_type": "licensed"
                  },
                  "price": {
                    "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                    "object": "price",
                    "active": true,
                    "billing_scheme": "per_unit",
                    "created": 1593172062,
                    "currency": "usd",
                    "livemode": false,
                    "lookup_key": nil,
                    "metadata": {},
                    "nickname": nil,
                    "product": "prod_HXKhzUid1c87CM",
                    "recurring": {
                      "aggregate_usage": nil,
                      "interval": "year",
                      "interval_count": 1,
                      "trial_period_days": nil,
                      "usage_type": "licensed"
                    },
                    "tiers_mode": nil,
                    "transform_quantity": nil,
                    "type": "recurring",
                    "unit_amount": 10000,
                    "unit_amount_decimal": "10000"
                  },
                  "proration": false,
                  "quantity": 1,
                  "subscription": nil,
                  "subscription_item": "si_HZlIRvMKgDiSGo",
                  "tax_amounts": [],
                  "tax_rates": [],
                  "type": "subscription",
                  "unique_id": "il_1H0blcJDA0jmlwUvgHv5omwo",
                  "unique_line_item_id": "sli_2db3636606d041"
                }
              ],
              "has_more": false,
              "total_count": 1,
              "url": "/v1/invoices/in_1H0blcJDA0jmlwUvmIEnUhz1/lines"
            },
            "livemode": false,
            "metadata": {},
            "next_payment_attempt": nil,
            "number": "75996E90-0001",
            "paid": true,
            "payment_intent": {
              "id": "pi_1H0bldJDA0jmlwUvtQLGcCBa",
              "object": "payment_intent",
              "allowed_source_types": [
                "card"
              ],
              "amount": 10000,
              "amount_capturable": 0,
              "amount_received": 10000,
              "application": nil,
              "application_fee_amount": nil,
              "canceled_at": nil,
              "cancellation_reason": nil,
              "capture_method": "automatic",
              "charges": {
                "object": "list",
                "data": [
                  {
                    "id": "ch_1H0bldJDA0jmlwUvh47tnngg",
                    "object": "charge",
                    "amount": 10000,
                    "amount_refunded": 0,
                    "application": nil,
                    "application_fee": nil,
                    "application_fee_amount": nil,
                    "balance_transaction": "txn_1H0bldJDA0jmlwUvR1E9QqhY",
                    "billing_details": {
                      "address": {
                        "city": nil,
                        "country": nil,
                        "line1": nil,
                        "line2": nil,
                        "postal_code": nil,
                        "state": nil
                      },
                      "email": nil,
                      "name": nil,
                      "phone": nil
                    },
                    "calculated_statement_descriptor": "Stripe",
                    "captured": true,
                    "created": 1593732273,
                    "currency": "usd",
                    "customer": "cus_HZZ4T8JCStoNd5",
                    "description": "Subscription creation",
                    "destination": nil,
                    "dispute": nil,
                    "disputed": false,
                    "failure_code": nil,
                    "failure_message": nil,
                    "fraud_details": {},
                    "invoice": "in_1H0blcJDA0jmlwUvmIEnUhz1",
                    "livemode": false,
                    "metadata": {},
                    "on_behalf_of": nil,
                    "order": nil,
                    "outcome": {
                      "network_status": "approved_by_network",
                      "reason": nil,
                      "risk_level": "normal",
                      "risk_score": 11,
                      "seller_message": "Payment complete.",
                      "type": "authorized"
                    },
                    "paid": true,
                    "payment_intent": "pi_1H0bldJDA0jmlwUvtQLGcCBa",
                    "payment_method": "pm_1H0blbJDA0jmlwUvHAaTCBWS",
                    "payment_method_details": {
                      "card": {
                        "brand": "visa",
                        "checks": {
                          "address_line1_check": nil,
                          "address_postal_code_check": nil,
                          "cvc_check": nil
                        },
                        "country": "US",
                        "exp_month": 7,
                        "exp_year": 2021,
                        "fingerprint": "QaK6KeL4D3qcQ3sw",
                        "funding": "credit",
                        "installments": nil,
                        "last4": "4242",
                        "network": "visa",
                        "three_d_secure": nil,
                        "wallet": nil
                      },
                      "type": "card"
                    },
                    "receipt_email": nil,
                    "receipt_number": nil,
                    "receipt_url": "https://pay.stripe.com/receipts/acct_1AFjyCJDA0jmlwUv/ch_1H0bldJDA0jmlwUvh47tnngg/rcpt_HZlIc9R8EjmWh0QFXSNHT6Q6zEituLE",
                    "refunded": false,
                    "refunds": {
                      "object": "list",
                      "data": [],
                      "has_more": false,
                      "total_count": 0,
                      "url": "/v1/charges/ch_1H0bldJDA0jmlwUvh47tnngg/refunds"
                    },
                    "review": nil,
                    "shipping": nil,
                    "source": nil,
                    "source_transfer": nil,
                    "statement_descriptor": nil,
                    "statement_descriptor_suffix": nil,
                    "status": "succeeded",
                    "transfer_data": nil,
                    "transfer_group": nil
                  }
                ],
                "has_more": false,
                "total_count": 1,
                "url": "/v1/charges?payment_intent=pi_1H0bldJDA0jmlwUvtQLGcCBa"
              },
              "client_secret": "pi_1H0bldJDA0jmlwUvtQLGcCBa_secret_0uDyfsgFhsjZ7H4pjDzXGAvcK",
              "confirmation_method": "automatic",
              "created": 1593732273,
              "currency": "usd",
              "customer": "cus_HZZ4T8JCStoNd5",
              "description": "Subscription creation",
              "invoice": "in_1H0blcJDA0jmlwUvmIEnUhz1",
              "last_payment_error": nil,
              "livemode": false,
              "metadata": {},
              "next_action": nil,
              "next_source_action": nil,
              "on_behalf_of": nil,
              "payment_method": "pm_1H0blbJDA0jmlwUvHAaTCBWS",
              "payment_method_options": {
                "card": {
                  "installments": nil,
                  "network": nil,
                  "request_three_d_secure": "automatic"
                }
              },
              "payment_method_types": [
                "card"
              ],
              "receipt_email": nil,
              "review": nil,
              "setup_future_usage": "off_session",
              "shipping": nil,
              "source": nil,
              "statement_descriptor": nil,
              "statement_descriptor_suffix": nil,
              "status": "succeeded",
              "transfer_data": nil,
              "transfer_group": nil
            },
            "period_end": 1593732272,
            "period_start": 1593732272,
            "post_payment_credit_notes_amount": 0,
            "pre_payment_credit_notes_amount": 0,
            "receipt_number": nil,
            "starting_balance": 0,
            "statement_descriptor": nil,
            "status": "paid",
            "status_transitions": {
              "finalized_at": 1593732272,
              "marked_uncollectible_at": nil,
              "paid_at": 1593732272,
              "voided_at": nil
            },
            "subscription": "sub_HZlIwTz0aIyn7f",
            "subtotal": 10000,
            "tax": nil,
            "tax_percent": nil,
            "total": 10000,
            "total_tax_amounts": [],
            "transfer_data": nil,
            "webhooks_delivered_at": nil
          },
          "livemode": false,
          "metadata": {},
          "next_pending_invoice_item_invoice": nil,
          "pause_collection": nil,
          "pending_invoice_item_interval": nil,
          "pending_setup_intent": nil,
          "pending_update": nil,
          "plan": {
            "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
            "object": "plan",
            "active": true,
            "aggregate_usage": nil,
            "amount": 10000,
            "amount_decimal": "10000",
            "billing_scheme": "per_unit",
            "created": 1593172062,
            "currency": "usd",
            "interval": "year",
            "interval_count": 1,
            "livemode": false,
            "metadata": {},
            "name": "Yearly Basic Plan",
            "nickname": nil,
            "product": "prod_HXKhzUid1c87CM",
            "statement_descriptor": nil,
            "tiers": nil,
            "tiers_mode": nil,
            "transform_usage": nil,
            "trial_period_days": nil,
            "usage_type": "licensed"
          },
          "quantity": 1,
          "schedule": nil,
          "start": 1593732272,
          "start_date": 1593732272,
          "status": "active",
          "tax_percent": nil,
          "transfer_data": nil,
          "trial_end": nil,
          "trial_start": nil
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end

  path '/admin/api/subscriptions/show_payment_method' do
    get 'Show Payment Method Info' do

      tags 'Subscriptions'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true

      response '200', 'Success' do

        examples 'application/json' => {
          "id": "pm_1H0blbJDA0jmlwUvHAaTCBWS",
          "object": "payment_method",
          "billing_details": {
            "address": {
              "city": nil,
              "country": nil,
              "line1": nil,
              "line2": nil,
              "postal_code": nil,
              "state": nil
            },
            "email": nil,
            "name": nil,
            "phone": nil
          },
          "card": {
            "brand": "visa",
            "checks": {
              "address_line1_check": nil,
              "address_postal_code_check": nil,
              "cvc_check": nil
            },
            "country": "US",
            "exp_month": 7,
            "exp_year": 2021,
            "fingerprint": "QaK6KeL4D3qcQ3sw",
            "funding": "credit",
            "generated_from": nil,
            "last4": "4242",
            "networks": {
              "available": [
                "visa"
              ],
              "preferred": nil
            },
            "three_d_secure_usage": {
              "supported": true
            },
            "wallet": nil
          },
          "created": 1593732271,
          "customer": "cus_HZZ4T8JCStoNd5",
          "livemode": false,
          "metadata": {},
          "type": "card"
        }
        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end

  path '/admin/api/subscriptions/retry' do
    post 'Retry' do

      tags 'Subscriptions'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true
      parameter name: 'payment_method_id', :in => :formData, :type => :string, required: true

      response '200', 'Success' do

        examples 'application/json' => {
          "id": "in_1H0blcJDA0jmlwUvmIEnUhz1",
          "object": "invoice",
          "account_country": "US",
          "account_name": nil,
          "amount_due": 10000,
          "amount_paid": 10000,
          "amount_remaining": 0,
          "application_fee": nil,
          "attempt_count": 1,
          "attempted": true,
          "auto_advance": false,
          "billing": "charge_automatically",
          "billing_reason": "subscription_update",
          "charge": "ch_1H0bldJDA0jmlwUvh47tnngg",
          "closed": true,
          "collection_method": "charge_automatically",
          "created": 1593732272,
          "currency": "usd",
          "custom_fields": nil,
          "customer": "cus_HZZ4T8JCStoNd5",
          "customer_address": nil,
          "customer_email": "mediator@example.com",
          "customer_name": nil,
          "customer_phone": nil,
          "customer_shipping": nil,
          "customer_tax_exempt": "none",
          "customer_tax_ids": [],
          "date": 1593732272,
          "default_payment_method": nil,
          "default_source": nil,
          "default_tax_rates": [],
          "description": nil,
          "discount": nil,
          "due_date": nil,
          "ending_balance": 0,
          "finalized_at": 1593732272,
          "footer": nil,
          "forgiven": false,
          "hosted_invoice_url": "https://pay.stripe.com/invoice/acct_1AFjyCJDA0jmlwUv/invst_HZlIlFNum4WFA2RzCo1WeW7HsKgGH89",
          "invoice_pdf": "https://pay.stripe.com/invoice/acct_1AFjyCJDA0jmlwUv/invst_HZlIlFNum4WFA2RzCo1WeW7HsKgGH89/pdf",
          "lines": {
            "object": "list",
            "data": [
              {
                "id": "sub_HZlIwTz0aIyn7f",
                "object": "line_item",
                "amount": 10000,
                "currency": "usd",
                "description": nil,
                "discountable": true,
                "livemode": false,
                "metadata": {},
                "period": {
                  "end": 1625268272,
                  "start": 1593732272
                },
                "plan": {
                  "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                  "object": "plan",
                  "active": true,
                  "aggregate_usage": nil,
                  "amount": 10000,
                  "amount_decimal": "10000",
                  "billing_scheme": "per_unit",
                  "created": 1593172062,
                  "currency": "usd",
                  "interval": "year",
                  "interval_count": 1,
                  "livemode": false,
                  "metadata": {},
                  "name": "Yearly Basic Plan",
                  "nickname": nil,
                  "product": "prod_HXKhzUid1c87CM",
                  "statement_descriptor": nil,
                  "tiers": nil,
                  "tiers_mode": nil,
                  "transform_usage": nil,
                  "trial_period_days": nil,
                  "usage_type": "licensed"
                },
                "price": {
                  "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                  "object": "price",
                  "active": true,
                  "billing_scheme": "per_unit",
                  "created": 1593172062,
                  "currency": "usd",
                  "livemode": false,
                  "lookup_key": nil,
                  "metadata": {},
                  "nickname": nil,
                  "product": "prod_HXKhzUid1c87CM",
                  "recurring": {
                    "aggregate_usage": nil,
                    "interval": "year",
                    "interval_count": 1,
                    "trial_period_days": nil,
                    "usage_type": "licensed"
                  },
                  "tiers_mode": nil,
                  "transform_quantity": nil,
                  "type": "recurring",
                  "unit_amount": 10000,
                  "unit_amount_decimal": "10000"
                },
                "proration": false,
                "quantity": 1,
                "subscription": nil,
                "subscription_item": "si_HZlIRvMKgDiSGo",
                "tax_amounts": [],
                "tax_rates": [],
                "type": "subscription",
                "unique_id": "il_1H0blcJDA0jmlwUvgHv5omwo",
                "unique_line_item_id": "sli_2db3636606d041"
              }
            ],
            "has_more": false,
            "total_count": 1,
            "url": "/v1/invoices/in_1H0blcJDA0jmlwUvmIEnUhz1/lines"
          },
          "livemode": false,
          "metadata": {},
          "next_payment_attempt": nil,
          "number": "75996E90-0001",
          "paid": true,
          "payment_intent": {
            "id": "pi_1H0bldJDA0jmlwUvtQLGcCBa",
            "object": "payment_intent",
            "allowed_source_types": [
              "card"
            ],
            "amount": 10000,
            "amount_capturable": 0,
            "amount_received": 10000,
            "application": nil,
            "application_fee_amount": nil,
            "canceled_at": nil,
            "cancellation_reason": nil,
            "capture_method": "automatic",
            "charges": {
              "object": "list",
              "data": [
                {
                  "id": "ch_1H0bldJDA0jmlwUvh47tnngg",
                  "object": "charge",
                  "amount": 10000,
                  "amount_refunded": 0,
                  "application": nil,
                  "application_fee": nil,
                  "application_fee_amount": nil,
                  "balance_transaction": "txn_1H0bldJDA0jmlwUvR1E9QqhY",
                  "billing_details": {
                    "address": {
                      "city": nil,
                      "country": nil,
                      "line1": nil,
                      "line2": nil,
                      "postal_code": nil,
                      "state": nil
                    },
                    "email": nil,
                    "name": nil,
                    "phone": nil
                  },
                  "calculated_statement_descriptor": "Stripe",
                  "captured": true,
                  "created": 1593732273,
                  "currency": "usd",
                  "customer": "cus_HZZ4T8JCStoNd5",
                  "description": "Subscription creation",
                  "destination": nil,
                  "dispute": nil,
                  "disputed": false,
                  "failure_code": nil,
                  "failure_message": nil,
                  "fraud_details": {},
                  "invoice": "in_1H0blcJDA0jmlwUvmIEnUhz1",
                  "livemode": false,
                  "metadata": {},
                  "on_behalf_of": nil,
                  "order": nil,
                  "outcome": {
                    "network_status": "approved_by_network",
                    "reason": nil,
                    "risk_level": "normal",
                    "risk_score": 11,
                    "seller_message": "Payment complete.",
                    "type": "authorized"
                  },
                  "paid": true,
                  "payment_intent": "pi_1H0bldJDA0jmlwUvtQLGcCBa",
                  "payment_method": "pm_1H0blbJDA0jmlwUvHAaTCBWS",
                  "payment_method_details": {
                    "card": {
                      "brand": "visa",
                      "checks": {
                        "address_line1_check": nil,
                        "address_postal_code_check": nil,
                        "cvc_check": nil
                      },
                      "country": "US",
                      "exp_month": 7,
                      "exp_year": 2021,
                      "fingerprint": "QaK6KeL4D3qcQ3sw",
                      "funding": "credit",
                      "installments": nil,
                      "last4": "4242",
                      "network": "visa",
                      "three_d_secure": nil,
                      "wallet": nil
                    },
                    "type": "card"
                  },
                  "receipt_email": nil,
                  "receipt_number": nil,
                  "receipt_url": "https://pay.stripe.com/receipts/acct_1AFjyCJDA0jmlwUv/ch_1H0bldJDA0jmlwUvh47tnngg/rcpt_HZlIc9R8EjmWh0QFXSNHT6Q6zEituLE",
                  "refunded": false,
                  "refunds": {
                    "object": "list",
                    "data": [],
                    "has_more": false,
                    "total_count": 0,
                    "url": "/v1/charges/ch_1H0bldJDA0jmlwUvh47tnngg/refunds"
                  },
                  "review": nil,
                  "shipping": nil,
                  "source": nil,
                  "source_transfer": nil,
                  "statement_descriptor": nil,
                  "statement_descriptor_suffix": nil,
                  "status": "succeeded",
                  "transfer_data": nil,
                  "transfer_group": nil
                }
              ],
              "has_more": false,
              "total_count": 1,
              "url": "/v1/charges?payment_intent=pi_1H0bldJDA0jmlwUvtQLGcCBa"
            },
            "client_secret": "pi_1H0bldJDA0jmlwUvtQLGcCBa_secret_0uDyfsgFhsjZ7H4pjDzXGAvcK",
            "confirmation_method": "automatic",
            "created": 1593732273,
            "currency": "usd",
            "customer": "cus_HZZ4T8JCStoNd5",
            "description": "Subscription creation",
            "invoice": "in_1H0blcJDA0jmlwUvmIEnUhz1",
            "last_payment_error": nil,
            "livemode": false,
            "metadata": {},
            "next_action": nil,
            "next_source_action": nil,
            "on_behalf_of": nil,
            "payment_method": "pm_1H0blbJDA0jmlwUvHAaTCBWS",
            "payment_method_options": {
              "card": {
                "installments": nil,
                "network": nil,
                "request_three_d_secure": "automatic"
              }
            },
            "payment_method_types": [
              "card"
            ],
            "receipt_email": nil,
            "review": nil,
            "setup_future_usage": "off_session",
            "shipping": nil,
            "source": nil,
            "statement_descriptor": nil,
            "statement_descriptor_suffix": nil,
            "status": "succeeded",
            "transfer_data": nil,
            "transfer_group": nil
          },
          "period_end": 1593732272,
          "period_start": 1593732272,
          "post_payment_credit_notes_amount": 0,
          "pre_payment_credit_notes_amount": 0,
          "receipt_number": nil,
          "starting_balance": 0,
          "statement_descriptor": nil,
          "status": "paid",
          "status_transitions": {
            "finalized_at": 1593732272,
            "marked_uncollectible_at": nil,
            "paid_at": 1593732272,
            "voided_at": nil
          },
          "subscription": "sub_HZlIwTz0aIyn7f",
          "subtotal": 10000,
          "tax": nil,
          "tax_percent": nil,
          "total": 10000,
          "total_tax_amounts": [],
          "transfer_data": nil,
          "webhooks_delivered_at": 1593732275
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end

  path '/admin/api/subscriptions/unsubscribe' do
    post 'Unsubscribe' do

      tags 'Subscriptions'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true

      response '200', 'Success' do

        examples 'application/json' => {
          "id": "sub_HZlIwTz0aIyn7f",
          "object": "subscription",
          "application_fee_percent": nil,
          "billing": "charge_automatically",
          "billing_cycle_anchor": 1593732272,
          "billing_thresholds": nil,
          "cancel_at": nil,
          "cancel_at_period_end": false,
          "canceled_at": 1593732617,
          "collection_method": "charge_automatically",
          "created": 1593732272,
          "current_period_end": 1625268272,
          "current_period_start": 1593732272,
          "customer": "cus_HZZ4T8JCStoNd5",
          "days_until_due": nil,
          "default_payment_method": nil,
          "default_source": nil,
          "default_tax_rates": [],
          "discount": nil,
          "ended_at": 1593732617,
          "invoice_customer_balance_settings": {
            "consume_applied_balance_on_void": true
          },
          "items": {
            "object": "list",
            "data": [
              {
                "id": "si_HZlIRvMKgDiSGo",
                "object": "subscription_item",
                "billing_thresholds": nil,
                "created": 1593732273,
                "metadata": {},
                "plan": {
                  "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                  "object": "plan",
                  "active": true,
                  "aggregate_usage": nil,
                  "amount": 10000,
                  "amount_decimal": "10000",
                  "billing_scheme": "per_unit",
                  "created": 1593172062,
                  "currency": "usd",
                  "interval": "year",
                  "interval_count": 1,
                  "livemode": false,
                  "metadata": {},
                  "name": "Yearly Basic Plan",
                  "nickname": nil,
                  "product": "prod_HXKhzUid1c87CM",
                  "statement_descriptor": nil,
                  "tiers": nil,
                  "tiers_mode": nil,
                  "transform_usage": nil,
                  "trial_period_days": nil,
                  "usage_type": "licensed"
                },
                "price": {
                  "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
                  "object": "price",
                  "active": true,
                  "billing_scheme": "per_unit",
                  "created": 1593172062,
                  "currency": "usd",
                  "livemode": false,
                  "lookup_key": nil,
                  "metadata": {},
                  "nickname": nil,
                  "product": "prod_HXKhzUid1c87CM",
                  "recurring": {
                    "aggregate_usage": nil,
                    "interval": "year",
                    "interval_count": 1,
                    "trial_period_days": nil,
                    "usage_type": "licensed"
                  },
                  "tiers_mode": nil,
                  "transform_quantity": nil,
                  "type": "recurring",
                  "unit_amount": 10000,
                  "unit_amount_decimal": "10000"
                },
                "quantity": 1,
                "subscription": "sub_HZlIwTz0aIyn7f",
                "tax_rates": []
              }
            ],
            "has_more": false,
            "total_count": 1,
            "url": "/v1/subscription_items?subscription=sub_HZlIwTz0aIyn7f"
          },
          "latest_invoice": "in_1H0blcJDA0jmlwUvmIEnUhz1",
          "livemode": false,
          "metadata": {},
          "next_pending_invoice_item_invoice": nil,
          "pause_collection": nil,
          "pending_invoice_item_interval": nil,
          "pending_setup_intent": nil,
          "pending_update": nil,
          "plan": {
            "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
            "object": "plan",
            "active": true,
            "aggregate_usage": nil,
            "amount": 10000,
            "amount_decimal": "10000",
            "billing_scheme": "per_unit",
            "created": 1593172062,
            "currency": "usd",
            "interval": "year",
            "interval_count": 1,
            "livemode": false,
            "metadata": {},
            "name": "Yearly Basic Plan",
            "nickname": nil,
            "product": "prod_HXKhzUid1c87CM",
            "statement_descriptor": nil,
            "tiers": nil,
            "tiers_mode": nil,
            "transform_usage": nil,
            "trial_period_days": nil,
            "usage_type": "licensed"
          },
          "quantity": 1,
          "schedule": nil,
          "start": 1593732272,
          "start_date": 1593732272,
          "status": "canceled",
          "tax_percent": nil,
          "transfer_data": nil,
          "trial_end": nil,
          "trial_start": nil
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end

  path '/admin/api/subscriptions/update_plan' do
    post 'Update Plan' do

      tags 'Subscriptions'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true
      parameter name: 'plan_id', :in => :formData, :type => :string, required: true

      response '200', 'Success' do

        examples 'application/json' => {
          "id": "sub_HZlSATwjUD9aHJ",
          "object": "subscription",
          "application_fee_percent": nil,
          "billing": "charge_automatically",
          "billing_cycle_anchor": 1593732923,
          "billing_thresholds": nil,
          "cancel_at": nil,
          "cancel_at_period_end": false,
          "canceled_at": nil,
          "collection_method": "charge_automatically",
          "created": 1593732893,
          "current_period_end": 1596411323,
          "current_period_start": 1593732923,
          "customer": "cus_HZZ4T8JCStoNd5",
          "days_until_due": nil,
          "default_payment_method": nil,
          "default_source": nil,
          "default_tax_rates": [],
          "discount": nil,
          "ended_at": nil,
          "invoice_customer_balance_settings": {
            "consume_applied_balance_on_void": true
          },
          "items": {
            "object": "list",
            "data": [
              {
                "id": "si_HZlSHIThNUU3yn",
                "object": "subscription_item",
                "billing_thresholds": nil,
                "created": 1593732893,
                "metadata": {},
                "plan": {
                  "id": "price_1GyG1DJDA0jmlwUvoANKGVmZ",
                  "object": "plan",
                  "active": true,
                  "aggregate_usage": nil,
                  "amount": 3000,
                  "amount_decimal": "3000",
                  "billing_scheme": "per_unit",
                  "created": 1593172015,
                  "currency": "usd",
                  "interval": "month",
                  "interval_count": 1,
                  "livemode": false,
                  "metadata": {},
                  "name": "Premium Plan",
                  "nickname": nil,
                  "product": "prod_HXKg4fgDdqwE3M",
                  "statement_descriptor": nil,
                  "tiers": nil,
                  "tiers_mode": nil,
                  "transform_usage": nil,
                  "trial_period_days": nil,
                  "usage_type": "licensed"
                },
                "price": {
                  "id": "price_1GyG1DJDA0jmlwUvoANKGVmZ",
                  "object": "price",
                  "active": true,
                  "billing_scheme": "per_unit",
                  "created": 1593172015,
                  "currency": "usd",
                  "livemode": false,
                  "lookup_key": nil,
                  "metadata": {},
                  "nickname": nil,
                  "product": "prod_HXKg4fgDdqwE3M",
                  "recurring": {
                    "aggregate_usage": nil,
                    "interval": "month",
                    "interval_count": 1,
                    "trial_period_days": nil,
                    "usage_type": "licensed"
                  },
                  "tiers_mode": nil,
                  "transform_quantity": nil,
                  "type": "recurring",
                  "unit_amount": 3000,
                  "unit_amount_decimal": "3000"
                },
                "quantity": 1,
                "subscription": "sub_HZlSATwjUD9aHJ",
                "tax_rates": []
              }
            ],
            "has_more": false,
            "total_count": 1,
            "url": "/v1/subscription_items?subscription=sub_HZlSATwjUD9aHJ"
          },
          "latest_invoice": "in_1H0bw7JDA0jmlwUvWf91BXxs",
          "livemode": false,
          "metadata": {},
          "next_pending_invoice_item_invoice": nil,
          "pause_collection": nil,
          "pending_invoice_item_interval": nil,
          "pending_setup_intent": nil,
          "pending_update": nil,
          "plan": {
            "id": "price_1GyG1DJDA0jmlwUvoANKGVmZ",
            "object": "plan",
            "active": true,
            "aggregate_usage": nil,
            "amount": 3000,
            "amount_decimal": "3000",
            "billing_scheme": "per_unit",
            "created": 1593172015,
            "currency": "usd",
            "interval": "month",
            "interval_count": 1,
            "livemode": false,
            "metadata": {},
            "name": "Premium Plan",
            "nickname": nil,
            "product": "prod_HXKg4fgDdqwE3M",
            "statement_descriptor": nil,
            "tiers": nil,
            "tiers_mode": nil,
            "transform_usage": nil,
            "trial_period_days": nil,
            "usage_type": "licensed"
          },
          "quantity": 1,
          "schedule": nil,
          "start": 1593732923,
          "start_date": 1593732893,
          "status": "active",
          "tax_percent": nil,
          "transfer_data": nil,
          "trial_end": nil,
          "trial_start": nil
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end

  path '/admin/api/subscriptions/history' do
    get 'Get Customer Subscriptions invoices Hisory' do

      tags 'Subscriptions'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Authorization', :in => :header, :type => :string, required: true

      response '200', 'Success' do

        examples 'application/json' => [
          {
            "id": "ii_1H0bw7JDA0jmlwUv2R1EeNSw",
            "object": "invoiceitem",
            "amount": -10000,
            "currency": "usd",
            "customer": "cus_HZZ4T8JCStoNd5",
            "date": 1593732923,
            "description": "Unused time on Yearly Basic Plan after 02 Jul 2020",
            "discountable": false,
            "invoice": "in_1H0bw7JDA0jmlwUvWf91BXxs",
            "livemode": false,
            "metadata": {},
            "period": {
              "end": 1625268893,
              "start": 1593732923
            },
            "plan": {
              "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
              "object": "plan",
              "active": true,
              "aggregate_usage": nil,
              "amount": 10000,
              "amount_decimal": "10000",
              "billing_scheme": "per_unit",
              "created": 1593172062,
              "currency": "usd",
              "interval": "year",
              "interval_count": 1,
              "livemode": false,
              "metadata": {},
              "name": "Yearly Basic Plan",
              "nickname": nil,
              "product": "prod_HXKhzUid1c87CM",
              "statement_descriptor": nil,
              "tiers": nil,
              "tiers_mode": nil,
              "transform_usage": nil,
              "trial_period_days": nil,
              "usage_type": "licensed"
            },
            "price": {
              "id": "price_1GyG1yJDA0jmlwUvGf6WEo8H",
              "object": "price",
              "active": true,
              "billing_scheme": "per_unit",
              "created": 1593172062,
              "currency": "usd",
              "livemode": false,
              "lookup_key": nil,
              "metadata": {},
              "nickname": nil,
              "product": "prod_HXKhzUid1c87CM",
              "recurring": {
                "aggregate_usage": nil,
                "interval": "year",
                "interval_count": 1,
                "trial_period_days": nil,
                "usage_type": "licensed"
              },
              "tiers_mode": nil,
              "transform_quantity": nil,
              "type": "recurring",
              "unit_amount": 10000,
              "unit_amount_decimal": "10000"
            },
            "proration": true,
            "quantity": 1,
            "subscription": "sub_HZlSATwjUD9aHJ",
            "subscription_item": "si_HZlSHIThNUU3yn",
            "tax_rates": [],
            "unit_amount": -10000,
            "unit_amount_decimal": "-10000"
          }
        ]

        run_test!
      end

      response '401', 'Unauthorized' do
        let!(:Authorization) { "vcugcvejhrvkwejrhvkwejrhvkejrhvkj" }
        run_test!
      end

    end
  end
end
