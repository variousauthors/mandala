require "spec_helper"

describe DetailsController do
  describe "GET show" do
    let!(:passage) { FactoryGirl.create(:passage) }
    render_views

    it "has a 200 status code" do
      get :show, { keyword: 'Generic', id: passage.phrases.first.id }
      response.code.should eq("200")
    end

    it "should render the detail" do
      get :show, { keyword: 'Generic', id: passage.phrases.first.id }

      response.body.should == "<p class='Generic'>\ndetail about a keyword\n</p>\n"
    end

    it "should find the right detail" do
      passage = FactoryGirl.build(:passage)
      detail = passage.phrases.first.details.find_by_keyword('Generic')
      get :show, { keyword: 'Generic', id: passage.phrases.first.id }
      assigns(:detail).should eq(detail)

    end

  end
end
