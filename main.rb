require 'awesome_print'
require 'require_all'

require_all 'services'

DELIMETER = "\n--------------------------------\n".freeze

options = NinetySeconds::Services::CommandService.from_args(ARGV)
exit if ARGV.include?('-h') || ARGV.include?('--help')

query = NinetySeconds::Services::QueryService.new(options)
unless query.valid?
  puts 'Invalid arguments:'.red
  puts query.errors.join("\n")
  exit 1
end

results = query.execute
puts "----------RESULTS (#{results.length})-----------".green

if results.empty?
  puts 'No result found.'
else
  results.each_with_index do |element, index|
    puts query.presenter.present element
    puts DELIMETER.green if index < (results.length - 1)
  end
end

exit 0
