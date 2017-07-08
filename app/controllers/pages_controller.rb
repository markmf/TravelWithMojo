class PagesController < ApplicationController
  
  def home

    @experiences = Experience.all

  	if current_user
  		redirect_to experiences_path

    end

  end


  def search

  	

  end

  	
  
end
