require 'net/http'
require 'uri'
require 'json'


class GetStatus
  @@API_key = "4206942069s-42069w-42069a-42069g" #lul dis is not ai reel API
  attr_reader :name_status, :game_length, :game_status, :champ_name, :game_type, :version

  def initialize(name, platform)
    @name = name.downcase.gsub(/\s+/, '')
    @name_status = true
    @game_status = true
    @platform_id = platform
    @region = platform.gsub(/1/, '').downcase
    get_summoner_id
    get_game_status
  end

  def get_summoner_id
    link_name = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.4/summoner/by-name/#{@name}?api_key=#{@@API_key}"
    uri = URI.parse(link_name)
    response = Net::HTTP.get_response(uri)

    case response
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      @id = data[@name]["id"]
    when Net::HTTPNotFound then
      @name_status = false
    else
      abort("Service Error.")
    end
  end

  def get_game_status
    link_game = "https://#{@region}.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/#{@platform_id}/#{@id}?api_key=#{@@API_key}"
    uri2 = URI.parse(link_game)
    response = Net::HTTP.get_response(uri2)
    case response
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      @game_length = Time.at(data["gameLength"]).utc.strftime("%M")

      data["participants"].each do |profile|
        if profile["summonerId"] == @id
        @champ_id = profile["championId"]
        get_champ_name
        break
        end
      end

      @config_id = data["gameQueueConfigId"]
      get_game_type

    when Net::HTTPNotFound then
      @game_status = false
    else
      abort("Service Error.")
    end
  end

  def get_champ_name
    link_champ = "https://global.api.pvp.net/api/lol/static-data/#{@region}/v1.2/champion/#{@champ_id}?api_key=#{@@API_key}"
    uri3 = URI.parse(link_champ)
    response2 = Net::HTTP.get_response(uri3)
    champ_data = JSON.parse(response2.body)
    @champ_name = champ_data["name"]
  end

  def get_game_type
    q_type = @config_id
    if q_type == 0
      @game_type = "custom "
    elsif q_type == 2 || q_type == 14
      @game_type = "normal "
    elsif [7, 31, 32, 33].include? q_type
      @game_type = "bot "
    elsif [8, 9, 41, 52].include? q_type
      @game_type == "3v3 "
    elsif q_type == 65
      @game_type = "ARAM "
    elsif [4, 6, 42].include? q_type
      @game_type = "rank "
    elsif q_type == 76
      @game_type = "URF "
    elsif q_type == 61
      @game_type = "team builder "
    else
      @game_type = ""
    end    
  end

end

def get_server_status(region)
  link_server = "http://status.leagueoflegends.com/shards/#{region}"
  uri = URI.parse(link_server)
  response = Net::HTTP.get_response(uri)
  server_data = JSON.parse(response.body)
  server_data["services"].each do |service|
    if service["name"] == "Game"
      return service["status"]
    end
  end 
end


def get_patch_version(region)
    link_patch = "https://global.api.pvp.net/api/lol/static-data/#{region}/v1.2/versions?api_key=4206942069s-42069w-42069a-42069g"
    uri = URI.parse(link_patch)
    response = Net::HTTP.get_response(uri)
    data = response.body.gsub(/"/,'')
    data[0] = ''
    data[-1] = ''
    p data
    data_array = data.split(',')
    puts "Patch #{data_array[0]}"
end




puts "Please choose your region (NA, EUW, EWNE, PBE or OCE): "
region = gets.chomp.downcase
platform_id = region.upcase << "1"
server_status = get_server_status(region).upcase
get_patch_version(region)


puts "#{region.upcase} is #{server_status}"
puts

puts "Do you want to import saved names (y/n)?: "
answer = gets.chomp.downcase
if answer == 'y'
  name = File.open("saved.txt", 'r') { |file| file.read }
else
  puts "Enter summoner name: "
  name = gets.chomp
end

name = name.gsub(/\s+/, '').split(',').first(5)

name.each do |summoner|

  status = GetStatus.new(summoner, platform_id)
  champ = status.champ_name
  valid_name = status.name_status
  valid_game = status.game_status
  game_length = status.game_length
  game_mode = status.game_type
  patch = status.version

  if valid_name 
    if valid_game
      puts "Yes #{summoner} is in a #{game_mode}game, playing #{champ} for #{game_length} minutes!"
    else
      puts "#{summoner} is not currently in a game."
    end
  else
    puts "Can not find summoner with this name: #{summoner}."
  end

  puts "Patch #{patch}"

end



if answer != 'y' && name.length > 1
  puts "Do you want to save these names (y/n)?: "
  input = gets.chomp.downcase
  case input
  when 'y' then
    File.open("saved.txt", 'w') { |file| file.puts name.join(',') }
    puts "File saved."
  end
end








  
  

  
  

