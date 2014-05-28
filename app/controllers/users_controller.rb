class UsersController < ApplicationController

	before_action :authenticate_user!, only: :balance

	def index
		@users = User.all
	end

	def balance
		@balance = current_user.balance	
	end

end
