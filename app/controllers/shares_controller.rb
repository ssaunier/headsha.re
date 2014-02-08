class SharesController < ApplicationController
  before_action :set_share, only: [:public, :header, :show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:public, :header]

  def public
    impressionist(@share, "page_view") if count_visit?
    render :layout => false
  end

  def header
    impressionist(@share, "header_click") if count_visit?
    redirect_to @share.header_url
  end

  # GET /shares
  # GET /shares.json
  def index
    @shares = current_user.shares.all
  end

  # GET /shares/1
  # GET /shares/1.json
  def show
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
end
