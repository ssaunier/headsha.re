class Api::V1::SharesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    respond_with current_user.shares.all
  end

  def create
    @share = current_user.shares.create(share_params)
    respond_with @share
  end

  private

    def share_params
      params.permit(:content_url, :header_url, :header_content, :header_background_color, :header_text_color)
    end
end