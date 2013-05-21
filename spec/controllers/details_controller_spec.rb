require "spec_helper"

describe DetailsController do
  describe "GET index" do
    let!(:passage) { FactoryGirl.create(:passage) }

    it "has a 200 status code" do
      get :show, { keyword: 'Generic', id: passage.phrases.first.id }
      response.code.should eq("200")
    end

    it "should render the detail" do
      get :show, { keyword: 'Generic', id: passage.phrases.first.id }

    end
  end
end
