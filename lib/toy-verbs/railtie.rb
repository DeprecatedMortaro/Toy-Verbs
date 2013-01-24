module ToyVerbs

  def self.load! dir_path
    Dir[dir_path].each { |file| load file }
  end

  class Engine < Rails::Engine
    loader = Proc.new { ToyVerbs.load! "#{Rails.root}/app/controllers/*.rb" }
    config.to_prepare &loader
    initializer 'toy_attributes.load_routes', :after => :disable_dependency_loading, &loader
  end

end
