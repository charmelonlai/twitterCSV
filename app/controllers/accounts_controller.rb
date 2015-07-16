class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  helper_method :username_available, :underscorifier, :destroy_all_accs, :image_search
  require 'csv'

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
    respond_to do |format|
      format.html 
      format.json
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"user-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = "8kCvnGwxy9krcTIxmzyIGOMqx"
      config.consumer_secret = "aaXmt7P6QHnPyHciKk1vbv8KT9unR5SnqbaRqjSYL64q4v3tCb"
      config.access_token = "3255900630-caSyr5fSnYyxLEhEYoMBA0eFO3w3HTYfoOn0NzF"
      config.access_token_secret = "Z6T4XJEzAjpJDRUA2MUYOF6Sl5DwuMZTL9FzQ1Lic1ZGb"
    end
  end

  def username_available
    username = params[:username]
    if username
      if username.length > 15 or username.length < 1 or username.match(/\s/) or twitter_client.user(username)
        data = {:message => "×"}
        render :json => data
      end
    end
  rescue Twitter::Error::NotFound
    data = {:message => "✓"}
    render :json => data
  rescue Twitter::Error::Forbidden
    data = {:message => "×"}
    render :json => data
  end

  def user_exists(user)
    if user.length > 15 or twitter_client.user(user)
      'not available'
    end
  rescue Twitter::Error::NotFound
    'available'
  rescue Twitter::Error::Forbidden
    'not available'
  end

  def underscorifier
    underscore_array = Array.new
    underscore1 = params[:username]
    underscore2 = params[:username]
    underscore3 = params[:username]
    while underscore_array.length < 1 && underscore3.length <15
      underscore1 = "_" + underscore1
      underscore2 = underscore2 + "_"
      underscore3 = "_"+underscore3+"_"
      if user_exists(underscore1) == 'available'
        underscore_array.push(underscore1)
      end
      if user_exists(underscore2) == 'available'
        underscore_array.push(underscore2)
      end
      if user_exists(underscore3) == 'available'
        underscore_array.push(underscore3)
      end
    end
    if underscore_array.length > 0
      data = {:message =>"Available Variations:" + underscore_array.join(", ")}
      render :json => data
    else 
      data = {:message =>""}
      render :json => data
    end
  end

  def image_search
    username = params[:username]
    GoogleAjax.referrer = "www.twitterusersearch.com"
    GoogleAjax.api_key = "AIzaSyCS53LQcE3Xtbe85NlcaOFzok_qGildrDc"
    data = Hash.new
    data = GoogleAjax::Search.images(username, {num: 8})
    data = data.fetch(:results)
    render :json => data
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
      @account = Account.new(account_params)
      #@account.user_id = current_account.id
      respond_to do |format|
        if @account.save
          format.html { redirect_to root_url, notice: 'Account was successfully created.' }
          format.json { render :json => @account.as_json}
          format.js {}
        else
          format.html { render :action => :new}
          format.json { render :json => @account.as_json, :status => :unprocessable_entity}
          format.js {}
        end
      end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

      respond_to do |format|
        if @account.update(account_params)
          format.html { redirect_to "/", notice: 'Account was successfully updated.' }
          format.json { render :index, status: :ok, location: @account }
        else
          format.html { render :edit }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_all_accs
    Account.destroy_all
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def auth_hash
      request.env['omniauth.auth']
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:ipaddress, :dummy, :username, :name, :password, :email, :org, :bio, :location, :website, :profile_img, :header_img)
    end
end
