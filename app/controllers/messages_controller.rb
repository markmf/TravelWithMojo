class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation


  respond_to :html


  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to conversations_path, alert: "You don't have permission to view this."
    end
  end

  def new
    put "*********Entering NEW Message***********"
    @message = @conversation.messages.new
  end

  def create
   # if params[:message][:context].present?
   puts "*********Creating a message!***********"

      @message = @conversation.messages.new(message_params)
   
      @messages = @conversation.messages.order("created_at DESC")

      if @message.save
        puts "***********Saving Message************"
        ActionCable.server.broadcast "conversation_#{@conversation.id}", message: render_message(@message)
        #redirect_to conversation_messages_path(@conversation)
      end
   
    
  end

  private

    def render_message(message)
      self.render(partial: 'messages/message', locals: {message: message})
    end

    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
      params.require(:message).permit(:context, :user_id)
    end
end