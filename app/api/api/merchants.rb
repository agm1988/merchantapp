# frozen_string_literal: true

module Api
  class Merchants < Grape::API
    version 'v1', using: :header, vendor: 'merchantpay'

    resources :merchants do
      before do
        authenticate_admin!(headers)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!(e, 404)
      end

      desc 'shows all available merchants'
      params do
        optional :page, type: Integer,
                 desc: 'Page number'
      end
      get do
        present(Merchant.all.page(params[:page]),
                with: Api::Entities::Merchant)
      end

      desc 'show merchant'
      get ':id' do
        merchant = Merchant.find(params[:id])

        present(merchant, with: Api::Entities::Merchant)
      end

      desc 'Create Merchant'
      params do
        requires :status,
                 type: String,
                 values: %w[active inactive],
                 desc: 'Merchant Status'
        requires :name,
                type: String
        requires :description,
                 type: String
        requires :email,
                 type: String
        requires :password,
                 type: String
        requires :password_confirmation,
                 type: String
        optional :is_admin,
                 type: Virtus::Attribute::Boolean,
                 default: false
      end
      post do
        # TODO: extract to operation
        merchant_params = ActionController::Parameters.new(params)
                            .permit(:status, :name, :description,
                                    :email, :is_admin, :password,
                                    :password_confirmation)

        merchant = Merchant.new(merchant_params)

        if merchant.save
          present(merchant, with: Api::Entities::Merchant)
        else
          status 422
          {
            status: :unprocessable_entity,
            errors: merchant.errors.messages
          }
        end
      end

      desc 'Update Merchant'
      params do
        optional :status,
                 type: String,
                 values: %w[active inactive],
                 desc: 'Merchant Status'
        optional :name,
                 type: String
        optional :description,
                 type: String
        optional :email,
                 type: String
        optional :password,
                 type: String
        optional :password_confirmation,
                 type: String
        optional :is_admin,
                 type: Virtus::Attribute::Boolean,
                 default: false
      end
      put ':id' do
        # TODO: extract to operation
        merchant = Merchant.find(params[:id])
        merchant_params = ActionController::Parameters.new(params)
                            .permit(:status, :name, :description,
                                    :email, :is_admin, :password,
                                    :password_confirmation)

        if merchant.update(merchant_params)
          present(merchant, with: Api::Entities::Merchant)
        else
          status 422
          {
            status: :unprocessable_entity,
            errors: merchant.errors.messages
          }
        end
      end

      desc 'Delete Merchant'
      delete ':id' do
        merchant = Merchant.find(params[:id])

        merchant.destroy
        { status: :ok }
      end
    end
  end
end
