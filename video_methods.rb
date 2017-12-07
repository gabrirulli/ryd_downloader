##### PLAYLIST VIDEO METHODS #####
def ask_for_video_playlist
  input = prompt("Is the playlist private?(Yes/No) ")

  case input.chomp.downcase[0]
  when "y"
    playlist_download_with_youtube_auth
  when "n"
    playlist_download
  else
    puts "You must answer with 'Yes' or 'No'\n".colorize(:red)
    ask_for_video_playlist
  end
end

def playlist_download_with_youtube_auth
  input = prompt("Insert your playlist url (es: https://www.youtube.com/playlist\?list\=PLX9tyjZvM3XkulR7zLVChSubaqCNkYQRC)\n")
  username = prompt("Username: ")
  password = prompt("Password: ")
  `youtube-dl -u '#{username.chomp}' -p '#{password.chomp}' -o 'video-%(playlist)s/%(title)s.%(ext)s' -i --download-archive video_playlist_ids.txt '#{input.chomp}'`
  success_message
  info_request
end

def playlist_download
  input = prompt("Insert your playlist url (es: https://www.youtube.com/playlist\?list\=PLX9tyjZvM3XkulR7zLVChSubaqCNkYQRC)\n")
  `youtube-dl -o 'video-%(playlist)s/%(title)s.%(ext)s' -i --download-archive video_playlist_ids.txt '#{input}'`
  success_message
  info_request
end

##### SINGLE VIDEO METHODS #####

def ask_video_id
  begin
    input = prompt("Insert your video url (es: https://www.youtube.com/watch?v=esWUomP7dgs)\n")
    input = URI.parse(input).query.split("&").first.tr('v=','')
  rescue URI::InvalidURIError => err
    puts "Url format not valid\n".colorize(:red)
    uri_parser
  end
end

def video_download
  input = ask_video_id
  puts "Downloading..."
  `youtube-dl -o 'video/%(title)s.%(ext)s' -i '#{input}'`
  success_message

  info_request
end
