module Hairails
  module Erd
    class Runner
      def self.invoke
        status = run(ARGV, $stderr, $stdout).to_i
        exit(status) if status != 0
      end

      def self.run(args, err=$stderr, out=$stdout)
        svg_path = args[0]
        models = SvgParser.new(svg_path).parse

        # TODO: Handle abnormal class
        models.select{|name, model|
          name.to_s.match /^\w+$/
        }.each do |name, model|
          ModelGenerator.new(model).generate
        end

        0
      end
    end
  end
end
