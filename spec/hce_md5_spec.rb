# encoding: utf-8

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'hce_md5'

describe HCE_MD5 do
  it 'should generate random key' do
    hce = HCE_MD5.new('samplekey')
    result = hce.decrypt(hce.encrypt('text to encrypt'))
    expect(result).to eq('text to encrypt')
  end

  it 'should encrypt & decrypt plain text' do
    hce = HCE_MD5.new('samplekey', 'XFileeharingPRO')
    result = hce.decrypt(hce.encrypt('text to encrypt'))
    expect(result).to eq('text to encrypt')
  end

  it 'should encrypt & decrypt long text' do
    hce = HCE_MD5.new('samplekey', 'XFileeharingPRO')
    str = 'The quick brown fox jumps over the lazy dog'
    result = hce.decrypt(hce.encrypt(str))
    expect(result).to eq(str)
  end
end
