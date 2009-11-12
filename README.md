## Demeter

A simple way to apply the Law of Demeter to your objects.

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
    puts a.customer_name
    puts a.manager_type

It should print "Emerson" at console
And should print "General" at console

## Credits
Author: Emerson Macedo
email: emerleite at gmail dot com
twitter: emerleite
github: github dot com slash emerleite

## Licence
See LICENCE.txt
