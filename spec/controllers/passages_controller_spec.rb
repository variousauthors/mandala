require "spec_helper"

describe PassagesController do
  describe "GET index" do
    let!(:passage) { FactoryGirl.create(:passage, :perimeter) }

    it "has a 200 status code" do
      get :index, id: 1
      response.code.should eq("200")
    end

    it "should damage the perimeter" do
      Passage.any_instance.should_receive(:receives_damage).and_call_original
      get :index, id: 1
    end

    it "should render the perimeter passage" do
      get :index, id: 1
      response.should render_template :index
    end
  end

  describe "GET show" do
    let!(:passage) { FactoryGirl.create(:passage, :second_passage) }

    it "should find a passage by name" do
      passage = FactoryGirl.build(:passage, :second_passage)
      get :show, title: "a second passage"
      assigns(:passage).title.should eq(passage.title)
    end

    it "should damage the given passage" do
      Passage.any_instance.should_receive(:receives_damage).and_call_original
      get :show, title: "a second passage"
    end

    it "should ajax render the given passage" do
      get :show, title: "a second passage"
      response.should render_template :show
    end

    it "has a 200 status code" do
      get :show, title: "a second passage"
      response.code.should eq("200")
    end

  end
end
