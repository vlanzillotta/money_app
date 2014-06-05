require 'spec_helper'

describe "Static Pages" do

  describe "visit welcome page" do

  	it "should display welcome text" do
  		visit welcome_path
  		expect(page).to have_content("Welcome to real money")
  	end

  end


  describe "visit site root" do

  	it "when not logged in" do
  		visit root_path
  		expect(page).to have_content("Welcome to real money")
  	end

  	let(:user) { FactoryGirl.create(:user) }
  	it "when logged in" do
  		sign_in user
  		visit root_path
  		expect(page).to have_content("Here are your transactions")
  	end

  end

end