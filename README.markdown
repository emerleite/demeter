Demeter
=======

The Law of Demeter (LoD), or Principle of Least Knowledge, is a simple design style for developing software with the following guidelines:

* Each unit should have only limited knowledge about other units: only units "closely" related to the current unit.
* Each unit should only talk to its friends; don't talk to strangers.
* Only talk to your immediate friends.

Installation
------------

	sudo gem install demeter

Usage
-----

	require "demeter"

	class User
	  extend Demeter

	  demeter :address

	  attr_accessor :name
	  attr_accessor :address

	  def initialize
	    @address = Address.new
	  end
	end

	class Address
	  attr_accessor :country
	end

	user = User.new
	user.address.country = "Brazil"
	user.address_country
	#=> Brazil

If your using ActiveRecord, you don't have to extend the `Demeter` module.

	class User < ActiveRecord::Base
	  has_one :address
	  demeter :address
	end

	user = User.first
	user.address_country

You can easily override a method that has been "demeterized"; just declare it before or after calling the `demeter` method.

	class User < ActiveRecord::Base
	  has_one :address
	  demeter_address

	  def address_country
	    @address_country ||= address.country.upcase
	  end
	end

To-Do
-----

* Allow more than one level
* Automatically create accessors
* Detect all `has_one` and `belongs_to` relations and automatically "demeterized" them on ActiveRecord
* RDoc

Maintainer
----------

* Emerson Macedo (<http://codificando.com/>)

Contributor
-----------

* Nando Vieira (<http://simplesideias.com.br/>)

License:
--------

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.