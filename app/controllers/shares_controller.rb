require "net/http"
require "uri"

class SharesController < ApplicationController
  before_action :set_share, only: [:public, :header, :proxy_content, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:public, :header, :proxy_content, :show]
  skip_after_filter :intercom_rails_auto_include, only: [:public, :header, :proxy_content]

  def public
    impressionist(@share, "page_view") if count_visit?
    @content_url = @original_content_url = @share.content_url + (@share.content_url.match(/\?/) ? "&" : "?") + "utm_source=headsha.re&utm_campaign=headsha.re#{@share.id}&utm_medium=headsha.re"
    if proxy_content_response["X-FRAME-OPTIONS"]
      @content_url = proxy_content_share_path
    end
    render :layout => false
  end

  def header
    impressionist(@share, "header_click") if count_visit?
    redirect_to @share.header_url
  end

  def proxy_content
    body = proxy_content_response.body
    ["href", "src"].each do |token|
      body = body.gsub /#{token}=["']([^"']*)["']/i do
        "#{token}=\"" + URI::join(@share.content_url, "#{$1}").to_s + '"'
      end
    end
    render :text => body
  end

  # GET /shares
  # GET /shares.json
  def index
    @shares = current_user.shares.all
  end

  # GET /shares/1
  # GET /shares/1.json
  def show
    return redirect_to "/#{params[:id]}" unless current_user
    set_share
  end

  # GET /shares/new
  def new
    last_share = current_user.shares.last
    if last_share
      @share = current_user.shares.new header_content: last_share.header_content, header_url: last_share.header_url
    else
      @share = current_user.shares.new
    end
  end

  # GET /shares/1/edit
  def edit
  end

  # POST /shares
  # POST /shares.json
  def create
    @share = current_user.shares.new(share_params)

    respond_to do |format|
      if @share.save
        format.html { redirect_to @share, notice: 'Share was successfully created.' }
        format.json { render action: 'show', status: :created, location: @share }
      else
        format.html { render action: 'new' }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shares/1
  # PATCH/PUT /shares/1.json
  def update
    respond_to do |format|
      if @share.update(share_params)
        format.html { redirect_to @share, notice: 'Share was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share.destroy
    respond_to do |format|
      format.html { redirect_to shares_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share
      @share = Share.find(params[:id])
      authorize @share
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_params
      params.require(:share).permit(:content_url, :header_url, :header_content, :header_background_color, :header_text_color)
    end

    def count_visit?
      !(current_user && @share.user_id == current_user.id)
    end

    def proxy_content_response
      uri = URI.parse @share.content_url
      Net::HTTP.get_response uri
    end
end
