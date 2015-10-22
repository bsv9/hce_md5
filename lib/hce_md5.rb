# encoding: utf-8

require 'hce_md5/version'
require 'digest'

##
# Ruby class to emulate Perl's Crypt::HCE_MD5 module
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
        e_block = new_key(array2pack(16.downto(1).collect { |j| ans[i - j] }))
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
        e_block = new_key(array2pack(16.downto(1).collect { |j| data[i - j] }))
      end
      ans[i]  = e_block[mod] ^ data[i]
      ans1[i] = ans[i].chr
    end
    ans1.join('')
  end

  private

  # Turn an array into a binary packed string.

  def array2pack(array)
    array.compact.collect { |val| [val].pack('C*') }.join('')
  end

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
