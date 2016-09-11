class PostulationsController < ApplicationController

  def new
    @postulation = Postulation.new
  end

  def create
    @postulation = Postulation.new(postulation_params)
    if @postulation.save
      redirect_to @postulation
    else
      render 'new'
    end
  end

  private
    def postulation_params
      params.require(:postulation).permit(:email, :address, :comment)
    end

end
