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

end
