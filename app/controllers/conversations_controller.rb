class ConversationsController < ApplicationController
  before_action :authenticate_user!

   respond_to :json

  def index
    @conversations = Conversation.involving(current_user)
    puts "Conversations Index: There are #{@conversations.length} conversations."
    logger.debug @conversations.inspect

  end

  def new
    @conversation = Conversation.create(conversation_params)
  end

  def create

     logger.debug conversation_params.inspect
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      puts "Found a conversation between SEnder: #{params[:sender_id]} and Recipient: #{params[:recipient_id]}"
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first

     
    else
      puts "Creating new conversation *********"
      
      @conversation = Conversation.create!(conversation_params)
    
 
    end

    logger.debug "Sender ID: #{@conversation.sender_id}, Recipient ID: #{@conversation.recipient_id}"

      redirect_to conversation_messages_path(@conversation)
#    format.html { redirect_to conversation_messages_path(@conversation), notice: 'Conversation was successfully created.' }

   
    
  end

  private

    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
end