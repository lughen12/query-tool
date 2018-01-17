module NinetySeconds
  module Models
    # Project model, which has FILE_PATH points to data/projects.json
    class Project < NinetySeconds::Models::Base
      FILE_PATH = 'data/projects.json'.freeze
    end
  end
end
