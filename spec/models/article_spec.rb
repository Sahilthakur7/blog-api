require 'rails_helper'

RSpec.describe Article, type: :model do
    #association tests

    it {should belong_to(:category)}

    #validation tests

    it {should validate_presence_of(:title)}
end
