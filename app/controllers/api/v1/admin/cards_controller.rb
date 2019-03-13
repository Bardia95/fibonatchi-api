module Api::V1::Admin
    class CardsController < ApplicationController
        before_action :authorize_admin_request
        before_action :set_paragraph, only: [:create, :index]
        before_action :find_card, except: [:create, :index]
        def show
            render json: @card, status: :ok
        end
    
        def index
            @cards = Card.where(paragraph_id: @paragraph.id)
            render json: @cards, status: :ok
        end

        def create
            @card = @paragraph.cards.new({
                question: params[:question],
                answer: params[:answer],
                image_url: params[:image_url],
                user_id: @admin.id 
            })
            if @card.save
                render json: @card, status: :created
            else
                render json: { errors: 'Card was not created' }, status: :internal_server_error
            end
        end
    
        def update
            if @card.update(card_params)
                render json: @card, status: :ok
            else
                render json: { errors: 'Card was not updated' }, status: :internal_server_error
            end
        end
    
        def destroy
            if @card.destroy
                render json: {destroyed: true}, status: :ok
            else
                render json:{ errors: 'Card was not destroyed'}, status: :internal_server_error
            end
        end
    
        private

            def set_paragraph
                @paragraph = Paragraph.find_by! id: params[:paragraph_id]
                rescue ActiveRecord::RecordNotFound
                    render json: { errors: 'Paragraph not found' }, status: :not_found
            end

            def find_card
                @card = Card.find_by! id: params[:id]
                rescue ActiveRecord::RecordNotFound
                    render json: { errors: 'Card not found' }, status: :not_found
            end
    end
end