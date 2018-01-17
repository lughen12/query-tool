require 'json'

module NinetySeconds
  module Presenters
    # A presenter for json format
    class JsonPresenter < NinetySeconds::Presenters::Base
      # Return hash presentation in pretty json format
      #   {
      #     "key_1": "value1",
      #     "some_other_key": 2
      #   }
      # @param options [Hash] The hash to be presented
      # @return [String] The formatted text in JSON
      def self.present(options)
        JSON.pretty_generate(options)
      end
    end
  end
end
