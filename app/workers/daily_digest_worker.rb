class DailyDigestWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 2

  def perform

    network_logs_in_past_day = []
    Network.find_each do |network| 
      network_logs = NetworkService.new
      logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
      unless logs.empty?
        network_logs_in_past_day << logs
      end
    end

    coin_logs_in_past_day = []
    Coin.find_each do |coin| 
      coin_logs = NetworkService.new
      logs = coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
      unless logs.empty?
        coin_logs_in_past_day << logs
      end
    end

=begin    
    @user = User.all.each do |user|
=end
    user = User.first
      networks_following = []
      coins_following = []

      user.all_follows.each do |follow|
        if follow.followable_type == "Network"
          networks_following << Network.find(follow.followable_id)
        else 
          coins_following << Coin.find(follow.followable_id)
        end
      end

      @network_logs = network_logs_in_past_day.select do |network|
        networks_following.index network.first.networks
      end

      @coin_logs = coin_logs_in_past_day.select do |coin|
        coins_following.index coin.first.coins
      end

      unless @network_logs.count + @coin_logs.count == 0
        UserMailer.daily_digest(user, @network_logs, @coin_logs).deliver_now
      end
=begin
  	end
=end
  
  end

  DailyDigestWorker.perform_async
  
end
