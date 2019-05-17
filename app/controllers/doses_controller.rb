class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    # raise
  end

  # Do I really need the new controller??
  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      # What do I want to do if it does not work
      render 'cocktails/show'
    end
  end

  def destroy
    # find dose first
    @dose = Dose.find(params[:id])
    if @dose.blank?
      puts "You cannot delete a dose that does not exist"
    else
      @dose.destroy
      # where do I want to redirect?
      redirect_to cocktail_path(@dose.cocktail)
    end
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end

