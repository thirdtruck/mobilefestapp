class Event < ActiveRecord::Base
    def after_now
      now = Time.now
      after_now = true

      self.start_time =~ /^0*(\d):(\d\d)/    
      start_hour = $1.to_i
      start_minute = $2.to_i

      if start_hour+12 < now.hour: # convert the start time to 24 hour time (they're after noon)
        after_now = false
      else

      if start_hour+12 == now.hour and start_minute < now.min:
        after_now = false
      end
      end

      after_now
    end
    
    def self.all_after_now_today
        events = self.find(:all, :conditions => { :date => Time.new.strftime("%A").upcase }).select { |event| event.after_now }
        events.sort_by { |event| event.start_time }
    end
end
