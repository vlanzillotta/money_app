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
      expect(page).to have_content('Here are your transactions')
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
      select "weekly", :from => "transaction_repeat_frequency"
    }

    it "should add a transaction" do
      expect { click_button "submit" }.to change(user.transactions, :count)    
    end  
  end

  describe "creating new putaway transaction" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      visit "/transactions/new/putaway"
    }

    it "should not display repeat frequencies" do
      expect(page).to_not have_content("Repeat frequency")   
    end
  end

  describe "deleting a trsnaction" do
    let(:user) { FactoryGirl.create(:user) }
    
    describe "from index view" do
      before {
        sign_in user
        populate_transactions user
        visit transactions_path        
      }
      it "clicking delete on a transaction " do
         expect { click_link "delete_#{user.transactions.first.id}" }.to change(user.transactions, :first)
      end

    end

    describe "from dashboard view" do
      before {
        sign_in user
        populate_transactions user
        visit dashboard_path        
      }
      it "clicking delete on a transaction " do
         expect { click_link "delete_#{user.transactions.first.id}" }.to change(user.transactions, :first)
      end
    end
  end

  describe "editing a transaction" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      populate_transactions user
    }
    describe "from the transaction screen" do
      it "click edit button" do
        visit transactions_path
        click_link "edit_#{user.transactions.first.id}"

        expect(page).to have_content("edit transaction");
      end     
    end

    describe "from the dashboard screen" do
      it "click edit button" do
        visit dashboard_path
        click_link "edit_#{user.transactions.first.id}"

        expect(page).to have_content("edit transaction");
      end
    end
  end


  describe "commiting a transaction" do
    
    let(:user) { FactoryGirl.create(:user) }
    let(:transaction_id) { user.transactions.where(:type_of => "future transaction").first.id}
    
    before {
      sign_in user
      populate_transactions user
      visit future_transactions_path
    }
    
    it "will chnage the date to todays date " do
      expect { click_link "commit_#{transaction_id}" }.to change {Transaction.find(transaction_id).transaction_date}
    end
    it "will chnage the transaction type " do
      expect { click_link "commit_#{transaction_id}" }.to change {Transaction.find(transaction_id).type_of}
    end
  end



  describe "creating a transaction with a repeat frequency (daily)" do
    let(:user) { FactoryGirl.create(:user) }
    let(:original_transaction) { user.transactions.where(:repeat_frequency => "daily").first}
    let(:original_transaction_id) { user.transactions.where(:repeat_frequency => "daily").first.id}

    before {
      sign_in user

      visit new_transaction_path
      fill_in  "transaction_name",  with: "repeating transaction"
      fill_in  "transaction_amount",  with: 100
      fill_in  "transaction_transaction_date",  with: "2094-12-16"
      select "daily", :from => "transaction_repeat_frequency"
      click_button "submit" 
      visit dashboard_path

    }

    it " should create 31 duplicate transactions with all the same information except for the date)" do
      expect(page).to have_content("2095-01-16 repeating transaction");
    end
  end

  describe "deleting a repeating transaction (daily)" do
      # lets make the same repeating transaction as the above test
      let(:user) { FactoryGirl.create(:user) }

      before {
        sign_in user

        visit new_transaction_path
        fill_in  "transaction_name",  with: "repeating transaction"
        fill_in  "transaction_amount",  with: 100
        fill_in  "transaction_transaction_date",  with: "2094-12-16"
        select "daily", :from => "transaction_repeat_frequency"
        click_button "submit" 
        visit dashboard_path
        
        click_link "delete_#{user.transactions.first.id}"
      }
      it " should not show the 30th repeat of this transaction)" do
        expect(page).not_to have_content("2095-01-16 repeating transaction");
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

  describe "view all future trsnsactions" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      populate_transactions user
      visit future_transactions_path      
    }

    it "should display a table of future transactions" do
      expect(page).to have_content("Future transactions")
    end
  end

  describe "view all putaway trsnsactions" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      populate_transactions user
      visit putaway_transactions_path
      
    }

    it "should display a table of putaway transactions" do
      expect(page).to have_content("Putaway transactions")
    end
  end

  describe "view all recent trsnsactions" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user
      populate_transactions user
      visit recent_transactions_path
      
    }

    it "should display a table of recent transactions" do
      expect(page).to have_content("Recent transactions")
    end
  end

  # describe "User cant commit another users transaction" do
  #   let(:user) { FactoryGirl.create(:user) }
  #   let(:user2) { FactoryGirl.create(:user2) }
  #   before {
  #     populate_transactions user
  #     populate_transactions user2
  #     sign_in user2
      
  #     # Now as user2 fake a hit to the commit first user's transaction 1
  #     visit transaction_commit_path(:id =>1, :method => "post")
  #   }
  #   it "should display an error" do
  #     expect(page).to have_content("An error occured")

  #   end
  # end

  describe "User should not be able to add repeat frequency to dateless transaction" do
    let(:user) { FactoryGirl.create(:user) }
    before {
      sign_in user

      visit new_transaction_path
      fill_in  "transaction_name",  with: "repeating transaction"
      fill_in  "transaction_amount",  with: 100
      fill_in  "transaction_transaction_date",  with: ""
      select "daily", :from => "transaction_repeat_frequency"
      click_button "submit" 
      
    }
    it "should display an error" do
      expect(page).to have_content("You cannot have a repeat frequency without a starting date")
    end
  end
end
