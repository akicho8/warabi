# -*- coding: utf-8; compile-command: "bundle exec rspec ../../spec/ki2_format_spec.rb" -*-

module Bushido
  module Ki2Format
    class Parser < KifFormat::Parser
      def parse
        @_head, @_body = @source.split(/\n\n/, 2)
        read_header
        @_body.lines.each do |line|
          comment_read(line)
          if line.match(/^\s*[▲△]/)
            line.scan(/[▲△]([^▲△\s]+)/).flatten.each{|input|
              @move_infos << {:input => input}
            }
          end
        end
      end
    end

    module Soldier
    end

    module Board
    end
  end
end