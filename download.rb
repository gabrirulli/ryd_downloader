require 'io/console'
require 'uri'
require 'colorize'
require_relative 'methods'

def prompt(*args)
  print(*args)
  if args[0].match(/Password/)
    STDIN.noecho {|i| i.gets}
  else
    gets
  end
end

def info_request
  intro = "What do you want to download?\n"
  methods = "\t1) Single audio\n\t2) Playlist audio"
  choice = "\n\nChoose the number: "
  input = prompt(intro + methods + choice)
  info_answer(input.chomp.to_i)
end

def info_answer(input)
  case input
  when 1
    ask_video_id
  when 2
    playlist_audio_download
  else
    puts "You must choice one of the available answer\n".colorize(:red)
    info_request
  end
end

info_request