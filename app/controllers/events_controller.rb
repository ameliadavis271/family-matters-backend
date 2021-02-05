class EventsController < ApplicationController
before_action :set_event, only: [:show, :destroy, :update]
# before_action :authenticate_user

    def index
        # display all subscriptions
        events = Event.all
        render json: events
    end

    def show
        @event = Event.find(params[:id])
        render json: @event
    end

    def create
        # create a new family event
        event = Event.new(event_params)
        # event.capitalize_name
        if event.save
            render status: :created
        else
            render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @event.update(update_event_params)
            render status: :created
        else
            render status: :bad_request
        end
    end

    def destroy
        @event.destroy
    end

    
    private

    def set_event
        @event = Event.find(params[:id])
    end

    
    # strong params
    def event_params
        params.require(:event).permit(:name, :description, :date, :time, :user_id)
    end

    def update_event_params
        params.require(:event).permit(:name, :description, :time)
    end

end
