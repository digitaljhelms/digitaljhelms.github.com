# source: https://github.com/imathis/octopress/blob/master/Rakefile#L168-171

desc "Deletes generated site files and cleans out caches"
task :clean do
  puts "Taking out the garbage"
  rm_rf [".pygments-cache", ".gist-cache", ".sass-cache", "_site"]
end
