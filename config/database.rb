MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'ask_development'
  when :production  then MongoMapper.database = 'ask_production'
  when :test        then MongoMapper.database = 'ask_test'
end
