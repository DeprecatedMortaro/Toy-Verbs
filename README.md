Toy Verbs
=========

Toy Verbs is a component of [Toy Locomotive](https://github.com/Mortaro/Toy-Locomotive]), but can be used independently outside Toy Locomotive.


Getting Started
---------------

All you need to start using Toy Attributes is to add the following line to your application's Gemfile:

    gem "toy-verbs"

Routing with Verbs
------------------

This gem allows you to declare a route and an action inside your controller. In order to make it happen, your controller will have access to the following class methods:

    get, post, put, delete, match

Each verb is followed by a route, which will be mapped to a generated action. A block is accepted to define the action behavior, but it can also use a clean default:

    class SiteController < ApplicationController

      get '/' do
        render text: 'welcome'
      end

      get '/contact'

    end

In this example, accessing `http://localhost:3000/` in your browser will render the text "welcome", and accessing `http://localhost:300/contact` will invoke the view `site/contact`

The verb `get` also accepts multiple routes if they have empty actions, as many symbols and/or strings can be passed to this verb and each will generate a route.

    class SiteController < ApplicationController

      get '/', '/terms-of-service'

      get :root, :terms_of_service

      get '/', :terms_of_service

    end

*Note that `:root` is the symbolic representation of the special path `'/'`*

Verbs Options
-------------

Besides the path, each verb also accepts a hash with options.

Every route declared using a verb will generate a path helper, just like the named routes defined in `config/routes.rb`. You can see the pattern that generates the helpers below:

    get '/' # => root_path
    get '/terms-of-service' # => terms_of_service_path
    get :posts, :tags # => posts_path, tags_path
    get '/posts/:post_id/:comments/:comment_id' # => post_comment_path

This behavior can be overwritten by passing the ':as' option to the verb:

  get '/terms-of-service', as: 'tos' # => tos_path

As said before, an action will be generated, but this behavior can also be overwritten by passing the option ':action' to the verb. It is usefull for inherited actions or actions that you do not have explicit access to.

    class ApplicationController < ActionController:Base
      def save_contact
        # save the contact from a form and send copy via e-mail
      end
    end

    class SiteController < ApplicationController
      post '/contact', action: 'save_contact'
    end

Drawing Routes
--------------

Even if you still can write routes normaly on your `config/routes.rb`, it's possible to evaluate directly from inside your controller using `draw`, which may turn up being useful if you are using gems like devise, or even writing a plugin for rails:

    class UsersController < ApplicationController
      draw :devise_for, :users
    end
