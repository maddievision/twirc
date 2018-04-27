# http://philtoland.com/post/807114394/simple-blowfish-encryption-with-ruby

require 'openssl'
require 'base64'

module Blowfish
   def self.cipher(mode, key, data)
     cipher = OpenSSL::Cipher::Cipher.new('bf-cbc').send(mode)
     cipher.key = Digest::SHA256.digest(key)[0...16]
     cipher.update(data) << cipher.final
   end

   def self.encrypt(key, data)
     Base64.encode64(cipher(:encrypt, key, data))
   end

   def self.decrypt(key, text)
     cipher(:decrypt, key, Base64.decode64(text))
   end
end