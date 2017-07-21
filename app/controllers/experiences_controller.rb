class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  before_action :get_reviews, only: [:show]

    Rails.logger.debug :search

  # GET /experiences
  # GET /experiences.json
  def index

   

    if params[:search].present? && params[:search].strip != ""
        session[:loc_search] = params[:search]
        @experiences = Experience.where(active: true).near(session[:loc_search] , 15, order: 'distance')
    else
        @experiences = Experience.where(active: true).all
    end

 

  # get the average rating per experience
    @experiences.each do |e |
      @per_experience = Experience.friendly.find(e.id)
      @reviews = @per_experience.reviews
      @rew = @reviews.average(:rating)
     puts "# of reviews: #{@reviews.count}, Average review is #{@rate} for experience #{@per_experience.id}, NAME: #{@per_experience.exp_name}"
   
    end

    if current_user.present?
     
    else
      redirect_to root_path(params[:search])
    end

#   Original search for all
 #   @experiences = Experience.all
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
    @photos = @experience.photos

  end

  # GET /experiences/new
  def new
  #  @experience = current_user.experiences.new
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
    @experience = current_user.experiences.new(experience_params)


     Rails.logger.debug experience_params.inspect
    
    #set default to true
    @experience.active = true

    respond_to do |format|

      if @experience.save



        if params[:images] 
          puts "***********CREATING Photo File********************************"
          params[:images].each do |image|
            @experience.photos.create(image: image)
          end
        end
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
