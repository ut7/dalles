#!/usr/bin/env ruby

puts((0x13000..0x13400).map{|i|i.chr("utf-8")}.each_slice(20).map{|l|l.join("")}.each{|s|puts s;sleep 0.3})
