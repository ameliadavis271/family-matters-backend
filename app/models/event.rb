class Event < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :time, presence: true
    validates :date, presence: true
    belongs_to :family

    # method to ensure capitalization of event name
    def capitalize_name
        capitalized_words = name.split(" ").each do |word|
            word.capitalize!
        end
        self.name = capitalized_words.join(" ")
    end
end
