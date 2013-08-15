require 'colored'
require 'open-uri'
require 'cgi'

# Start the server up
fork do
  system 'bundle exec rackup'
end

# Wait till the server is up
loop do
  begin
    open('http://localhost:9393')
  rescue
    sleep 1
  end
  break
end

def test(term)
  body = open("http://localhost:9393/#{CGI.escape term}").read
  body.include?("Couldn't find") ? puts("NOT COOL: #{term.inspect}".bold.red) : puts("#{term.inspect} is FIIIIIINE".green)
end

##
# THE ACTUAL TESTS
if ARGV.empty?
  # Run the default tests
  test "vh1 classic"
  test "mtv jams"
  test "hbo"
  test "fake channel"
else
  # Test the channel passed as an argument
  test ARGV.first
end
#
##

# Shut it down
pid = `ps aux | grep rackup | grep -v grep`.split(/\s+/)[1]
Process.kill "KILL", pid.to_i
