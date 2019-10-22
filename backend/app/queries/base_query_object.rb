# frozen_string_literal: true

class BaseQueryObject
  extend Dry::Initializer

  class << self
    # Instantiates and calls the service at once
    def call(*args, &block)
      new(*args).call(&block)
    end

    # Accepts both symbolized and stringified attributes
    def new(*args)
      args << args.pop.symbolize_keys if args.last.is_a?(Hash)
      super(*args)
    end
  end

  def valid?
    errors.messages.empty?
  end
end
