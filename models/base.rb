require 'json'

module NinetySeconds
  module Models
    # Base class for models in the application
    class Base
      # Query record that EXACT match ALL condition in options hash
      # Ie: { name: 'Hung', age: 25 } will query for record with name="Hung" and age=25
      # @param options [Hash] The hash that is used to query
      # @param [Hash] opts The query options.
      # @option opts [Number] :limit The search limit
      # @option opts [Number] :offset The search offset
      # @return [Array<Hash>] The records that satified query
      def self.where(options, limit: 5, offset: 0)
        records = all.select do |record|
          # Need to satisfy all options
          options.all? { |key, value| safe_compare_string(value, record[key.to_s]) }
        end
        records[offset..(offset + limit - 1)] || []
      end

      # Fetch all record for the model.
      # This function will load json file and convert its' content to array of hash
      # Ie: { name: "Hung", age: 25 } will query for record with name="Hung" and age=25
      # @return [Array<Hash>] The records loaded from json file or empty array if parse error
      def self.all
        file = File.read(self::FILE_PATH)
        JSON.parse(file)
      rescue JSON::ParserError
        []
      end

      # Compare string with the other unkown type value.
      # This function will check type before doing comparison
      # Ie: safe_compare_string('11', 11) -> true
      # @param options [String] The string to compare
      # @param options [Object] The unkown type value to be compared
      # @return [Boolean] If the 2 inputs are equal
      def self.safe_compare_string(str_value, unkown_type_value)
        # Numeric value
        return str_value.to_i == unkown_type_value if unkown_type_value.is_a? Numeric
        # Boolean value
        return str_value == unkown_type_value.to_s if [true, false].include? unkown_type_value
        # String value
        return str_value == unkown_type_value if unkown_type_value.is_a? String
        # Array value
        return unkown_type_value.include? str_value if unkown_type_value.respond_to? :include?

        # Do not handle other cases
        false
      end
    end
  end
end
