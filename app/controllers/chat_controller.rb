class ChatController < ApplicationController

  @@my_callback = lambda { |envelope|
  	puts "envelope.status"
    puts envelope.status
  }

  def index
    @channel = params[:channel]
    @username = params[:username]
    @history_messages = nil

    # Only for passing it to JS on client side
    gon.sub_key = PUBNUB_SUBSCRIBE_KEY
    gon.channel = @channel
    gon.uuid = @username

    $pubnub = Pubnub.new(
        subscribe_key: PUBNUB_SUBSCRIBE_KEY,
        publish_key: PUBNUB_PUBLISH_KEY,
        uuid: @username
    )

    $pubnub.history(
        channel: @channel,
        count: 20,
        http_sync: true
    ) do |envelope|
      @history_messages = envelope.result[:data][:messages]
    end

  end

  def send_message
    $pubnub.publish(
        channel: params[:current_channel],
        message: {:sender => params[:current_username], :message => params[:message]},
        callback: @@my_callback
    )

    render :nothing => true
  end

  def unsubscribe
    $pubnub.unsubscribe(
        channel: params[:channel]
    )

    redirect_to root_url
  end

end
