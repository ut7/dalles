#!/usr/bin/env ruby

BLOCKS = [0x1301E, 0x1301F, 0x13011]

def get_screen
  " " * 20 * 5
end

def update_screen (screen, x, y)
  screen[x+(y + 1)*20] = BLOCKS.sample.chr('utf-8')
  screen
end

system("tput setaf 7")
system("tput setab 0")
system("tput bold")

while true
  20.times { |x|
    screen = get_screen
    4.times { |y|
	p = (20 - x - y) % 20
        p2 = (20 - x - 1 - y) % 20
        screen = update_screen(screen, p, y)
        screen = update_screen(screen, p2, y)
    }
    puts screen
    sleep 0.3
  }
end

