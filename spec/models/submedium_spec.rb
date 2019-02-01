require 'rails_helper'

RSpec.describe Submedium, type: :model do

  context "db" do
  end

  context "association" do 
    it { should belong_to(:medium) }
  end

  context "validation" do 
    it "validates parent medium" do 
    end
  end
end
