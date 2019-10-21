# frozen_string_literal: true

require 'rails_helper'

describe Events::Create do
  subject { described_class.new.call(event_params) }

  let(:event_params) { { user_id: create(:user).id, params: { name: 'ASd', description: 'asdasdad', date: '2020-12-12', route_id: create(:route).id }, guide_id: create(:user).id } }

  shared_examples 'event is not created' do |_messages|
    it { is_expected.to be_failure }

    it 'returns Event#count' do
      expect { subject }.not_to change { Event.count }.from(0)
    end

    it 'not creates users' do
      expect { subject }.not_to change { EventsUser.count }.from(0)
    end
  end

  shared_examples 'event is created' do |_messages|
    it { is_expected.to be_success }

    it 'returns Event#count' do
      expect { subject }.to change { Event.count }.from(0).to(1)
    end

    it 'return a new lead' do
      expect(subject.success).to be_a(Event)
    end
  end

  context 'without event' do
    let(:event_params) { { user_id: create(:user).id, params: {}, guide_id: create(:user).id } }

    it_behaves_like 'event is not created', ['Event must exist']
  end

  context 'with event' do
    context 'without creator' do
      let(:event_params) { { user_id: {}, params: { name: 'ASd', description: 'asdasdad', date: '2020-12-12', route_id: create(:route).id }, guide_id: create(:user).id } }

      it_behaves_like 'event is not created', ['User must exist']
    end

    context 'with creator' do
      context 'without guide' do
        let(:event_params) { { user_id: create(:user).id, params: { name: 'ASd', description: 'asdasdad', date: '2020-12-12', route_id: create(:route).id }, guide_id: {} } }

        it_behaves_like 'event is created'

        it 'creates only one user(creator)' do
          expect { subject }.to(change { EventsUser.count }.by(1))
        end
      end

      context 'with guide' do
        it_behaves_like 'event is created'

        it 'creates two users' do
          expect { subject }.to(change { EventsUser.count }.by(2))
        end
      end
    end
  end
end
