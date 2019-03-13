module Api::V1::Authentication
    class AuthenticationController < ApplicationController
        
        # POST /api/v1/authentication/signup
        def signup
            get_master
            @user = User.new({
                username: params[:username],
                email: params[:email],
                password: params[:password],
                coins: params[:coins],
                points: params[:points]
            })
            if @user.save
                token = JsonWebToken.encode(user_id: @user.id)
                time = Time.now + 1000.days.to_i
                render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user, master: @master}, status: :ok
            else
                render json: { errors: @user.errors.full_messages },
                    status: :unprocessable_entity
            end
        end

        # POST /api/v1/authentication/login
        def login
            @user = User.find_by_email(params[:email])
            get_master
            if @user&.authenticate(params[:password])
                token = JsonWebToken.encode(user_id: @user.id)
                time = Time.now + 1000.days.to_i
                render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user }, status: :ok
            else
                render json: { error: 'unauthorized' }, status: :unauthorized
            end
        end



        private

        def get_master
            @master = {
                mental_models: [],
                paragraphs: [],
                cards: [],
            }
            MentalModel.where(user_id: 1).find_each do |model|
                @master[:mental_models] << model
            end
            Paragraph.where(user_id: 1).find_each do |paragraph|
                @master[:paragraphs] << paragraph
            end
            Card.where(user_id: 1).find_each do |card|
                @master[:cards] << card
            end
        end
    end
end


