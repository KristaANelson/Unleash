class Dog < ActiveRecord::Base
  belongs_to :user

  has_attached_file :img,
    styles: {medium: '300x300>'},
    storage: :s3,
    bucket: ENV['BUCKET_NAME'] 


  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/
end
