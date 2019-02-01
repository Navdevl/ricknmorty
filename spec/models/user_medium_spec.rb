require 'rails_helper'

RSpec.describe UserMedium, type: :model do

  context "db" do

    context "indexes" do
      it { should have_db_index(:medium_id) }
      it { should have_db_index(:user_id) }
    end

    context "columns" do
      it { should have_db_column(:purchased_at).of_type(:datetime) }
      it { should have_db_column(:expires_at).of_type(:datetime) }
    end
  end

  context "association" do 
    it { should belong_to(:medium) }
    it { should belong_to(:user) }
  end

  context "validation" do
  end
end
