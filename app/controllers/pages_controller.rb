class PagesController < ApplicationController
	def index
	    @cooks = Cook.all
	end
end
