# frozen_string_literal: true

require 'rails_helper'

describe Events::Update do
  subject(:call_service) { described_class.new.call(service_params) }

  let(:route) { create(:route) }
  let(:guide) { create(:user) }

  let(:event_params) do
    { name: 'Some name', description: 'Some_description', date: Time.zone.today, route_id: route.id }
  end

  shared_examples 'event is not update' do |_messages|
    it { is_expected.to be_failure }
  end

  shared_examples 'event is update' do |_messages|
    it { is_expected.to be_success }

    it 'change name' do
      call_service
      expect(event.reload.name).to eql service_params[:event_params][:name]
    end

    it 'change description' do
      subject
      expect(event.reload.description).to eql service_params[:event_params][:description]
    end

    it 'change date' do
      call_service
      expect(event.reload.date).to eql service_params[:event_params][:date]
    end

    it 'change route_id' do
      call_service
      expect(event.reload.route_id).to eql service_params[:event_params][:route_id]
    end
  end

  context 'without event' do
    let(:service_params) do
      {
        event: {},
        event_params: event_params,
        guide_id: guide.id
      }
    end

    it_behaves_like 'event is not update', ['Event must exist']
  end

  context 'with event' do
    let(:event) { create(:event) }

    context 'when service_params not valid' do
      let(:service_params) do
        {
          event: event,
          event_params: { name: {}, description: {}, date: Time.zone.today, route_id: {} },
          guide_id: guide.id
        }
      end

      it_behaves_like 'event is not update'

      it 'event will remain unchanged', ['Event data is not valid'] do
        call_service
        expect(event).to eq(event.reload)
      end
    end

    context 'when service_params is valid' do
      context 'without guide' do
        let(:service_params) do
          {
            event: event,
            event_params: event_params,
            guide_id: nil
          }
        end

        it 'destroy guide to event' do
          call_service
          expect(event.reload.guide).to eq(service_params[:guide_id])
        end

        it_behaves_like 'event is update'
      end

      context 'with guide' do
        let(:service_params) do
          {
            event: event,
            event_params: event_params,
            guide_id: guide.id
          }
        end

        it_behaves_like 'event is update'
        it 'adds or change guide to event' do
          call_service
          expect(event.reload.guide).to eq(guide)
        end
      end
    end
  end
end
