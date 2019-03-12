module Api::V1::Admin
    class ParagraphsController < ApplicationController
        before_action :authorize_request
        before_action :set_mental_model, only: [:create, :index]
        before_action :find_paragraph, except: [:create, :index]
        def show
            render json: @paragraph, status: :ok
        end
    
        def index
            @paragraphs = Paragraph.where(mental_model_id: @mental_model.id)
            render json: @paragraphs, status: :ok
        end

        def create
            @paragraph = @mental_model.paragraphs.new(paragraph_params)
            if @paragraph.save
                render json: @paragraph, status: :created
            else
                render json: { errors: 'Paragraph was not created' }, status: :internal_server_error
            end
        end
    
        def update
            if @paragraph.update(paragraph_params)
                render json: @paragraph, status: :ok
            else
                render json: { errors: 'Mental model was not updated' }, status: :internal_server_error
            end
        end
    
        def destroy
            if @paragraph.destroy
                render json: {destroyed: true}, status: :ok
            else
                render json:{ errors: 'Mental model was not destroyed'}, status: :internal_server_error
            end
        end
    
        private

            def paragraph_params
                params.permit(:text, :order)
            end

            def set_mental_model
                @mental_model = MentalModel.find_by! id: params[:mental_model_id]
                rescue ActiveRecord::RecordNotFound
                    render json: { errors: 'Mental model not found' }, status: :not_found
            end

            def find_paragraph
                @paragraph = Paragraph.find_by! id: params[:id]
                rescue ActiveRecord::RecordNotFound
                    render json: { errors: 'Paragraph not found' }, status: :not_found
            end
    end
end