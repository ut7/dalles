#!/usr/bin/env ruby

while true
  #putc ([" ", "\u2588"][rand(2)])
  system("tput setaf #{rand(15)}")
  system("tput setab #{rand(15)}")
  putc (["\u2605", "\u2588"].sample)
  sleep 0.01
end
