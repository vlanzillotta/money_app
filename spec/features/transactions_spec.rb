require 'spec_helper'
include Devise::TestHelpers

describe "Transactions - " , :type => :feature do
  
  describe "View transactions" do
    
    it "When not logged in" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/transactions'
      expect(page).to have_content('Sign in')
    end

	  let(:user) { FactoryGirl.create(:user) }
    

    it "when logged in" do

      populate_transactions user
    	sign_in user
    	visit transactions_path
      expect(page).to have_content('Here are your transactions!')
    end
    
  end


  describe "creating new transaction" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      populate_transactions user
      visit new_transaction_path
      fill_in  "transaction_name",  with: "initial transaction"
      fill_in  "transaction_amount",  with: 100
      fill_in  "transaction_transaction_date",  with: "2014-05-20"
    }

    it "should add a transaction" do

      expect { click_button "submit" }.to change(user.transactions, :count)
    
    end
  
  end


  describe "creating a new transaction from the transaction index page" do

    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      populate_transactions user
      visit transactions_path
      click_link  "Create New Transaction"
    }
    it "should display the transaction creation screen" do 
      expect(page).to have_content("New Transaction")
    end

  end




end
