##### PLAYLIST METHODS #####
def playlist_audio_download
  input = prompt("Is the playlist private?(Yes/No) ")

  case input.chomp.downcase[0]
  when "y"
    ask_playlist_url_with_youtube_auth
  when "n"
    ask_playlist_url
  else
    puts "You must answer with 'Yes' or 'No'\n".colorize(:red)
    playlist_audio_download
  end
end

def ask_playlist_url_with_youtube_auth
  input = prompt("Insert your playlist url (es: https://www.youtube.com/playlist\?list\=PLX9tyjZvM3XkulR7zLVChSubaqCNkYQRC)\n")
  username = prompt("Username: ")
  password = prompt("Password: ")
  puts "\n"
  exec "youtube-dl -u '#{username.chomp}' -p '#{password.chomp}' -o '%(playlist)s/%(title)s.%(ext)s' --download-archive playlist_ids.txt -x --audio-format mp3 '#{input.chomp}'"
end

def ask_playlist_url
  input = prompt("Insert your playlist url (es: https://www.youtube.com/playlist\?list\=PLX9tyjZvM3XkulR7zLVChSubaqCNkYQRC)\n")
  exec "youtube-dl -o '%(playlist)s/%(title)s.%(ext)s' --download-archive playlist_ids.txt -x --audio-format mp3 '#{input}'"
end

##### SINGLE AUDIO METHODS #####

def ask_video_id
  input = prompt("Insert your video url (es: https://www.youtube.com/watch?v=esWUomP7dgs)\n")
  input = URI.parse(input).query.split("&").first.tr('v=','')
  exec "youtube-dl -o '%(playlist)s/%(title)s.%(ext)s'-x --audio-format mp3 '#{input}'"
end
