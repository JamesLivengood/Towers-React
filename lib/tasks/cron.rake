namespace :cron do
    desc 'Send pending broadcasts'
    task :send_broadcast => :environment do
        puts 'Checking for next broadcast'
        broadcast = Broadcast.where("send_at < NOW() AND sent_at IS NULL").order(:send_at).limit(1).first
        if broadcast
            puts "Delivering broadcast with subject #{broadcast.subject}"
            Broadcasts::Deliver.run(broadcast)
        else
            puts "No broadcast to be delivered!"
        end
    end
end