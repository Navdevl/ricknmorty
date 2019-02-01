require 'rails_helper'

RSpec.describe Submedium, type: :model do

  context "db" do
  end

  context "association" do 
    it { should belongs(:medium) }
  end

  context "validation" do 
  end
end
