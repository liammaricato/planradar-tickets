# frozen_string_literal: true

module TimezoneUtils
  def self.formatted_utc_zones
    @formatted_utc_zones ||= (-12..12).map { |offset| "#{offset}:00" }
  end

  def self.timezone_by_offset(offset)
    ActiveSupport::TimeZone[offset.to_i]
  end

  def self.to_utc_datetime(date, time, timezone_str)
    timezone = timezone_by_offset(timezone_str)
    local_datetime = timezone.local(date.year, date.month, date.day, time.hour, time.min, time.sec)

    local_datetime.utc
  end
end
