require 'require_all'

require_all 'models'
require_all 'presenters'

module NinetySeconds
  module Services
    # A service that perform a query by calling model methods
    class QueryService
      RESOURCE_MODELS = {
        user: NinetySeconds::Models::User,
        project: NinetySeconds::Models::Project
      }.freeze

      PRESENTERS = {
        text: NinetySeconds::Presenters::TextPresenter,
        json: NinetySeconds::Presenters::JsonPresenter
      }.freeze

      ERR_MISSING_RESOURCE = 'Resource is required'.freeze
      ERR_RESOURCE_INVALID = "Resource is invalid, accept: #{RESOURCE_MODELS.keys.join(', ')}".freeze
      ERR_FORMAT_INVALID = "Format is invalid, accept: #{PRESENTERS.keys.join(', ')}".freeze
      ERR_QUERY_INVALID = 'Query is invalid, need to be comma separated. Ie: key=value,key_2=value2'.freeze

      attr_reader :errors

      # Init the object
      # @param [Hash] opts The hash to init new instance
      # @option opts [String] :resource The resource to query
      # @option opts [Array<String>] :queries The query for execution later on
      # @option opts [String] :format The format to obtain presenter
      # @option opts [Number] :limit The limit for query execution later on
      # @option opts [Number] :offset The offset for query execution later on
      def initialize(resource: nil, queries: [], format: PRESENTERS.keys[0], limit: 5, offset: 0)
        @resource = resource ? resource.to_sym : nil
        @format = format ? format.to_sym : nil
        @limit = limit
        @offset = offset
        @queries = queries
        @errors = []
      end

      # Get presenter object
      def presenter
        PRESENTERS[@format]
      end

      # Execute the query
      def execute
        params = @queries.map { |query| query.split('=') }.to_h
        RESOURCE_MODELS[@resource].where(params, limit: @limit, offset: @offset)
      end

      # Validate if the query is valid
      def valid?
        @errors << ERR_MISSING_RESOURCE if @resource.nil?
        @errors << ERR_RESOURCE_INVALID if @resource && !RESOURCE_MODELS.key?(@resource)
        @errors << ERR_FORMAT_INVALID unless PRESENTERS.key? @format
        @errors << ERR_QUERY_INVALID unless @queries.all? { |query| /.+=.+/.match(query) }

        @errors.empty?
      end
    end
  end
end
