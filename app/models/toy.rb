class Toy < ApplicationRecord
    validates :name, presence: true
    validate :image_url_get_request_must_be_successful

    private

    def image_url_get_request_must_be_successful
        response = HTTP.get(image)
        unless response.status < 400 && response["Content-Type"].match?(/image/)
            errors.add(:image, message: "URL must get an image")
        end if image
    end
end
