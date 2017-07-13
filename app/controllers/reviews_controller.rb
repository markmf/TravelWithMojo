class ReviewsController < ApplicationController
 # before_action :set_review, only: [:show, :index, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index 
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new

    @review = Review.new
    @sale = Sale.find.where(params[:id])
    if @sale.empty?
       puts "Not authorize to review"
    else
       put "We can review"
    end
  end

  

  def create
    
    Rails.logger.debug review_params.inspect
   
   # @experience = Experience.friendly.find(params[:id])
    @review = current_user.reviews.create(review_params)
    #@review = Review.new


      respond_to do |format|
        if @review.save
          format.json { render :show, status: :created, location: @review }
          redirect_to root_path, notice: 'Review was successfully created.' 
        else

          puts "****Review create FAILED!!!!******"
          format.html { render :new }
          format.json { render json: @experience.errors, status: :unprocessable_entity }
        end
      end
  end


  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    experience = @review.experience
    @review.destroy

    redirect_to experience
  end


  def current_exp
    @experiences = current_user.experiences
    @purchased = Sale.where(experience_id = current_user.experiences.id)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:user_email, :rating, :rating_desc, :review_date, :experience_id)
    end
end
