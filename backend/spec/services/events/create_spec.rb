# frozen_string_literal: true

require 'rails_helper'

describe Events::Create do
  subject(:call_service) { described_class.new.call(service_params) }

  let(:guide) { create(:user) }
  let(:creator) { create(:user) }
  let(:route) { create(:route) }

  let(:event_params) do
    { name: 'Some name', description: 'some description', date: Time.zone.today, route_id: route.id }
  end

  shared_examples 'event is not created' do |_messages|
    it { is_expected.to be_failure }

    it 'returns Event#count' do
      expect { call_service }.not_to change { Event.count }.from(0)
    end

    it 'not creates users' do
      expect { call_service }.not_to change { EventsUser.count }.from(0)
    end
  end

  shared_examples 'event is created' do |_messages|
    it { is_expected.to be_success }

    it 'returns Event#count' do
      expect { call_service }.to change { Event.count }.from(0).to(1)
    end

    it 'return a new lead' do
      expect(call_service.success).to be_a(Event)
    end
  end

  context 'without event' do
    let(:service_params) do
      {
        user_id: creator.id,
        event_params: {},
        guide_id: guide.id
      }
    end

    it_behaves_like 'event is not created', ['Event must exist']
  end

  context 'with event' do
    context 'without creator' do
      let(:service_params) do
        {
          user_id: {},
          event_params: event_params,
          guide_id: guide.id
        }
      end

      it_behaves_like 'event is not created', ['User must exist']
    end

    context 'with creator' do
      context 'without guide' do
        let(:service_params) do
          {
            user_id: creator.id,
            event_params: event_params,
            guide_id: {}
          }
        end

        it_behaves_like 'event is created'

        it 'creates only one user(creator)' do
          expect { call_service }.to(change { EventsUser.count }.by(1))
        end
      end

      context 'with guide' do
        let(:service_params) do
          {
            user_id: creator.id,
            event_params: event_params,
            guide_id: guide.id
          }
        end

        it_behaves_like 'event is created'

        it 'creates two users' do
          expect { call_service }.to(change { EventsUser.count }.by(2))
        end
      end
    end
  end
end
