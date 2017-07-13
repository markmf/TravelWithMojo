class PagesController < ApplicationController
  
  def home

  #  @experiences = Experience.all


    if params[:search].present? && params[:search].strip != ""
        session[:loc_search] = params[:search]
        @experiences = Experience.where(active: true).near(session[:loc_search] , 15, order: 'distance')
    else
        @experiences = Experience.where(active: true).all
    end

  	if current_user
  		redirect_to experiences_path

    end

  end


  def search

  	

  end

  	
  
end
