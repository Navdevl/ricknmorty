require 'rails_helper'

RSpec.describe User, type: :model do

  context "db" do
    context "indexes" do
      it { should have_db_index(:email).unique(true) }
    end

    context "columns" do
      it { should have_db_column(:email).of_type(:string).with_options(limit: 255, null: false) }
    end
  end

  context "association" do 
    it { should have_many(:user_media) }
    it { should have_many(:purchases) }
    it { should have_many(:media) }
  end

  context "validation" do 
    context "email" do 
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
      it { should allow_value('mail@example.com').for(:email) }
      it { should_not allow_value('mail.example.com').for(:email) }
    end

    context "name" do 
      it { should validate_presence_of(:name) }
    end
  end
end
