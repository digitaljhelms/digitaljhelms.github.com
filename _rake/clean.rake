# source: https://github.com/imathis/octopress/blob/master/Rakefile#L168-171

namespace :clean do
  desc "Cleans out generated caches only"
  task :cache do
    puts "Taking out the garbage"
    rm_rf [".pygments-cache", ".gist-cache", ".sass-cache"]
  end

  desc "Deletes generated site files"
  task :site do
    puts "Taking out the garbage"
    rm_rf ["_site"]
  end

  task :all do
    Rake::Task["clean:cache"].execute
    Rake::Task["clean:site"].execute
  end
end

desc "Deletes generated site files and cleans out caches"
task :clean => "clean:all"
