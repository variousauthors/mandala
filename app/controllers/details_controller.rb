class DetailsController < ApplicationController

  # GET /details/1
  # GET /details/1.json
  def show
    # should be Passage.find_by_id.phrases.find_by_id.details.find_by_keyword or something maybe?
    @phrase = Phrase.find_by_id(params[:id])
    @detail = @phrase.details.find_by_keyword(URI.unescape(params[:keyword]))

    respond_to do |format|
      format.html { render layout: false }# show.html.erb
      format.json { render json: @detail }
    end
  end

end
