require 'rails_helper'

RSpec.describe Purchase, type: :model do

  context "db" do
  end

  context "association" do 
    it { should belongs_to(:medium) }
    it { should belongs_to(:user) }
  end

  context "validation" do 
  end
end
