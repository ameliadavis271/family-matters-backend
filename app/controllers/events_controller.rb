class EventsController < ApplicationController
before_action :set_event, only: [:show, :destroy, :update]

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
        event = Event.new(events_params)
        event.capitalize_name
        if event.save
            render status: :created
        else
            render status: :bad_request
        end
    end

    def update
        if @event.update(update_events_params)
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
    def events_params
        params.require(:event).permit(:name, :description, :date, :time)
    end

    def update_events_params
        params.require(:event).permit(:name, :description, :time)
    end

end
