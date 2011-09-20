# iemodal

A gem to allow interaction with Internet Explorer modal dialogs.  This gem must be used
with the page-object gem.  You must simply include the iemodal module after you include
the page-object module.

	class MyPage
	  include PageObject
	  include IEModal
	end

## Known Issues

See [http://github.com/cheezy/page-object/issues](http://github.com/cheezy/iemodal/issues)

## Copyright

Copyright (c) 2011 Jeffrey S. Morgan. See LICENSE for details.
