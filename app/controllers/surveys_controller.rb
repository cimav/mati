class SurveysController < ApplicationController
  def vote
  	@survey = Survey.find_by_token(params[:token])
  	if @survey.rating > 0 
      redirect_to show_survey_path(@survey.token)
    else 
  	  @survey.rating = params[:rating]
  	  @survey.save
  	  render layout: 'standalone'
  	end
  end

  def save
  	@survey = Survey.find_by_token(params[:token])
  	@survey.comments = params[:survey][:comments]
  	@survey.save
  	render layout: 'standalone'
  end

  def show 
  	@survey = Survey.find_by_token(params[:token])
  	render layout: 'standalone'
  end
end
