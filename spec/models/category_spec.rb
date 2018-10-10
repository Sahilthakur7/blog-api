require 'rails_helper'

RSpec.describe Category, type: :model do
    #associtation tests
    
    it { should have_many(:articles) }

    #validation tests

    it {should validate_presence_of(:title)}
end
