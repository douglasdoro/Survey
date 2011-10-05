require 'spec_helper'

describe SurveysController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      pending 
      get 'show'
      response.should be_success
    end
  end

end
