# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'App Routes' do
  describe 'anniversaries' do
    it 'routes /anniversaries' do
      expect(get: '/v1/anniversaries').to route_to(
        controller: 'anniversaries',
        action: 'index'
      )
    end
  end
end
