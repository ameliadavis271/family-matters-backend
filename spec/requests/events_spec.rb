require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET events#index" do
    before(:example) do
        @first_event = FactoryBot.create(:event)
        @second_event = FactoryBot.create(:event)   
        get events_path     
        @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
        expect(response).to have_http_status(:success)
    end

    it 'contains the correct number of entries' do
        expect(@json_response.count).to eq(2)
    end

    it 'event contains the expected attributes' do
        expect(@json_response.first).to include({
            'id' => @first_event.id,
            'name' => @first_event.name,
            'description' => @first_event.description,
            'date' => @first_event.date,
            'time' => @first_event.time
        })
    end
  end

  describe 'POST events#create' do
      context 'when the event is valid' do
          before(:example) do
              @event_params = FactoryBot.attributes_for(:event)
              post events_path, params: { event: @event_params }, headers: authenticated_header
          end

          it 'returns http created' do
              expect(response).to have_http_status(:created)
          end

          it 'saves the event to the database' do
              expect(Event.last.name).to eq(@event_params[:name])
              expect(Event.last.description).to eq(@event_params[:description])
              expect(Event.last.date).to eq(@event_params[:date])
              expect(Event.last.time).to eq(@event_params[:time])
          end
      end

      context 'when the task is invalid' do
        before(:example) do  
            @event_params = FactoryBot.attributes_for(:event, :invalid)
            post events_path, params: { event: @event_params }, headers: authenticated_header
            @json_response = JSON.parse(response.body)
        end

        it 'return http unprocessable entity' do
            expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the correct number of errors' do
            expect(@json_response['errors'].count).to eq(1)
        end

        it 'error contains the correct error message' do
            expect(@json_response['errors'].first).to eq("Name can't be blank")
        end
      end
  end
end