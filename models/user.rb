module NinetySeconds
  module Models
    # Project model, which has FILE_PATH points to data/users.json
    class User < NinetySeconds::Models::Base
      FILE_PATH = 'data/users.json'.freeze
    end
  end
end
