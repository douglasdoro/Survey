# encoding: utf-8

require 'spec_helper'

describe "Users" do
  describe "GET /" do
    it "should access sign up page" do
      visit root_path
      click_link "Registrar-se"
      
      current_path.should == new_user_registration_path
    end
    
    it "should access sign in page" do
      visit root_path
      click_link "Entrar"
      
      current_path.should == new_user_session_path
    end
    
    it "display public surveys" do 
      pending
      Survey.create! {}
      visit root_path
      page.should have_content("My first survey")
    end
  end
  
  describe "GET /sign_up" do
    it "to create new user" do
      visit new_user_registration_path
      fill_in "Nome", :with => "Douglas"
      fill_in "E-mail", :with => "douglasdoro@gmail.com"
      fill_in "Senha", :with => "123456"
      fill_in "Confirmar", :with => "123456"
      click_button "Registrar"
      
      current_path.should == root_path
      page.should have_content("Registrou-se com sucesso.")
      page.should have_content("Douglas")
      page.should have_content("Sair")
    end
  end
  
  describe "GET /sign_in " do 
    it "sign in" do
      User.create!({:name => "Douglas",
                    :email => "douglasdoro@gmail.com",
                    :password => "123456" })
                    
      visit new_user_session_path
      fill_in "E-mail", :with => "douglasdoro@gmail.com"
      fill_in "Senha", :with => "123456"
      click_button "Entrar"              
      page.should have_content("Fez login com sucesso.")
      page.should have_content("Douglas")
      page.should have_content("Sair")
    end
    
    it "sign in user without name" do
      User.create!({:email => "douglasdoro@gmail.com", :password => "123456" })
                    
      visit new_user_session_path
      fill_in "E-mail", :with => "douglasdoro@gmail.com"
      fill_in "Senha", :with => "123456"
      click_button "Entrar"              
      page.should have_content("Fez login com sucesso.")
      page.should have_content("douglasdoro@gmail.com")
      page.should have_content("Sair")
    end
  end
  
  describe "DELETE /sign_out " do 
    it "sign out" do
      User.create!({:name => "Douglas",
                    :email => "douglasdoro@gmail.com",
                    :password => "123456" })
                    
      visit new_user_session_path
      fill_in "E-mail", :with => "douglasdoro@gmail.com"
      fill_in "Senha", :with => "123456"
      click_button "Entrar"
      click_link "Sair"
      page.should have_content("Fez logout com sucesso.")
      page.should have_content("Entrar")
      page.should have_content("Registrar-se")
    end
  end  
end
