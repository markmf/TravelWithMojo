class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  before_action :get_reviews, only: [:show]
 
 
  require 'pusher'

 

    Rails.logger.debug :search

  # GET /experiences
  # GET /experiences.json
  def index

   today = Date.today
   active = true
  #  reservations = @room.reservations.where("(start_date >= ? OR end_date >= ?) AND status = ?", today, today, 1)

    if params[:search].present? && params[:search].strip != ""
        session[:loc_search] = params[:search]
   #     @experiences = Experience.where(active: true).near(session[:loc_search] , 15, order: 'distance')
         @experiences = Experience.where("start_date >= ? AND active = ?", today, active).near(session[:loc_search] , 30, order: 'distance')
    else
  #    @experiences = Experience.where(active: true).all
      puts "**********executing BLANK Search**********"
      @experiences = Experience.where("start_date >= ? AND active = ?", today, active).all
    end

 

  # get the average rating per experience
  #  @experiences.each do |e |
  #    @per_experience = Experience.friendly.find(e.id)
  #    @reviews = @per_experience.reviews
  #    @rew = @reviews.average(:rating)
  #   puts "# of reviews: #{@reviews.count}, Average review is #{@rate} for experience #{@per_experience.id}, NAME: #{@per_experience.exp_name}" 
  # end

    if !current_user.present?
      redirect_to root_path(params[:search])
    else
     
    end

#   Original search for all
 #   @experiences = Experience.all
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
    @photos = @experience.photos

    #Get available dates for this selected experience
    @schedules = Schedule.where(experience_id: @experience.id).all
    logger.debug "No of schedule #{@schedules.length}"

    
  end

  # GET /experiences/new
  def new
  #  @experience = current_user.experiences.new

    # check if potential host has created a stripe payout method
    if !current_user.is_active_host
      return redirect_to payoffs_path, alert: "Please Connect to Stripe Express first."
    end

    @experience = Experience.new
    
  end

  # Display as a host all your experiences (ie events)
  def listing
    @experiences = current_user.experiences

  end

  # GET /experiences/1/edit
  def edit
    authorize! :manage, @experience

    @photos = @experience.photos
  end

  # POST /experiences
  # POST /experiences.json
  def create
  # check if potential host has created a stripe payout method
    if !current_user.is_active_host
      return redirect_to payoffs_path, alert: "Please Connect to Stripe Express first."
    end




    pusher_client = Pusher::Client.new(
          app_id: '387204',
         key: 'ee11638b413352bc6ebd',
        secret: '8ae2992e5c1cafa72d1b',
        cluster: 'mt1'
     )

    pusher_client.trigger('my-channel', 'update', {message: "Creating your experience,  #{current_user.first_name}", progress: 10 })
  
    @experience = current_user.experiences.new(experience_params)


    pusher_client.trigger('my-channel', 'update', {message: "Please wait, #{current_user.first_name}", progress: 30 })
     
     Rails.logger.debug experience_params.inspect
    
    #set default to true
    @experience.active = true

    respond_to do |format|



      if @experience.save



        if params[:images] 
           pusher_client.trigger('my-channel', 'update', {message: "Sorry #{current_user.first_name}, photos take a bit of time to save. Please wait...", progress: 60 })
          puts "***********CREATING Photo File********************************"
          params[:images].each do |image|
            @experience.photos.create(image: image)
          end
        end
        #create schedule file
        pusher_client.trigger('my-channel', 'update', {message: "Almost done, #{current_user.first_name} - You're Great! ", progress: 80 })
        puts "***********CREATING Schedule File********************************"
        #@schedule = Schedule.new
        #@schedule.user_id    = @experience.user_id
        #@schedule.id         = @experience.id
        #@schedule.start_date = @experience.start_date
        #@schedule.max_guests  = @experience.max_guest

        @experience.schedules.create(no_guests: 0, max_guests: @experience.max_guest, user_id: @experience.user_id, experience_id: @experience.id, start_date: @experience.start_date)

        pusher_client.trigger('my-channel', 'update', {message: "Perfect. Done", progress: 100 })

        @photos = @experience.photos
        format.html { redirect_to edit_experience_path(@experience), notice: 'Experience was successfully created.' }

   #     format.html { redirect_to @experience, notice: 'Experience was successfully created.' }
        format.json { render :show, status: :created, location: @experience }
      else
        format.html { render :new }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiences/1
  # PATCH/PUT /experiences/1.json
  def update
    
    authorize! :manage, @experience

   # @experience.exp_email = current_user.email
    
 
     Rails.logger.debug experience_params.inspect

    respond_to do |format|
      if @experience.update(experience_params)


        if params[:images] 
          params[:images].each do |image|
            @experience.photos.create(image: image)
          end
        end

        #update schedule as well - to do 
        puts "***********Updating Schedule File********************************"
        @experience.schedules.update(no_guests: 0, max_guests: @experience.max_guest, user_id: @experience.user_id, experience_id: @experience.id, start_date: @experience.start_date)
       
        format.html { redirect_to edit_experience_path(@experience), notice: 'Experience was successfully updated.' }


  #     format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.json
  def destroy

    authorize! :manage, @experience
    
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_url, notice: 'Experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def google_map(center)
          "https://maps.googleapis.com/maps/api?center=#{center}&size=420x420&zoom=17&key=AIzaSyDJdjhDvDJoxvVdEVz3Nn8Ia_uas00M34Q
"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.friendly.find(params[:id])
    end


   

    def get_reviews
        @booked = Sale.where("exp_id = ? AND buyer_email = ?", @experience.id, current_user.email).present? if current_user
        
        @reviews = @experience.reviews
  
        @hasReview = @reviews.find_by(user_id: current_user.id) if current_user

 # @hasReview = @reviews.where("buyer_email = ?", current_user.email) if current_user
    puts "***Booked is #{@booked}****"
    puts "***Reviews.count = #{@reviews.count} &&"
    puts "***hasReview = #{@hasReview} "
    puts "**** current.userID is #{current_user.id}***" if current_user
    end

    

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:exp_email, :exp_id, :exp_name, :exp_desc, :exp_where_be, :exp_location, :exp_provide, :exp_notes, :exp_location,  :about_me, :guest_reqs, :max_guest, :rsv_guest, :min_guest, :can_policy,  :exp_price, :go_time, :exp_duration, :start_date, :image) 
    end

end
