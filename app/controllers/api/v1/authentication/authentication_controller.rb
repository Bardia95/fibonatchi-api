module Api::V1::Authentication
    class AuthenticationController < ApplicationController
        
        # POST /users
        def signup
            @user = User.new(user_params)
            if @user.save
                token = JsonWebToken.encode(user_id: @user.id)
                time = Time.now + 1000.days.to_i
                render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user }, status: :ok
            else
                render json: { errors: @user.errors.full_messages },
                    status: :unprocessable_entity
            end
        end

        #POST /login
        def login
            @user = User.find_by_email(params[:email])
            if @user&.authenticate(params[:password])
                token = JsonWebToken.encode(user_id: @user.id)
                time = Time.now + 1000.days.to_i
                render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username }, status: :ok
            else
                render json: { error: 'unauthorized' }, status: :unauthorized
            end
        end



        private

        # def get_master
        #     @master = {}
        #     @master.user = User.find_by! id: 1
        #     @master.mental_models = @master.user.mental_models
        #     @master.mental_models.each do |
        #     @master_paragraphs = @master.mental_model
            



    

    end
end


