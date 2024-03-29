# encoding: utf-8

class SurveysController < ApplicationController
  before_filter  :authenticate_user!, :except => [:index, :show]
  
  def index
    @choice = Choice.new        
    @surveys = Survey.includes(:questions)
  end

  def show
    @survey = Survey.find(params[:id])
    @choice = Choice.new        
    @questions = @survey.questions.includes(:answers) 
  end

  def new
    @survey = Survey.new
    question = @survey.questions.build 
    2.times { question.answers.build }
  end

  def create
    @survey = Survey.new(params[:survey])
    @survey.user_id = current_user.id
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
  
  def watch
    @choice  = Choice.new
    @surveys = Survey.watching current_user
    @title   = "Pesquisas que acompanho(watch)"
    render :index
  end
  
  def my
    @choice  = Choice.new
    @surveys = Survey.my current_user
    @title   = "Minha pesquisas"
    
    render :index
  end
  
end