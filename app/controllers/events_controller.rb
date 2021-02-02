class EventsController < ApplicationController

    def index
        # display all subscriptions
        events = Event.all
        render json: events
    end

    def show
        event = Event.find(params[:id])
        render json: event
    end

    def create
        # create a new family event
        event = Event.new(events_params)
        if event.save
            render status: :created
        else
            redner status: :bad_request
        end
    end

    # strong params

    private

    def events_params
        params.require(:event).permit(:name, :description, :date, :time)
    end

end
