module Api::V1::Admin
    class MentalModelsController < ApplicationController
        before_action :authorize_admin_request
        before_action :set_user, only: [:create, :index]
        before_action :find_mental_model, except: [:create, :index]
        def show
            render json: @mental_model, status: :ok
        end
    
        def index
            @mental_models = MentalModel.where(user_id: @user.id)
            render json: @mental_models, status: :ok
        end

        def create
            @mental_model =  @user.mental_models.new({
                name: params[:name], 
                subject: params[:subject]
            })
            if @mental_model.save
                render json: @mental_model, status: :created
            else
                render json: { errors: 'Mental model was not created' }, status: :internal_server_error
            end
        end
    
        def update
            if @mental_model.update(mental_model_params)
                render json: @mental_model, status: :ok
            else
                render json: { errors: 'Mental model was not updated' }, status: :internal_server_error
            end
        end
    
        def destroy
            if @mental_model.destroy
                render json: {destroyed: true}, status: :ok
            else
                render json:{ errors: 'Mental model was not destroued'}, status: :internal_server_error
            end
        end
    
        private
            def set_user
                @user = User.find_by! id: params[:user_id]
                rescue ActiveRecord::RecordNotFound
                    render json: { errors: 'User not found' }, status: :not_found
            end

            def find_mental_model
                @mental_model = MentalModel.find_by! id: params[:id]
                rescue ActiveRecord::RecordNotFound
                    render json: { errors: 'Mental model not found' }, status: :not_found
            end
    end
end