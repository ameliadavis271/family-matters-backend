class EventsController < ApplicationController
before_action :set_event, only: [:show, :destroy, :update]
before_action :authenticate_user

    def index
        # display all events
        unless !current_user.family
            events = Event.where(family_id: current_user.family.id)
            render json: events
        end
    end

    def show
        # display single event
        @event = Event.find(params[:id])
        render json: @event
    end

    def create
        # create a new family event
        event = current_user.family.events.create(event_params)
        # event.capitalize_name
        if event.save
            render status: :created
        else
            puts event.errors.messages
            render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        # update a new event
        if @event.update(update_event_params)
            render status: :created
        else
            render status: :bad_request
        end
    end

    def destroy
        # delete an event
        @event.destroy
    end

    
    private

    def set_event
        # set desired event
        @event = Event.find(params[:id])
    end

    
    # strong params
    def event_params
        # set parameters for an event
        params.require(:event).permit(:name, :description, :date, :time, :user_id)
    end

    def update_event_params
        # set parameters for updating event, prevents alteration of date
        params.require(:event).permit(:name, :description, :time)
    end

end
