# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  describe 'handling ActiveRecord::RecordNotFound error' do
    controller do
      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    describe 'handling AccessDenied exceptions' do
      it 'renders json 404 error' do
        get :index
        expect(response.status).to eq 404
      end
    end
  end

  describe 'set start of the week day' do
    controller do
      def index
        @week_start = Week.start_of_week
        render json: {}
      end
    end

    before { get :index, format: :json }

    context 'with genre prefering monday start' do
      it 'assigns @week_start' do
        expect(assigns(:week_start)).to eq :monday
      end
    end
  end
end
