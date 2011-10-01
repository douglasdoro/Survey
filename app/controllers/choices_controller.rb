# encoding: utf-8

class ChoicesController < ApplicationController
  before_filter  :authenticate_user!
  
  def create
    @choice = Choice.new params[:choice]
    @choice.user_id = current_user.id
    
    if @choice.save
      redirect_to :back, :notice => "Pesquisa respondida com sucesso."
    else
      redirect_to :back, :alert => @choice.errors # "Não foi possível gravar sua resposta. Por favor, tente novamente."
    end
  end
end
