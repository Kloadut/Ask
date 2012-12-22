class Req
  include MongoMapper::Document

  # key <name>, <type>
  key :type, String
  key :status, String, :default => 'new'
  key :title, String
  key :body, String
  key :tags, Array
  key :lang, String
  key :author_nick, String
  key :author_email, String
  key :duplicate_id, ObjectId
  timestamps!

  validates_presence_of     :type
  validates_presence_of     :status
  validates_presence_of     :title
  validates_presence_of     :author_nick
  validates_presence_of     :author_email
  validates_length_of       :author_email,    :within => 3..100
  validates_format_of       :author_email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  # Callbacks
  after_destroy :delete_related_documents

  def delete_related_documents
      system "rm -rf #{PADRINO_ROOT}/public/attachments/#{self.id}"
  end

  def save_image(image)
      case image[:type]
      when "image/png"
          ext = "png"
      when "image/jpg"
          ext = "jpg"
      when "image/gif"
          ext = "gif"
      else
          flash[:warning] = "Invalid attachment format"
          return false
      end

      system "mkdir -p #{PADRINO_ROOT}/public/attachments/#{self.id}"
      File.open("#{PADRINO_ROOT}/public/attachments/#{self.id}/image.#{ext}", "wb") do |f|
        f.write(image[:tempfile].read)
      end
      return true
  end

end
