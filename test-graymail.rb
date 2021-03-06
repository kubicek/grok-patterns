#!/usr/bin/ruby1.9.1
#

require "rubygems"
require "grok-pure"
require "pp"

grok = Grok.new
messages = Array.new

# Load some default patterns that ship with grok.
# See also: 
#   http://code.google.com/p/semicomplete/source/browse/grok/patterns/base
grok.add_patterns_from_file("default.grok")
grok.add_patterns_from_file("common.grok")
grok.add_patterns_from_file("graymail.grok")

messages.push("Nov 29 15:14:20 a.spam.sonic.net graymail: augie sent <0.0.1079908368.spx405e1810hss392.0@whenimawalkin.com> \"Truck\" <contact@whenimawalkin.com> to graymail")
messages.push("Nov 30 11:32:48 a.spam.sonic.net graymail: augie sent <0.1.A6.CE8.1CDCF3176314704.0@vmta-c-103.listrak.com> \"The Home Decorating Company\" <augie@schwer.us> to /dev/null for SpamAssassin Blacklists")
messages.push("Nov 30 11:42:23 a.spam.sonic.net graymail: augie sent <U[20 gtrjoea@docomo.ne.jp to graymail")
messages.push("Nov 30 11:45:12 a.spam.sonic.net graymail: augie sent 700419806.11110861281@souzafamily.com \"Augie Schwer\" <augie@schwer.us> to graymail")
messages.push("Dec  4 09:00:49 d.spam.sonic.net graymail: augie sent <IEAOeIiGX00000037@champserver2k3.championgroups.net> to graymail")
messages.push("Dec  4 13:00:19 c.spam.sonic.net graymail: aae sent 20121204160010@irsAuctions.com Auctioneer@irsAuctions.com to /dev/null for SpamAssassin Blacklists")

pattern = "%{GRAYMAIL}"
grok.compile(pattern)
grok.compile(pattern)

messages.each do |message|
	match = grok.match(message)
	unless match
		puts 'FAIL: the following message did not match any pattern'
		puts message
	end
#	pp match.captures
end
puts 'All tests complete'
