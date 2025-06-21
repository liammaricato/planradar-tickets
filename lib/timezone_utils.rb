# frozen_string_literal: true

module TimezoneUtils
  def self.formatted_utc_zones
    @formatted_utc_zones ||= (-12..12).map { |offset| "#{offset}:00" }
  end

  def self.to_datetime_with_zone(date, time, timezone_str)
    parsed_offset = timezone_str.split(':').first.to_i
    time_zone = ActiveSupport::TimeZone[parsed_offset]
    
    datetime = time_zone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end

  # TimezoneUtils.to_datetime_with_zone(ticket.due_date, user.due_date_reminder_time, user.timezone)
end