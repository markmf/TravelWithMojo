class ExperiencesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_experience, only: [:show, :edit, :update, :destroy]


  # GET /experiences
  # GET /experiences.json
  def index
    @experiences = Experience.all
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
  end

  # GET /experiences/new
  def new
    @experience = Experience.new
  end

  # GET /experiences/1/edit
  def edit
    authorize! :manage, @experience
  end

  # POST /experiences
  # POST /experiences.json
  def create
    @experience = current_user.experiences.new(experience_params)

    respond_to do |format|
      if @experience.save
        format.html { redirect_to @experience, notice: 'Experience was successfully created.' }
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
        format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
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
    "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=300x300&zoom=17"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:exp_email, :exp_id, :exp_name, :exp_desc, :exp_where_be, :exp_location, :exp_provide, :exp_notes, :exp_location,  :about_me, :guest_reqs, :max_guest, :rsv_guest, :min_guest, :can_policy,  :exp_price, :start_time, :exp_duration, :image)
    end
end
