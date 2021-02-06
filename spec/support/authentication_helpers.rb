module AuthenticationHelpers

    def authenticated_header
        # user = FactoryBot.create(:user)
        family = FactoryBot.create(:family)
        # authenticate_user(user)
        authenticate_family(family)
    end
    # def authenticate_user(user)
    #     token = Knock::AuthToken.new(payload: { sub: user.id }).token

    #     { 'Authorization': "Bearer #{token}" }
    # end
    def authenticate_family(family)
        token = Knock::AuthToken.new(payload: { sub: family.id }).token

        { 'Authorization': "Bearer #{token}" }
    end
end

RSpec.configure do |config|
    config.include AuthenticationHelpers, type: :request
end
