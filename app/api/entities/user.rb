module API
  module Entities
    class User < Grape::Entity
      expose :first_name
      expose :last_name
    end
  end
end
