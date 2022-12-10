# Thankyou Joydeep Bhaiya 😁

module Exceptions
  GenericError = Class.new(StandardError)

  def self.included(klass)
    klass.constants(false).grep(/(.*)_ERROR/).each do |error_constant|
      next unless error_constant.is_a? Symbol

      error_message = klass.const_get(error_constant)
      next unless error_message.is_a? String

      error_klassname = error_constant.to_s.downcase.camelize

      error_klass = Class.new(GenericError) do
        define_method(:error_message) { error_message }

        def initialize(msg = error_message)
          super(msg)
        end
      end

      klass.const_set(error_klassname, error_klass)
    end
  end
end
