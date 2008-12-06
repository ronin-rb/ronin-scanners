require 'ronin/scanners/nmap/nmap_task'

require 'rprogram/program'

module Ronin
  module Scanners
    class Nmap < RProgram::Program

      name_program 'nmap'

      def scan(options={},&block)
        run_task(NmapTask.new(options,&block))
      end

    end
  end
end
