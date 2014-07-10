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

    describe "from the transaction screen" do
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

  describe "commiting a transaction with a repeat frequency" do
    pending "Doing this next"
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


end
