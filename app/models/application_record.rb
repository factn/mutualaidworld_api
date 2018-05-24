class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def mqtt_me(an_object)
    MQTT::Client.connect(host: "m11.cloudmqtt.com", port: 10_464, username: "flcdwssy", password: "c_EJH1DfnFis") do |c|
      c.publish(an_object.class.name + "/" + an_object.id.to_s, "updated")
    end
  end
end
