require 'rails_helper'

RSpec.describe Purchase, type: :model do

  context "db" do
  end

  context "association" do 
    it { should belong_to(:medium) }
    it { should belong_to(:user) }
  end

  context "validation" do 
  end
end
