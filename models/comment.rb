class Comment
    include MongoMapper::Document

    # key <name>, <type>
    key :nick, String
    key :body, String
    timestamps!

    validates_presence_of :nick
    validates_presence_of :body

    belongs_to :req
end
