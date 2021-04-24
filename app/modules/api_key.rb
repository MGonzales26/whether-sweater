module ApiKey
  def self.generator
    SecureRandom.base64
  end
end