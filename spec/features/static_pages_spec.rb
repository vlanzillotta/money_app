require 'spec_helper'

describe "Static Pages" do

  describe "visit welcome page" do

  	it "should display welcome text" do
  		visit welcome_path
  		expect(page).to have_content("Welcome to real money")
  	end

  end

end