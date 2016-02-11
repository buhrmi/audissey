class EmailProcessor
  def self.process(email)
    from = email.from
    encrypted = email.from.to_s.gsub('reply+', '').gsub('@relay.audissey.fm','')
    crypt = ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'])
    decrypted = crypt.decrypt_and_verify(encrypted)
    data = JSON.parse(decrypted)
    
    Message.create!(data.merge(:text => email.body))
  end
end
