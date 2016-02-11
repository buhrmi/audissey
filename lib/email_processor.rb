class EmailProcessor
  def initialize(email)
    @email = email
  end
  
  def process
    email = @email
    from = email.from
    encrypted = email.to.first[:email].to_s.gsub('reply+', '').gsub('@relay.audissey.fm','')
    crypt = ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'])
    decrypted = crypt.decrypt_and_verify(encrypted)
    data = JSON.parse(decrypted)
    
    Message.create!(data.merge(:text => email.body))
  end
end
