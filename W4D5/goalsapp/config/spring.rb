%w[
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
].each { |path| Spring.watch(path) }

# hah that's some awesome ruby code love this shit and so lucky to get to understand it all
# nothing magical in this world amazing to get to peel the curtain back on everything can't fucking wait