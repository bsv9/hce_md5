HCE_MD5 [![Build Status](https://travis-ci.org/bsv9/hce_md5.svg)](https://travis-ci.org/bsv9/hce_md5) [![Test Coverage](https://codeclimate.com/github/bsv9/hce_md5/badges/coverage.svg)](https://codeclimate.com/github/bsv9/hce_md5/coverage) [![Code Climate](https://codeclimate.com/github/bsv9/hce_md5/badges/gpa.svg)](https://codeclimate.com/github/bsv9/hce_md5)
========

Ruby class to emulate Perl's Crypt::HCE_MD5 module

The MIME Functions are tested and work symmetrically with the
Crypt::HCE_MD5 package (0.45) (without the KEYBUG Flag ..).
Shamelessly stolen from Eric Estabrooks, eric@urbanrage.com

Crypt::HCE_MD5 package:
This package implements a chaining block cipher using a one way
hash. This method of encryption is the same that is used by radius
(RFC2138) and is also described in Applied Cryptography by Bruce
Schneider (p. 353 / "Karn").

The idea is the the two sides have a shared secret that supplies one
of the keys and a randomly generated block of bytes provides the
second key. The random key is passed in cleartext between the two
sides.

Installation
------------

Add to your Gemfile:

```ruby
gem 'hce_md5'
```

Usage
-----

Encryption:

```ruby
require 'hce_md5'
hce = HCE_MD5.new('samplekey', 'randomkey')
hce.encrypt('text to encrypt')
```

Decryption:

```ruby
require 'hce_md5'
hce = HCE_MD5.new('samplekey', 'randomkey')
hce.decrypt(encrypted_text)
```


License
-------

Copyright (c) 2015 Sergey V. Beduev

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.