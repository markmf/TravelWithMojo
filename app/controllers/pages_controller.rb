class PagesController < ApplicationController
  
  
    Rails.logger.debug :search

  def home

  #  @experiences = Experience.all

    today = Date.today
    active = true

  

    if  session[:loc_search].present? 
        @experiences = Experience.where(active: true).near(session[:loc_search] , 15, order: 'distance')
 # @experiences = Experience.where("start_date >= ? AND active = ?", today, active).near(session[:loc_search], 15, order: 'distance')
        session[:loc_search] = ""
    else
        @experiences = Experience.where("start_date >= ? AND active = ?", today, active).all

  #     @experiences = Experience.where(active: true).all
    end

  

  	

  end


  def search

  	

  end

  	
  
end
