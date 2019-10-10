class BaseServiceObject
  class Errors
    extend Dry::Initializer

    option :messages, default: -> { {} }

    def add(code, msg)
      messages[code] = (messages[code] || []) << msg
    end

    def merge_with_models(*objects, prefix: nil)
      objects.each do |obj|
        obj.errors.messages.each do |key, texts|
          texts.each { |text| prefix ? add("#{prefix}.#{key}", text) : add(key, text) }
        end
      end
    end

    def full_messages
      messages.map(&method(:full_message))
    end

    private

    def full_message(attribute, messages)
      joint_messages = messages.join(', ')
      return joint_messages if attribute == :base

      "#{attribute.to_s.humanize} #{joint_messages}"
    end
  end
end
