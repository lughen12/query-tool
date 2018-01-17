require 'json'

module NinetySeconds
  module Presenters
    # Base class for all presenters
    class Base
      # Default behavior for presenter, just call to_s on a hash
      # @param options [Hash] The hash to be presented
      # @return [String] The formatted text
      def self.present(options)
        options.to_s
      end
    end
  end
end
