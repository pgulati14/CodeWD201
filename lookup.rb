def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")
# FILL YOUR CODE HERE.
def parse_dns(dns_raw)
  dns_raw.reject { |x| (x[0] == "#") || (x[0] == "\n") }.
    map { |x| x.strip().split(", ") }.
    each_with_object({}) do |record, records|
    records[record[1]] = { type: record[0], target: record[2] }
  end

end
#def parse_dns(raw)
 # init=raw.
  #reject {|line| line.empty? }.
  #map {|line| line.strip.split(", ") }
  #init = init.map(&:strip)
  #init = init.reject { |line| line.empty? }
  #init = init.reject { |line| line.start_with?("#") }
  #init = init.reject { |line| line.start_with?("$") }
  #arr = init.map { |line| line.strip.split(", ") }
  #each_with_object({}) do |record, records|
   # records[record[1]] = { type: record[0], target: record[2] } end
  #arr = init.reject { |record| record.length!= 3 }
  #dns_records = arr.each_with_object({}) do |record, records| records[record[1]] =
   # { type: record.first, target: record.last } end
   # dns_records

def resolve(dns_records, lookup_chain, domain)
  record = dns_records[domain]
  #rec = dns_records.fetch(domain, nil)
  if (!record)
    lookup_chain << "Error: record not found for #{domain}"
  elsif record[:type] == "A"
    lookup_chain << record[:target]
  elsif record[:type] == "CNAME"
    lookup_chain << record[:target]
    resolve(dns_records, lookup_chain, record[:target])
  end
end
# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
