class ApplicationController < ActionController::API
    def not_found
        render json: { error: 'not_found' }
    end
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end

    def authorize_admin_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            @decoded = JsonWebToken.decode(header)
            @admin = User.find(@decoded[:user_id]) if @decoded[:user_id] == 1
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end


    def find_user
        @user = User.find_by! id: params[:id]
        rescue ActiveRecord::RecordNotFound
            render json: { errors: 'User not found' }, status: :not_found
    end
    
    def find_paragraph
        @paragraph = Paragraph.find_by! id: params[:id]
        rescue ActiveRecord::RecordNotFound
            render json: { errors: 'Paragraph not found' }, status: :not_found
    end

    
end
