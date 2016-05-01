class ExchangesController < ApplicationController
  before_action :set_exchange, only: [:show, :edit, :update, :destroy]

  # GET /exchanges
  # GET /exchanges.json
  def index
    @exchanges = current_user_exchanges
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
      redirect_to @exchange, notice: 'Offer was successfully sent.'
    else
      render :new
    end
  end

  # PATCH/PUT /exchanges/1
  # PATCH/PUT /exchanges/1.json
  def update
    if @exchange.update(exchange_params)
      redirect_to @exchange, notice: 'Exchange was successfully updated.' 
    else
      render :edit
    end
  end

  # DELETE /exchanges/1
  # DELETE /exchanges/1.json
  def destroy
    notify_other_user_of_cancellation @exchange
    @exchange.destroy
    redirect_to exchanges_url, notice: 'Exchange was successfully cancelled.'
  end

  private
    def current_user_exchanges
      current_user.provider? ? Exchange.where(provider_id: current_user.id) : Exchange.where(seeker_id: current_user.id)
    end

    def set_exchange
      @exchange = Exchange.find(params[:id])
    end

    def notify_other_user_of_cancellation(exchange)
      other_user = User.find(current_user.seeker? ? exchange.provider_id : exchange.seeker_id)
      title = "Exchange was cancelled"
      body = "This is an automatically generated message letting you know that #{other_user.name} declined or cancelled your exchange."
      current_user.send_message(other_user, body, title)
    end

    def exchange_params
      params.require(:exchange).permit(:provider_id, :seeker_id, :s_accepted, :p_accepted, :s_finished, :p_finished)
    end
end
