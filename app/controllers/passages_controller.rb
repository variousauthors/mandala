class PassagesController < ApplicationController
  # GET /passages
  # GET /passages.json
  def index
    @passage = Passage.find(params[:id])
    @passage.receives_damage

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @passages }
    end
  end

  # GET /passages/1
  # GET /passages/1.json
  def show
    @passage = Passage.find_by_title!(URI.unescape(params[:title]))
    @passage.receives_damage

    respond_to do |format|
      format.html { render layout: false } # show.html.erb
      format.json { render json: @passage }
    end
  end
end
