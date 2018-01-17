module NinetySeconds
  module Presenters
    # A presenter for normal text format
    class TextPresenter < NinetySeconds::Presenters::Base
      # Return hash presentation in text format
      #   key_1            : value1
      #   some_other_key   : value2
      # @param options [Hash] The hash to be presented
      # @return [String] The formatted text in String
      def self.present(options)
        lines = []
        key_length = options.keys.max_by(&:length).length + 2

        options.each do |key, value|
          lines << "#{format_length(key, key_length)}: #{value}"
        end
        lines.join("\n")
      end

      # Add space(s) to String to meet minimum length requirement
      # @param text [String] The string to be formatted
      # @param min_length [Number] The minimum length of resulted string
      # @return [String]
      def self.format_length(text, min_length)
        return text if text.length >= min_length
        text + ' ' * (min_length - text.length)
      end
    end
  end
end
