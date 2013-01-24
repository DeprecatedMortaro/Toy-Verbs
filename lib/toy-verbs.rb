module ToyVerbs
  VERBS = [:get, :post, :put, :delete, :match]
end

require 'action_controller'

require 'toy-verbs/matcher'
require 'toy-verbs/railtie' if defined?(Rails)
