# source: https://github.com/imathis/octopress/blob/master/Rakefile#L373-377

desc "List all Rake tasks, even those not exposed to rake -T"
task :list do
  puts "Tasks:\n  #{(Rake::Task.tasks - [Rake::Task[:list]]).join("\n  ")}"
  puts "(type rake -T for exposed tasks and their usage)\n\n"
end
