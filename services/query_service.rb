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

      attr_reader :resource, :queries, :errors

      def initialize(resource: nil, queries: [], format: nil)
        @resource = resource ? resource.to_sym : nil
        @format = format ? format.to_sym : nil
        @queries = queries
        @errors = []
      end

      def presenter
        PRESENTERS[@format]
      end

      def execute
        params = @queries.map { |query| query.split('=') }.to_h
        RESOURCE_MODELS[@resource].where(params)
      end

      def valid?
        @errors << ERR_MISSING_RESOURCE if @resource.nil?
        @errors << ERR_RESOURCE_INVALID unless RESOURCE_MODELS.key? @resource
        @errors << ERR_FORMAT_INVALID unless PRESENTERS.key? @format
        @errors << ERR_QUERY_INVALID unless @queries.all? { |query| /.+=.+/.match(query) }

        @errors.empty?
      end
    end
  end
end
