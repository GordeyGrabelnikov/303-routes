# frozen_string_literal: true

class TransactionContainer
  extend Dry::Container::Mixin

  register 'transaction' do |input, &block|
    result = nil

    begin
      ActiveRecord::Base.transaction do
        result = block.call(Dry::Monads.Success(input))
        raise ActiveRecord::Rollback if result.failure?

        result
      end
    rescue ActiveRecord::Rollback
    end
    result
  end
end
