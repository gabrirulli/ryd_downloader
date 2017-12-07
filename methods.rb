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
  `youtube-dl -u '#{username.chomp}' -p '#{password.chomp}' -o 'mp3-%(playlist)s/%(title)s.%(ext)s' -i --download-archive playlist_ids.txt -x --audio-format mp3 '#{input.chomp}'`
end

def ask_playlist_url
  input = prompt("Insert your playlist url (es: https://www.youtube.com/playlist\?list\=PLX9tyjZvM3XkulR7zLVChSubaqCNkYQRC)\n")
  `youtube-dl -o 'mp3-%(playlist)s/%(title)s.%(ext)s' -i --download-archive playlist_ids.txt -x --audio-format mp3 '#{input}'`
end

##### SINGLE AUDIO METHODS #####

def uri_parser
  begin
    input = prompt("Insert your video url (es: https://www.youtube.com/watch?v=esWUomP7dgs)\n")
    input = URI.parse(input).query.split("&").first.tr('v=','')
  rescue URI::InvalidURIError => err
    puts "Url format not valid\n".colorize(:red)
    uri_parser
  end
end

def ask_video_id
  input = uri_parser
  puts "Downloading..."
  `youtube-dl -o 'mp3/%(title)s.%(ext)s' -i -x --audio-format mp3 '#{input}'`
  if $?.success?
    puts "Download successfull"
  end
  info_request
end
