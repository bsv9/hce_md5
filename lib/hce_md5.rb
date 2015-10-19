# encoding: utf-8

require 'hce_md5/version'
require 'digest'

##
# Class to emulate Perl's Crypt::HCE_MD5 module
#
# The MIME Functions are tested and work symmetrically with the
# Crypt::HCE_MD5 package (0.45) (without the KEYBUG Flag ..).
#
# Shamelessly stolen from Eric Estabrooks, eric@urbanrage.com
# Crypt::HCE_MD5 package:
#
# This package implements a chaining block cipher using a one way
# hash. This method of encryption is the same that is used by radius
# (RFC2138) and is also described in Applied Cryptography by Bruce
# Schneider (p. 353 / "Karn").
#
# Two interfaces are provided in the package. The first is straight
# block encryption/decryption the second does base64 mime
# encoding/decoding of the encrypted/decrypted blocks.
#
# The idea is the the two sides have a shared secret that supplies one
# of the keys and a randomly generated block of bytes provides the
# second key. The random key is passed in cleartext between the two
# sides.
class HCE_MD5
  # Creates a HCE_MD5 object.
  #
  # @param key [String] The shared secret key
  # @param random [String, nil] The randomly generated key
  def initialize(key, random = nil)
    @key = key
    if random.nil?
      # srand((double)microtime() * 32767)
      random = rand(32_767)
      random = [random].pack('i*')
    end
    @rand = random
  end

  # Encrypt a block of data.
  #
  # @param data [String] The data to encrypt.
  # @return [String] The encrypted binary data.
  def encrypt(data)
    data = data.unpack('C*')
    ans = []
    ans1 = []
    e_block = new_key(@rand)
    data.each_index do |i|
      mod = i % 16
      if (mod == 0) && (i > 15)
        tmparr = [
          ans[i - 16], ans[i - 15], ans[i - 14], ans[i - 13],
          ans[i - 12], ans[i - 11], ans[i - 10], ans[i - 9],
          ans[i - 8], ans[i - 7], ans[i - 6], ans[i - 5],
          ans[i - 4], ans[i - 3], ans[i - 2], ans[i - 1]
        ]
        tmparr = tmparr.collect { |val| val.to_s.chr }.join('')
        e_block = new_key(tmparr)
      end
      ans[i]  = e_block[mod] ^ data[i]
      ans1[i] = ans[i].chr
    end
    ans1.join('')
  end

  # Decrypt a block of data.
  #
  # @param data [String] The data to decrypt.
  # @return [String] The decrypted binary data.
  def decrypt(data)
    data = data.unpack('C*')
    ans = []
    ans1 = []
    e_block = new_key(@rand)
    data.each_index do |i|
      mod = i % 16
      if (mod == 0) && (i > 15)
        tmparr = [
          data[i - 16], data[i - 15], data[i - 14], data[i - 13],
          data[i - 12], data[i - 11], data[i - 10], data[i - 9],
          data[i - 8], data[i - 7], data[i - 6], data[i - 5],
          data[i - 4], data[i - 3], data[i - 2], data[i - 1]
        ]
        tmparr  = tmparr.collect { |val| val.to_s.chr }.join('')
        e_block = new_key(tmparr)
      end
      ans[i]  = e_block[mod] ^ data[i]
      ans1[i] = ans[i].chr
    end
    ans1.join('')
  end

  private

  # Implment md5 hashing in php, though use the mhash() function
  # if it is available.
  #
  # @param str [String] The string to hash.
  # @return [String] The md5 mhash of the string.
  def binmd5(str)
    Digest::MD5.digest(str)
  end

  # Generate a new key for a new encryption block.
  #
  # @param round [String] The basis for the key.
  # @return [String] The new key.
  def new_key(round)
    binmd5("#{@key}#{round}").unpack('C*')
  end
end
