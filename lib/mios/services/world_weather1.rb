module MiOS
  module Services
    module Weather1
      def self.extended(base)
        base.instance_variable_set("@worldweather_urn", "urn:upnp-micasaverde-com:serviceId:Weather1")
      end

      def location
        value_for(@worldweather_urn, "Location")
      end

      def metric?
        boolean_for(@worldweather_urn, "Metric")
      end

      def last_update
        value_for(@worldweather_urn, "LastUpdate")
      end

      def condition
        value_for(@worldweather_urn, "Condition")
      end

      def wind
        { :condition => value_for(@worldweather_urn, "WindCondition"), :direction => value_for(@worldweather_urn, "WindDirection"), :speed => value_for(@worldweather_urn, "WindSpeed")}
      end
    end
  end
end
