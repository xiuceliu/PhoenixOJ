class MessagesController < ApplicationController
  before_filter :set_message, only: [:show, :edit, :update, :destroy]
  require 'will_paginate/array'
  def index
    @messages_unread = []
    @messages_in = []
    @messages_out = []
    name = params[:receive_name]
    if name == nil  || name .blank? || name == current_user.username
      current_user.messages.all.each do |message| 
        if message.receiver_ID == current_user.id && message.receiver_delete == false 
                @messages_in.push(message)
                if message.state == false
                        @messages_unread.push(message)
                end 
        end
        if message.sender_ID ==current_user.id && message.sender_delete == false 
                @messages_out.push(message)
        end
      end
  end

     if name != nil  && User.find_by_username(name) != nil && name != current_user.username
           user = User.find_by_username(name)
     current_user.messages.all.each do |message| 
        if message.receiver_ID == current_user.id && message.receiver_delete == false && message.sender_ID == user.id
                @messages_in.push(message)
                if message.state == false
                        @messages_unread.push(message)
                end 
        end
        if message.sender_ID ==current_user.id && message.sender_delete == false && message.receiver_ID == user.id
                @messages_out.push(message)
        end
    end
  end
    @messages_unread = @messages_unread.reverse!.paginate :page => params[:page], :per_page => 10
    @messages_in = @messages_in.reverse!.paginate :page => params[:page], :per_page => 10
    @messages_out = @messages_out.reverse!.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html #index.html.erb
    end
  end

  def show
    @message = Message.find(params[:id])
    @user_send = User.find(@message.sender_ID)
    @user_receive = User.find(@message.receiver_ID)
    if current_user.id == @message.receiver_ID
        @message.state = true
        @message.save
    end
  end

  def new
    @message = Message.new
    @message.sender_ID = current_user.id
    @message.state = false
    @message.sender_delete = false
    @message.receiver_delete = false 
    @message.send_time = Time.now.to_s
    respond_to do |format|
      format.html #new.html.erb
    end
  end

  def edit
  end

  def create
    @message = Message.new(params[:message])
    if User.find_by_username(@message.receive_name) != nil
          @user = User.find_by_username(@message.receive_name)
          @message.receiver_ID = @user.id 
    end
    respond_to do |format|
     if  @message.save
      @duty = Duty.new
      @duty.message_id = @message.id
      @duty.user_id = @message.sender_ID
      @duty.save
      @duty = Duty.new
      @duty.message_id = @message.id
      @duty.user_id = @message.receiver_ID
      @duty.save
      format.html {redirect_to :controller => 'messages', :action => 'index' }
     else 
      format.html {render action: "new"}
     end
    end
  end

  def update
    @message.update_attributes(params[:message])
    respond_with(@message)
  end

  def destroy
    @message = Message.find(params[:id])
    if current_user.id == @message.sender_ID
      @message.sender_delete = true
    end
    if current_user.id == @message.receiver_ID
      @message.receiver_delete = true
    end
    @dutys = Duty.find_all_by_user_id(current_user.id)
    @dutys.each do |duty|
      if duty.message_id == @message.id
        duty.destroy
      end 
    end
    respond_to do |format|
      format.html {redirect_to :controller => 'messages', :action => 'index'}
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end
end
