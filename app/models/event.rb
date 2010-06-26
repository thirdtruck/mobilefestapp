class Event < ActiveRecord::Base
    def after_now
      Time.zone = "Eastern Time (US & Canada)"
      now = Time.zone.now
      now_hour = now.hour
      after_now = true

      self.start_time =~ /^0*(\d):(\d\d)/    
      start_hour = $1.to_i
      start_minute = $2.to_i

      if start_hour+12 < now_hour: # convert the start time to 24 hour time (they're after noon)
        after_now = false
      else

      minute_buffer = 15 # Allow a margin of error for shows that have just started.  TODO: list all ongoing shows separately.
      if start_hour+12 == now_hour and start_minute+minute_buffer < now.min:
        after_now = false
      end
    end

      after_now
    end
    
    def self.all_after_now_today
      Time.zone = "Eastern Time (US & Canada)"
      now = Time.zone.now

      events = self.find(:all, :conditions => { :date => now.strftime("%A").upcase }).select { |event| event.after_now }
      events.sort_by { |event| event.start_time }
    end
end
