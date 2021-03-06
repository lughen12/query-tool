require 'awesome_print'
require 'optparse'

module NinetySeconds
  module Services
    # A service that handle parsing command
    class CommandService
      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/AbcSize
      def self.from_args(args)
        options = {
          format: 'text',
          limit: 5,
          offset: 0
        }

        OptionParser.new do |parser|
          # Banner for cli
          parser.banner = 'Usage: ruby main.rb [options]'

          # Get resource to query.
          parser.on('-r', '--resource resource', String, 'The name of the resource to query.') do |v|
            options[:resource] = v
          end

          # Get filter to query.
          parser.on('-q', '--query key1=value1,...', Array, 'Field value for the query.') do |q|
            # q is alrdy in array format. Ie: ["a=b", "c=d"]
            options[:queries] = q
          end

          # Get format to output.
          parser.on('-f', '--format text', String, 'Display format (json, text). Default: text.') do |f|
            options[:format] = f
          end

          # Get limit for pagination.
          parser.on('-l', '--limit number', Integer, 'Search limit. Default: 5.') do |l|
            options[:limit] = l
          end

          # Get limit for pagination.
          parser.on('-o', '--offset number', Integer, 'Search offset. Default: 0.') do |o|
            options[:offset] = o
          end

          # Help text
          parser.on('-h', '--help', 'Help') do
            puts parser
          end
        end.parse(args)

        options
      rescue OptionParser::ParseError => e
        puts 'Invalid command:'.red
        puts e.message
        exit 1
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize
    end
  end
end
