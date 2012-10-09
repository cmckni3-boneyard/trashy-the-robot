#!/usr/bin/env ruby
require './trashy.rb'

trashy = Trashy.new

while true do
  time = Time.now.utc
  if time.wednesday? and time.hour == 4
    trashy.send_email
  else
    sleep(30*60)
  end
end