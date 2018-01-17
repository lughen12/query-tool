require 'awesome_print'
require 'optparse'

module NinetySeconds
  module Services
    # A service that handle parsing command
    class CommandService
      # rubocop:disable Metrics/MethodLength
      def self.from_args(args)
        options = {
          format: 'text'
        }

        OptionParser.new do |parser|
          # Banner for cli
          parser.banner = 'Usage: query.rb [options]'

          # Get resource to query.
          parser.on('-r', '--resource resource', 'The name of the resource to query.') do |v|
            options[:resource] = v
          end

          # Get filter to query.
          parser.on('-q', '--query key1=value1,...', Array, 'Field value for the query.') do |q|
            options[:queries] = q
          end

          # Get format to output.
          parser.on('-f', '--format text', 'Display format (json, text). Default: text.') do |f|
            options[:format] = f
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
    end
  end
end
