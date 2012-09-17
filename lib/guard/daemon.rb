require 'guard'
require 'guard/guard'
require 'rainbow'

module Guard

  class Daemon < Guard

    def start
      daemon_restart
    end

    def run_on_changes(paths)
      daemon_restart
    end

    def stop
      daemon_stop
    end

    def daemon_restart
      daemon_stop
      daemon_start
    end

    def daemon_stop
      return unless @pid
      rows = `ps -eo pid,ppid | grep #{@pid}`.split("\n")
      rows.each do |row|
        pids = row.split(' ')
        if pids[1] == @pid.to_s
          daemon_logger 'stopping #{@pid}'
          `kill -9 #{pids[0]}`
        end
      end
    end

    def daemon_start
      @pid = fork do
        cmd = @options[:command]
        daemon_logger "starting with '#{cmd}'"
        exec cmd
      end
      daemon_logger "made pid #{@pid}"
    end

    def daemon_logger(msg)
      name = @options[:name]
      output = "DAEMON".color(:yellow)
      output << "[" + name.color(:blue) + "]"
      output << " #{msg}"
      puts output
    end

  end

end
