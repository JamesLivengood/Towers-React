require 'addressable/uri'

if ENV.has_key?('REDIS_URL')
  redis_conn_params = {}
	uri = Addressable::URI.parse(ENV['REDIS_URL'])
	redis_conn_params[:host] = uri.host
	redis_conn_params[:port] = uri.port
	redis_conn_params[:password] = uri.password
  $redis = Redis.new redis_conn_params
else
  $redis = Redis.new
end