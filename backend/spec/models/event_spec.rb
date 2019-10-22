# frozen_string_literal: true

require 'rails_helper'

describe Event, type: :model do
  it { is_expected.to validate_presence_of(:event_name) }
  it { is_expected.to validate_presence_of(:event_description) }
  it { is_expected.to validate_presence_of(:event_date) }
end
