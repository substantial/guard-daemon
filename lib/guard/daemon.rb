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
      pids_to_kill = [@pid]
      # find pid with its parent if any
      rows = `ps -eo pid,ppid | grep #{@pid}`.split("\n")
      rows.each do |row|
        pids = row.split(' ')
        if pids[1] == @pid.to_s
          pids_to_kill << pids[0]
        end
      end
      daemon_logger "stopping"
      `kill #{pids_to_kill.join(' ')}`
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
