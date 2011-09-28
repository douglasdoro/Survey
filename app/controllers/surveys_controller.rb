class SurveysController < ApplicationController
  before_filter  :authenticate_user!, :except => [:index, :show]
  
  # OPTIMIZE
  def index
    if current_user
      return @surveys = Survey.try(params[:filter], current_user)
    end
    
    @surveys = Survey.includes(:questions).published
  end

  #TODO: only publish
  def show
    @survey = Survey.find(params[:id])
    @questions = @survey.questions.includes(:answers) 
  end

  def new
    @survey = Survey.new
    2.times do
      question = @survey.questions.build 
      2.times { question.answers.build }
    end
  end

  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      redirect_to @survey, :notice => "Pesquisa criada com sucesso."
    else
      render :action => 'new'
    end
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      redirect_to @survey, :notice  => "Pesquisa atualizada com sucesso."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
  
    redirect_to surveys_url, :notice => "Pesquisa removida com sucesso."
  end
  
  def toggle_publish
    @survey = Survey.find params[:id]
    @survey.update_attribute :published, !@survey.published

    redirect_to :back
  end  
  
  # OPTIMIZE
  def toggle_watch
    @survey = Survey.find params[:id]
    if @survey.watches.map(&:user_id).include? current_user.id
       @survey.watches.where(:user_id => current_user.id).first.destroy 
    else
      @survey.watches.build :user_id => current_user.id
      @survey.save
    end
    
    redirect_to :back
  end
end