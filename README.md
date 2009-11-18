## Demeter

A simple way to apply the Law of Demeter to your objects. Work with pure Ruby, Ruby on Rails or any other framework.

## Instalation

It might not be a bad idea to make sure you are running the latest RubyGems:

    sudo gem update --system

Install demeter gem from gemcutter

    sudo gem sources -a http://gemcutter.org
    sudo gem install demeter

## Usuage

The usuage is very straightforward. You only need to extend one module and use one method.

## Example

    require 'demeter'
    class Customer
      attr_accessor :name
    end
    
    class Manager
      attr_accessor :type
    end
     
    class Account
      extend Demeter
      attr_accessor :customer, :manager
      demeter :customer, :manager
    end
     
    c = Customer.new
    c.name = "Emerson"
     
    m = Manager.new
    m.type = "General"
     
    a = Account.new
    a.customer = c
    a.manager = m
    puts a.customer_name #Should print Emerson at console
    puts a.manager_type #Should print General at console

## Working with Rails
Say we have two models: Post and Comment. We often access attributes like this:
    #models
    class Post < ActiveRecord::Base
      has_many :comments
    end
    
    class Comment < ActiveRecord::Base
      belongs_to :post
    end

    #view
    @comment.post.title
    @comment.post.name
    @comment.post.something_else

This example is surely very simple, only to illustrate why we hurt Lay of Demeter. With demeter gem, we can avoid this, in a simple way:

    #models
    class Post < ActiveRecord::Base
      has_many :comments
    end
    
    class Comment < ActiveRecord::Base
      extend Demeter     #extends demeter module
      demeter :post      #demeter post object
      belongs_to :post
    end

    #view
    @comment.post_title
    @comment.post_name
    @comment.post_something_else

Demeter also keeps you in control, so you can override the default behavior of demeter message handles.

    #models
    class Post < ActiveRecord::Base
      has_many :comments
    end
    
    class Comment < ActiveRecord::Base
      extend Demeter     #extends demeter module
      demeter :post      #demeter post object
      belongs_to :post

      #override post_title handle generated bt demeter
      def post_title
        post.title.upcase
      end
    end

    #view
    @comment.post_title          #will print uppercase post.title
    @comment.post_name
    @comment.post_something_else

## Credits
#### Author: Emerson Macedo
#### email: emerleite at gmail dot com
#### twitter: emerleite
#### github: github dot com slash emerleite

## Licence
See LICENCE.txt
