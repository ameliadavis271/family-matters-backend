FactoryBot.define do 
    factory :user do
        sequence :email do |n|
            "testuser#{n}@test.com"
        end
        sequence :first_name do |n|
            "FirstTest #{n}"
        end
        sequence :last_name do |n|
            "LastTest #{n}"
        end
        sequence :family_id do |n|
            "FamilyID #{n}"
        end
        password_digest { "password" }
    end
end