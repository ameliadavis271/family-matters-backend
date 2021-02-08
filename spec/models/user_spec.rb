require 'rails_helper'

RSpec.describe User, type: :model do
    # updates based on class name if changed
    subject { FactoryBot.build(:user) }

    context 'validations' do
        it 'is valid with valid attributes' do
            p subject
            expect(subject).to be_valid
        end

        it 'is not valid without an email' do
            subject.email = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a password' do
            subject.password = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a first name' do
            subject.first_name = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a last name' do
            subject.last_name = nil
            expect(subject).to_not be_valid
        end

        it 'is not valid without a family id' do
            subject.family_id = nil
            expect(subject).to_not be_valid
        end
    end
end