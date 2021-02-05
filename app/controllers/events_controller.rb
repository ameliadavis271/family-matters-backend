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
        render json: event
    end

    def create
        # create a new family event
        event = Event.new(events_params)
        event.capitalize_name
        if event.save
            render status: :created
        else
            render status: :bad_request
        end
    end

    def update
    end

    def destroy
        @event.destroy
    end

    
    private

    def set_event
        @event = Event.find(params[:id])
    end

    
    # strong params
    def events_params
        params.require(:event).permit(:name, :description, :date, :time, :user_id)
    end

end
