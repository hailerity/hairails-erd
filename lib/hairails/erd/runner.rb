require 'json'

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

        # Convert to array, not using hash
        models = models.values

        # Select good models
        # TODO: Handle abnormal class
        models.reject!{|model|
          not model.name.to_s.match(/^\w+$/)
        }

        # Let's do a bubble sort to sastify model's dependencies
        0.upto models.count - 2 do |i|
          (i + 1).upto models.count - 1 do |j|
            if models[i].fields.detect{|k, v|
              v == 'ref' and k.capitalize == models[j].name
            } then
              models[i], models[j] = models[j], models[i]
            end
          end
        end

        show_models models

        # Now generate models
        models.each do |model|
          ModelGenerator.new(model).generate
        end

        0
      end

      def self.show_models models
        models.each do |model|
          puts model.name

          model.fields.each do |k, v|
            puts "  #{k}:#{v}"
          end

          puts ''
        end
      end

    end
  end
end
