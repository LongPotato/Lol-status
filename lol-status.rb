require 'net/http'
require 'uri'
require 'json'


Shoes.app(title: "Lol-status", width: 600, height: 600, resizable: false) do

  @@API_key = "4206942069s-42069w-42069a-42069g" #lul dis is not ai reel API


class GetStatus
  attr_reader :name_status, :game_length, :game_status, :champ_name, :sum_name, :reg

  def initialize(name, platform_id)
    @name = name.downcase.gsub(/\s+/, '')
    @name_status = true
    @game_status = true
    @p_id = platform_id
    @reg = platform_id.gsub(/1/, '').downcase
    get_summoner_id
    get_game_status
  end

  def get_summoner_id
    link_name = "https://#{@reg}.api.pvp.net/api/lol/#{@reg}/v1.4/summoner/by-name/#{@name}?api_key=#{@@API_key}"
    uri = URI.parse(link_name)
    response = Net::HTTP.get_response(uri)

    case response
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      @id = data[@name]["id"]
      @sum_name = data[@name]["name"]
    when Net::HTTPNotFound then
      @name_status = false
    else
      abort("Service Error.")
    end
  end

def get_game_status
    link_game = "https://#{@reg}.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/#{@p_id}/#{@id}?api_key=#{@@API_key}"
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
    when Net::HTTPNotFound then
      @game_status = false
    else
      abort("Service Error.")
    end
  end

  def get_champ_name
    link_champ = "https://global.api.pvp.net/api/lol/static-data/#{@reg}/v1.2/champion/#{@champ_id}?api_key=#{@@API_key}"
    uri3 = URI.parse(link_champ)
    response2 = Net::HTTP.get_response(uri3)
    champ_data = JSON.parse(response2.body)
    @champ_name = champ_data["name"]
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

  @@region = ""
  @@platform_id = ""

  background ("#000000".."#404040")
  stack width: 600, height: 600, margin: 0.1 do

  	
  	heading = para "League of Legends status"
  	heading.style(align: "center", stroke: gold, size: 35, font: "serif")
    
    status_line = para ""

  	flow margin_top: 20, width: 600 do
  	  p = para "Choose your region: "
  	  p.style(stroke: white)
  	  list_box items: ["", "NA", "EUW", "EUNE", "LAN", "OCE", "RU"], margin_left: 10 do |list|
  	  	@@region = list.text
        debug( "region is #{@@region}")
  	  	unless list.text == ""
  	  	  status = get_server_status(list.text.downcase)
  	  	  status_message = "#{list.text} is #{status.upcase}"
  	  	  status_line.replace(status_message)
  	  	  if status == "online"
  	  	    status_line.style(stroke: green, align: "center", size: 18)
      	  else
            status_line.style(stroke: red, align: "center", size: 18)
          end
  	  	else
  	  	  status_line.replace("Please choose a valid server!")
  	  	  status_line.style(stroke: red, align: "center", size: 18)
  	  	end
  	  end
  	end


  	heading2 = para "Enter summoner's names, you can enter up to 5 names:"
  	heading2.style(stroke: white, margin_top: 10)

    @@text_line = edit_line width: 450, margin_left: 8, margin_top: 10
    

    flow margin_left: 90, margin_top: 30 do 

      button " Search " do
        window width: 600, height: 600, title: "Lol-status" do
          background gainsboro
          name = @@text_line.text
          name = name.gsub(/\s+/, '').split(',').first(5)
          debug(name)

          @@platform_id.replace(@@region)
          @@platform_id << "1"
          debug("platform id is #{@@platform_id}")
          debug("region is #{@@region}")

          stack margin_top: 10 do
            p1 = para "In game status: "
            p1.style(weight: "strong", size: 18, align: "center")
            p2 = para "Will check again every 3 minutes"
            p2.style(emphasis: "oblique", align: "center")
          end

          @p = progress width: 0.9, margin_left: 50
          
          @animate = animate(1) do |i|
            @p.fraction = ((i % 180) / 180.0)
          end

          @@n0 = ""
          @@n1 = ""
          @@n2 = ""
          @@n3 = ""
          @@n4 = ""

          @@l0 = ""
          @@l1 = ""
          @@l2 = ""
          @@l3 = ""
          @@l4 = ""

          @@t0 = ""
          @@t1 = ""
          @@t2 = ""
          @@t3 = ""
          @@t4 = ""
          

          @@link_array = [@@l0, @@l1, @@l2, @@l3, @@l4]
          @@t_array = [@@t0, @@t1, @@t2, @@t3, @@t4]
          
          name.each_with_index do |summoner, index|
            status = GetStatus.new(summoner, @@platform_id)
            sname = status.sum_name
            g_status = status.game_status

            debug("s name is #{sname}")

            if sname != nil
              @@link_array[index] = "View Profile"
            else
              @@link_array[index] = ""
            end

            if g_status == true
              @@t_array[index] = "View Matchup"
            else
              @@t_array[index] = ""
            end
          end


          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p0 = para ""
            para (link(@@link_array[0]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n0}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n0}")
            end)
            para (link(@@t_array[0]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n0}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n0}&region=#{@@region}")
            end)
          end

          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p1 = para ""
            para (link(@@link_array[1]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n1}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n1}")
            end)
            para (link(@@t_array[1]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n1}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n1}&region=#{@@region}")
            end)
          end
          
          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p2 = para ""
            para (link(@@link_array[2]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n2}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n2}")
            end)
            para (link(@@t_array[2]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n2}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n2}&region=#{@@region}")
            end)
          end

          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p3 = para ""
            para (link(@@link_array[3]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n3}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n3}")
            end)
            para (link(@@t_array[3]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n3}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n3}&region=#{@@region}")
            end)
          end

          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p4 = para ""
            para (link(@@link_array[4]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n4}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n4}")
            end)
            para (link(@@t_array[4]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n0}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n4}&region=#{@@region}")
            end)
          end


          @@para_array = [@@p0, @@p1, @@p2, @@p3, @@p4]
          @@name_array = [@@n0, @@n1, @@n2, @@n3, @@n4]


          name.each_with_index do |summoner, index|
            status = GetStatus.new(summoner, @@platform_id)
            sname = status.sum_name
            champ = status.champ_name
            valid_name = status.name_status
            valid_game = status.game_status
            game_length = status.game_length

            if valid_name 
              if valid_game
                  @@para_array[index].replace("#{sname} is in a game, playing #{champ} for #{game_length} minutes!\n")
                  @@name_array[index].replace(summoner)
                  debug(@@name_array[index])
              else
                  @@para_array[index].replace("#{sname} is not currently in a game.\n")
                  @@name_array[index].replace(summoner)
                  debug(@@name_array[index])    
              end
            else
                @@para_array[index].replace("Can not find summoner with this name: #{summoner}.\n")
            end
          end


          every(180) do
            name.each_with_index do |summoner, index|
              status = GetStatus.new(summoner, @@platform_id)
              sname = status.sum_name
              champ = status.champ_name
              valid_name = status.name_status
              valid_game = status.game_status
              game_length = status.game_length

              if valid_name 
                if valid_game
                    @@para_array[index].replace("#{sname} is in a game, playing #{champ} for #{game_length} minutes!\n")
                    @@name_array[index].replace(summoner)    
                else
                    @@para_array[index].replace("#{sname} is not currently in a game.\n")
                    @@name_array[index].replace(summoner)   
                end
              else
                  @@para_array[index].replace("Can not find summoner with this name: #{summoner}.\n")
              end
            end
          end

        end
      end

      button "  Save  " do
          debug(" names are #{@@text_line.text}")
          save_as = ask_save_file
          input = [@@region, @@text_line.text]
          File.open(save_as, 'w') do |file|
            file.puts input.join(',')
          end

          @@save_message.replace("File is saved!")
          timer(8) do
            @@save_message.replace("")
          end
      end
      
      button "  Load  " do
        load_file = ask_open_file
        @@game_data = File.open(load_file, 'r') do |file| 
          file.read 
        end

        @@game_data = @@game_data.split(',')
        @@region = @@game_data[0]

        window width: 600, height: 600, title: "Lol-status" do
          background gainsboro
          name = @@game_data[1..-1].join(',')
          name = name.gsub(/\s+/, '').split(',').first(5)
          debug(name)

          @@platform_id.replace(@@region)
          @@platform_id << "1"
          debug("platform id is #{@@platform_id}")
          debug("region is #{@@region}")

          stack margin_top: 10 do
            p1 = para "In game status: "
            p1.style(weight: "strong", size: 18, align: "center")
            p2 = para "Will check again every 3 minutes"
            p2.style(emphasis: "oblique", align: "center")
          end

          @p = progress width: 0.9, margin_left: 50
          
          @animate = animate(1) do |i|
            @p.fraction = ((i % 180) / 180.0)
          end

          @@n0 = ""
          @@n1 = ""
          @@n2 = ""
          @@n3 = ""
          @@n4 = ""

          @@l0 = ""
          @@l1 = ""
          @@l2 = ""
          @@l3 = ""
          @@l4 = ""

          @@t0 = ""
          @@t1 = ""
          @@t2 = ""
          @@t3 = ""
          @@t4 = ""
          

          @@link_array = [@@l0, @@l1, @@l2, @@l3, @@l4]
          @@t_array = [@@t0, @@t1, @@t2, @@t3, @@t4]
          
          name.each_with_index do |summoner, index|
            status = GetStatus.new(summoner, @@platform_id)
            sname = status.sum_name
            g_status = status.game_status

            debug("s name is #{sname}")

            if sname != nil
              @@link_array[index] = "View Profile"
            else
              @@link_array[index] = ""
            end

            if g_status == true
              @@t_array[index] = "View Matchup"
            else
              @@t_array[index] = ""
            end
          end


          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p0 = para ""
            para (link(@@link_array[0]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n0}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n0}")
            end)
            para (link(@@t_array[0]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n0}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n0}&region=#{@@region}")
            end)
          end

          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p1 = para ""
            para (link(@@link_array[1]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n1}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n1}")
            end)
            para (link(@@t_array[1]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n1}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n1}&region=#{@@region}")
            end)
          end
          
          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p2 = para ""
            para (link(@@link_array[2]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n2}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n2}")
            end)
            para (link(@@t_array[2]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n2}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n2}&region=#{@@region}")
            end)
          end

          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p3 = para ""
            para (link(@@link_array[3]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n3}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n3}")
            end)
            para (link(@@t_array[3]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n3}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n3}&region=#{@@region}")
            end)
          end

          flow margin_top: 15, margin: 10, height: 80  do
            background white
            @@p4 = para ""
            para (link(@@link_array[4]).click do
              #system("start http://#{@@region}.op.gg/summoner/userName=#{@@n4}")
              system("open", "http://#{@@region}.op.gg/summoner/userName=#{@@n4}")
            end)
            para (link(@@t_array[4]).click do
              #system("start "http://www.lolnexus.com/#{@@region}/search?name=#{@@n0}&region=#{@@region}")
              system("open", "http://www.lolnexus.com/#{@@region}/search?name=#{@@n4}&region=#{@@region}")
            end)
          end


          @@para_array = [@@p0, @@p1, @@p2, @@p3, @@p4]
          @@name_array = [@@n0, @@n1, @@n2, @@n3, @@n4]


          name.each_with_index do |summoner, index|
            status = GetStatus.new(summoner, @@platform_id)
            sname = status.sum_name
            champ = status.champ_name
            valid_name = status.name_status
            valid_game = status.game_status
            game_length = status.game_length

            if valid_name 
              if valid_game
                  @@para_array[index].replace("#{sname} is in a game, playing #{champ} for #{game_length} minutes!\n")
                  @@name_array[index].replace(summoner)
                  debug(@@name_array[index])
              else
                  @@para_array[index].replace("#{sname} is not currently in a game.\n")
                  @@name_array[index].replace(summoner)
                  debug(@@name_array[index])    
              end
            else
                @@para_array[index].replace("Can not find summoner with this name: #{summoner}.\n")
            end
          end


          every(180) do
            name.each_with_index do |summoner, index|
              status = GetStatus.new(summoner, @@platform_id)
              sname = status.sum_name
              champ = status.champ_name
              valid_name = status.name_status
              valid_game = status.game_status
              game_length = status.game_length

              if valid_name 
                if valid_game
                    @@para_array[index].replace("#{sname} is in a game, playing #{champ} for #{game_length} minutes!\n")
                    @@name_array[index].replace(summoner)    
                else
                    @@para_array[index].replace("#{sname} is not currently in a game.\n")
                    @@name_array[index].replace(summoner)   
                end
              else
                  @@para_array[index].replace("Can not find summoner with this name: #{summoner}.\n")
              end
            end
          end

          @@save_message.replace("File is loaded!")
          timer(8) do
            @@save_message.replace("")
          end

         end
        
      end

    end

    stack margin_top: 50 do
      @@save_message = para ""
      @@save_message.style(stroke: white, align: "center")
    end

    stack margin_top: 20, margin_left: 210 do
      para (link("About").click do
        
      end)
    end

  end
end