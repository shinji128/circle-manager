module UuidGenerator
  def self.included(uuid)
    uuid.before_create :generate_uuid
  end

  def generate_uuid
    self.uuid = loop do
      uuid = SecureRandom.uuid
      break uuid unless self.class.exists?(uuid: uuid)
    end
  end
end
