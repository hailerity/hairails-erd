module Hairails
  module Erd
    class Runner
      def self.invoke
        status = run(ARGV, $stderr, $stdout).to_i
        exit(status) if status != 0
      end

      def self.run(args, err=$stderr, out=$stdout)
        puts "Hello World"
      end
    end
  end
end
