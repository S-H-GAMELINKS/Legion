require "legion/version"
require "legion/mastodon"
require "legion/legion"

module Legion
  def self.exec
    LegionLoop()
  end
end
