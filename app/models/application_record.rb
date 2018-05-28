class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  require "mqtt"
  require "uri"

  cloudmqtt_fallback = "mqtt://flcdwssy:c_EJH1DfnFis@m11.cloudmqtt.com:10464"
  uri = URI.parse ENV["CLOUDMQTT_URL"] || cloudmqtt_fallback

  @@conn_opts = {
    remote_host: uri.host,
    remote_port: uri.port,
    username: uri.user,
    password: uri.password
  }

  def mqtt_me(an_object)
    MQTT::Client.connect(@@conn_opts) do |c|
      c.publish(an_object.class.name + "/" + an_object.id.to_s, "updated")
    end
  end
end
