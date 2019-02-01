require 'rails_helper'

RSpec.describe Medium, type: :model do

  context "db" do
    context "columns" do
      it { should have_db_column(:name).of_type(:string).with_options(limit: 255, null: false) }
      it { should have_db_column(:plot).of_type(:text) }
    end
  end

  context "association" do 
    it { should have_many(:submedia) }
  end

  context "validation" do 
    context "media_type" do 
      it { should define_enum_for(:media_type).with_values([:movie, :season]) }
    end

    context "name" do 
      it { should validate_presence_of(:name) }
    end

    context "plot" do 
      it { should validate_presence_of(:plot) }
    end
  end
end
