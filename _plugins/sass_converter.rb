# source: https://gist.github.com/3125738

module Jekyll
  # Sass plugin to convert .scss to .css
  # 
  # Note: This is configured to use the new css like syntax available in sass.
  class SassConverter < Converter
    safe true
    priority :low

    def setup
      return if @setup
      require 'sass'
      @setup = true
    rescue LoadError
      STDERR.puts 'You are missing a library required for sass. Please run:'
      STDERR.puts '  $ [sudo] gem install sass'
      raise FatalException.new("Missing dependency: sass")
    end

     def matches(ext)
      ext =~ /scss|sass/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      setup
      begin
        puts "Performing Sass Conversion."
        engine = Sass::Engine.new(content, :syntax => :scss, :load_paths => ["./assets/themes/*/css/"], :style => :compressed)
        engine.render
      rescue => e
        puts "Sass Exception: #{e.message}"
      end
    end
  end
end
