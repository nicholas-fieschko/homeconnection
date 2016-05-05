class BlacklistingsController < ApplicationController
  before_action :set_blacklisting, only: [:show, :edit, :update, :destroy]

  # GET /blacklistings
  # GET /blacklistings.json
  def index
    @blacklistings = Blacklisting.all
  end

  # GET /blacklistings/1
  # GET /blacklistings/1.json
  def show
  end

  # GET /blacklistings/new
  def new
    @blacklisting = Blacklisting.new
  end

  # GET /blacklistings/1/edit
  def edit
  end

  # POST /blacklistings
  # POST /blacklistings.json
  def create
    @blacklisting = Blacklisting.new(blacklisting_params)

    respond_to do |format|
      if @blacklisting.save
        format.html { redirect_to @blacklisting, notice: 'Blacklisting was successfully created.' }
        format.json { render :show, status: :created, location: @blacklisting }
      else
        format.html { render :new }
        format.json { render json: @blacklisting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blacklistings/1
  # PATCH/PUT /blacklistings/1.json
  def update
    respond_to do |format|
      if @blacklisting.update(blacklisting_params)
        format.html { redirect_to @blacklisting, notice: 'Blacklisting was successfully updated.' }
        format.json { render :show, status: :ok, location: @blacklisting }
      else
        format.html { render :edit }
        format.json { render json: @blacklisting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blacklistings/1
  # DELETE /blacklistings/1.json
  def destroy
    @blacklisting.destroy
    respond_to do |format|
      format.html { redirect_to blacklistings_url, notice: 'Blacklisting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blacklisting
      @blacklisting = Blacklisting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blacklisting_params
      params.require(:blacklisting).permit(:user_id, :blocked_user)
    end
end
