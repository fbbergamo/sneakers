module Sneakers
  module Metrics
    class StatsdMetrics
      def initialize(conn)
        @connection = conn
      end

      def increment(metric)
        @connection.increment(metric)
      end

      def timing(metric, &block)
        start = Time.now
        block.call
        @connection.timing(metric, ((Time.now - start)*1000).floor)
      end
    end
  end
end

# `Sneakers` gem was originally implemented with `statsd-ruby` in mind and expects the
# instance passed to StatsdMetrics to respond to a method called `timing`.
# If you want to use the `statsd-instrument` gem instead of the `statsd-ruby`,
# you need to ensure the `statsd-instrument` implements the `timing` method:
module StatsD
  def self.timing(metric, ms)
    self.measure(metric, ms)
  end
end
