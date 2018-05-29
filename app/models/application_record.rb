class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  require "mqtt"
  require "uri"

  def mqtt_me(an_object)
    MQTT::Client.connect(Rails.configuration.MQTTOptions) do |c|
      c.publish(an_object.class.name + "/" + an_object.id.to_s, "updated")
    end
  end
end
