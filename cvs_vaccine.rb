# cvs vaccination checker
require 'watir'
require 'webdrivers'
require 'win32/sound'
include Win32

state = '' # eg. 'New Jersey'
town = '' # This has to match a town name on the CVS site, eg. 'Edison'
days_to_run = 7
stop_at_this_date = Time.now + (60 * 60 * 24 * days_to_run)
puts "CVS vaccination availabilities script running until #{stop_at_this_date}"

if state.empty?
  print 'Enter state (eg. New Jersey): '
  state = gets.chomp
end

if town.empty?
  print 'Enter town (This has to match a town name on the CVS site, eg. Edison): '
  town = gets.chomp
end

b = Watir::Browser.new

until (Time.now > stop_at_this_date)
  b.goto 'https://www.cvs.com/immunizations/covid-19-vaccine'

  b.wait_until { b.link(text: state).present? }
  b.link(class: 'acsCloseButton').click if b.link(class: 'acsCloseButton').present?
  b.link(text: state).click
  b.wait_until { b.div(class: 'modal--active').present? }
  town_index = b.div(class: 'modal--active').div(class: 'covid-status').trs.find_index { |row| row.text.include? town }
  if !b.div(class: 'modal--active').div(class: 'covid-status').trs[town_index].text.include? 'Fully Booked'
    Sound.beep(1200, 5000)
    break
  end
  puts "Last checked on: #{Time.now}"
  sleep rand(60..80)
end
