require 'rails_helper'

RSpec.describe Event, type: :model do
    # updates based on class name if changed
    subject { FactoryBot.build(:event) }

    context 'validations' do
        it 'is valid with valid attributes' do
            p subject
            expect(subject).to be_valid
        end

        it 'is not valid without a name' do
            subject.name = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a description' do
            subject.name = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a date' do
            subject.name = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a time' do
            subject.name = nil
            expect(subject).to_not be_valid
        end
    end
end