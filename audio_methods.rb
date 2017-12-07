##### PLAYLIST AUDIO METHODS #####
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
  puts "Downloading..."
  `youtube-dl -u '#{username.chomp}' -p '#{password.chomp}' -o 'audio-%(playlist)s/%(title)s.%(ext)s' -i --download-archive playlist_ids.txt -x --audio-format mp3 '#{input.chomp}'`
  success_message

  info_request
end

def ask_playlist_url
  input = prompt("Insert your playlist url (es: https://www.youtube.com/playlist\?list\=PLX9tyjZvM3XkulR7zLVChSubaqCNkYQRC)\n")
  puts "Downloading..."
  `youtube-dl -o 'audio-%(playlist)s/%(title)s.%(ext)s' -i --download-archive playlist_ids.txt -x --audio-format mp3 '#{input}'`
  success_message

  info_request
end

##### SINGLE AUDIO METHODS #####

def ask_video_id
  begin
    input = prompt("Insert your video url (es: https://www.youtube.com/watch?v=esWUomP7dgs)\n")
    input = URI.parse(input).query.split("&").first.tr('v=','')
  rescue URI::InvalidURIError => err
    puts "Url format not valid\n".colorize(:red)
    ask_video_id
  end
end

def audio_download
  input = ask_video_id

  puts "Downloading..."
  `youtube-dl -o 'audio/%(title)s.%(ext)s' -i -x --audio-format mp3 '#{input}'`
  success_message

  info_request
end
