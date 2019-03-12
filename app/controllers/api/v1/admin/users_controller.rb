module Api::V1::Admin
    class UsersController < ApplicationController
        before_action :authorize_request, except: [:create, :login]
        before_action :find_user, except: [:create, :index]
    
        # GET /users
        def index
            @users = User.all
            render json: @users, status: :ok
        end
    
        # GET /users/{username}
        def show
            render json: @user, status: :ok
        end

        # POST /users
        def create
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
    
        # PUT /users/{username}
        def update
            unless @user.update(user_params)
                render json: { errors: @user.errors.full_messages },
                    status: :unprocessable_entity
            end
        end
    
        # DELETE /users/{username}
        def destroy
            @user.destroy
        end
    
        private
        
            def find_user
                @user = User.find_by! id: params[:id]
                rescue ActiveRecord::RecordNotFound
                    render json: { errors: 'User not found' }, status: :not_found
            end

            def set_master
            
            def user_params
                params.permit(
                    :username, :email, :password, :coins, :points
                )
            end
            
    end
end