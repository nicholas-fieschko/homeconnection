class ExchangesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_exchange, only: [:show, :edit, :update, :destroy]

  # GET /exchanges
  # GET /exchanges.json
  def index
    @exchanges = current_user_exchanges
    @complete, @pending = current_user_exchanges.to_a.partition { |exchange| exchange.complete? }
  end

  # GET /exchanges/1
  # GET /exchanges/1.json
  def show
  end

  # GET /exchanges/new
  def new
    @exchange = Exchange.new
  end

  # GET /exchanges/1/edit
  def edit
  end

  # POST /exchanges
  # POST /exchanges.json
  def create
    @exchange = Exchange.new(exchange_params)
    if @exchange.save
      notify_other_user_of_offer @exchange
      redirect_to '/dashboard', notice: "#{current_user.seeker? ? 'Request' : 'Offer' } was successfully sent."
    else
      render :new
    end
  end

  # PATCH/PUT /exchanges/1
  # PATCH/PUT /exchanges/1.json
  def update
    if @exchange.update(exchange_params)
      notify_other_user_of_update @exchange
      redirect_to '/dashboard', notice: 'Success!' 
    else
      render :edit
    end
  end

  # DELETE /exchanges/1
  # DELETE /exchanges/1.json
  def destroy
    notify_other_user_of_cancellation @exchange
    @exchange.destroy
    redirect_to '/dashboard', notice: 'Exchange was successfully cancelled.'
  end

  private
    def current_user_exchanges
      current_user.provider? ? Exchange.where(provider_id: current_user.id) : Exchange.where(seeker_id: current_user.id)
    end

    def set_exchange
      @exchange = Exchange.find(params[:id])
    end

    def other_user(exchange)
      other_user = User.find(current_user.seeker? ? exchange.provider_id : exchange.seeker_id)
    end

    def notify_other_user_of_cancellation(exchange)
      title = "Exchange was cancelled"
      body = "This is an automatically generated message letting you know that #{current_user.name} declined or cancelled your exchange."
      current_user.send_message(other_user(exchange), body, title)
    end

    def notify_other_user_of_offer(exchange)
      title = "New #{current_user.seeker? ? 'Request' : 'Offer' }"
      body = "This is an automatically generated message to let you know that #{current_user.name} has sent you a #{current_user.seeker? ? 'request' : 'offer' }. Please check your dashboard for more information."
      current_user.send_message(other_user(exchange), body, title)
    end

    def notify_other_user_of_update(exchange)
      title = "Update to exchange with #{current_user.name}"
      body = "This is an automatically generated message to let you know that #{current_user.name} has updated the status of your mutual exchange. Please check your dashboard for more information."
      current_user.send_message(other_user(exchange), body, title)
    end

    def exchange_params
      params.require(:exchange).permit(:provider_id, :seeker_id, :s_accepted, :p_accepted, :s_finished, :p_finished)
    end
end
