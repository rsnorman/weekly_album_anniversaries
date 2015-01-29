require 'rails_helper'

RSpec.describe ApplicationController do

  describe "handling ActiveRecord::RecordNotFound error" do
    controller do
      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    describe "handling AccessDenied exceptions" do
      it "renders json 404 error" do
        get :index
        expect(response.status).to eq 404
      end
    end
  end

  describe "#current_client" do
    controller do
      def index
        @current_client = current_client
        render :json => {}
      end
    end

    context "with HTTP_UUID equal to client id" do
      let(:client) { create :client }

      it "assigns @current_client" do
        get :index, {}, { "HTTP_UUID" => client.uuid }
        expect(assigns(:current_client)).to eq client
      end
    end

    context "without HTTP_UUID set" do
      it "returns 404 error" do
        get :index
        expect(response.status).to eq 404
      end
    end

    context "with incorrect HTTP_UUID set" do
      it "returns 404 error" do
        get :index, {}, { "HTTP_UUID" => "baduuid" }
        expect(response.status).to eq 404
      end
    end
  end

  describe "set start of the week day" do
    controller do
      def index
        @week_start = Week.start_of_week
        render :json => {}
      end
    end

    before { get :index, { :format => :json }, { "HTTP_UUID" => client.uuid } }

    context "with client prefering monday start" do
      let(:client) { create :client, week_start_preference: "monday" }

      it "assigns @week_start" do
        expect(assigns(:week_start)).to eq :monday
      end
    end

    context "with client prefering sunday start" do
      let(:client) { create :client, week_start_preference: "sunday" }

      it "assigns @week_start" do
        expect(assigns(:week_start)).to eq :sunday
      end
    end
  end
end