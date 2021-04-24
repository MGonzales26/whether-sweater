module Formatter

  def local_time(current_time, timezone_offset)
    Time.at(current_time).getlocal(timezone_offset).to_s
  end
end