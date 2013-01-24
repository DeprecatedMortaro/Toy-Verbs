module ToyVerbs::Matcher

  ToyVerbs::VERBS.each do |verb|
    define_method verb do |path, opts={}, &blk|
      route_action verb, path, opts, &blk
    end
  end

  alias :_get :get

  def get *args, &blk
    return _get *args, &blk unless args[1].is_a?(Symbol) || args[1].is_a?(String)
    args.each { |action| _get action }
  end

  def draw *args
    router = Rails.application.routes
    router.disable_clear_and_finalize = true
    router.draw { send(*args) }
  end

  private

  def route_action verb, path, opts, &blk
    path = extract_path path
    draw verb, path => "#{extract_controller}##{extract_action(path, opts)}", as: extract_name(path, opts)
    return if opts[:action]
    blk = blk || Proc.new {}
    define_method extract_action(path, opts).to_sym, &blk
  end

  def extract_controller
    to_s.gsub('Controller', '').underscore
  end

  def extract_path path
    path.is_a?(Symbol) ? "/#{path.to_s.gsub('_','-')}" : path
  end

  def extract_action path, opts
    opts[:action] || path_to_method(path)
  end

  def extract_name path, opts
    opts[:as] || path_to_method(path)
  end

  def path_to_method path
    return 'root' if path == '/'
    fragments = path.split('/')
    fragments.each_with_index.map do |fragment, index|
      next if fragment[0] == ':'
      ((fragments[index+1] && fragments[index+1][0] == ':') ? fragment.singularize : fragment).parameterize.underscore
    end.delete_if{ |fragment| fragment.blank? }.join('_')
  end

end

ActionController::Base.extend ToyVerbs::Matcher
