# encoding: utf-8

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'hce_md5/version'

Gem::Specification.new do |s|
  s.name        = 'hce_md5'
  s.version     = HCE_MD5::VERSION
  s.authors     = ['Sergey V. Beduev']
  s.email       = ['beduev@gmail.com']
  s.homepage    = 'http://github.com/bsv9/hce_md5'
  s.summary     = 'Class to emulate Perl\'s Crypt::HCE_MD5 module'
  s.description = 'This package implements a chaining block cipher '\
                  'using a one wayhash. This method of encryption is '\
                  'the same that is used by radius (RFC2138) and is also '\
                  'described in Applied Cryptography by Bruce Schneider '\
                  '(p. 353 / "Karn"'

  s.rubyforge_project = 'hce_md5'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rubocop'
end
