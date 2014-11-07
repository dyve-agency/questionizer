
# Adds an uuid (Ex: "1ca71cd6-08c4-4855-9381-2f41aeffe59c") before creating an object
# the extended model needs to support a uuid string attribute
#
#
module UniquelyIdentifiable

  extend ActiveSupport::Concern

  included do

    before_create :set_uuid

    private

    def set_uuid
      return if self.uuid
      self.uuid = generate_uuid
      while self.class.find_by_uuid(self.uuid)
        self.uuid = generate_uuid
      end
    end

    def generate_uuid
      SecureRandom.uuid
    end
  end
end

