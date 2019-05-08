# frozen_string_literal: true

require 'spec_helper'
require './lib/services/lyrics/parser'

RSpec.describe Lyrics::Parser do
  describe '#parser' do
    let(:lyrics) do
      "Last night she said\n" \
      'Oh baby I feel so down'
      # Oh it turn me off
      # When I feel left out
      # So I, I turned around
      # Oh maybe I don't care no more
      # I know this for sure
    end

    subject { described_class.new(lyrics) }

    it 'splits on new lines' do
      expect(subject.parse).to eq([
                                    'Last night she said',
                                    'Oh baby I feel so down'
                                  ])
    end

    context 'with blank lines' do
      let(:lyrics) { "#{super()}\n  " }

      it 'removes blank lines' do
        expect(subject.parse).to eq([
                                      'Last night she said',
                                      'Oh baby I feel so down'
                                    ])
      end
    end

    context 'with chorus marks' do
      let(:lyrics) { "#{super()}\n[Chorus]" }

      it 'removes chorus marks' do
        expect(subject.parse).to eq([
                                      'Last night she said',
                                      'Oh baby I feel so down'
                                    ])
      end
    end

    context 'with other song structure marks' do
      let(:lyrics) { "#{super()}\n{Bridge}" }

      it 'removes other song structure marks' do
        expect(subject.parse).to eq([
                                      'Last night she said',
                                      'Oh baby I feel so down'
                                    ])
      end
    end

    context 'with parenthesis wrapping lyrics' do
      let(:lyrics) { "#{super()}\n(Oh it turn me off)" }

      it 'removes parenthesis but leaves text' do
        expect(subject.parse).to eq([
                                      'Last night she said',
                                      'Oh baby I feel so down',
                                      'Oh it turn me off'
                                    ])
      end
    end
  end
end
