# encoding: utf-8

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'hce_md5'

describe HCE_MD5 do
  it 'should generate random key' do
    hce = HCE_MD5.new('samplekey')
    result = hce.decrypt(hce.encrypt('text to encrypt'))
    expect(result).to eq('text to encrypt')
  end

  it 'should encrypt long line' do
    hce = HCE_MD5.new('samplekey', 'samplerandom')
    str = 'The quick brown fox jumps over the lazy dog'
    expect(hce.encrypt(str).unpack('H*')).to eq [
      'b2be6f377b58f892f1331b7dc6b94c12' \
      '335dce3978f9228058971db70879d658' \
      'ffef03be655bb26ef448be'
    ]
  end

  it 'should encrypt & decrypt long text' do
    hce = HCE_MD5.new('samplekey', 'samplerandom')
    str = 'The quick brown fox jumps over the lazy dog'
    result = hce.decrypt(hce.encrypt(str))
    expect(result).to eq(str)
  end
end
