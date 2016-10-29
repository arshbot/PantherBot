# start the service with `god -c /etc/god/god.conf`. Use `rvmsudo` if you
# manage your rubies with RVM.

# You can see the start/stop script for Hubot at: https://gist.github.com/1394520

God.watch do |w|
  w.name = "PantherBot"
  w.start = "/home/harshagoli/PantherBot/Pantherbot.sh start"
  w.stop = "/home/harshagoli/PantherBot/Pantherbot.sh stop"
  w.restart = "/home/harshagoli/PantherBot/Pantherbot.sh restart"
  w.start_grace = 5.seconds
  w.restart_grace = 5.seconds
  w.pid_file = "/var/run/hubot.pid"
  w.log = '/var/log/hubot/hubot.log'

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
