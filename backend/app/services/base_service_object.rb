# frozen_string_literal: true

class BaseServiceObject
  extend Dry::Initializer # use `param` and `option` for dependencies

  # option :errors, default: -> { Errors.new }
  #
  # attr_accessor :result

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
