# frozen_string_literal: true

require 'rails_helper'

describe Events::Create do
  subject { described_class.call(user, event_params) }

  let(:user) { build(:user) }
  let(:event_params) { { event_name: 'some name', event_description: 'some description', event_date: 'some date', route_id: 'some id' } }

  shared_examples 'event is not created' do |_messages|
    it 'returns Event#count' do
      expect { subject }.not_to change { Event.count }.from(0)
    end
  end

  context 'without user' do
    let(:user) {}

    it_behaves_like 'event is not created', ['please specify user', 'User must exist']
  end

  context 'with user' do
    context 'without message' do
      let(:event_params) {}

      it_behaves_like 'event is not created', ['Invalid data']
    end

    context 'with message' do
      it 'returns Event#count' do
        expect { subject }.to change { Event.count }.from(0).to(1)
      end
    end
  end
end
