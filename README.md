# CVS Vaccination Availability
Checks CVS every minute for available slots in your state/town and beeps if it's available

## Prereqs

Windows (haven't used OS X or any other OS since this uses win32-sound to alert)
Ruby 2.2.0 or higher

## Setup

In the root of this project:
```
gem install bundler
bundle install
```

## Usage

In the root of this project:
```
ruby cvs_vaccine.rb
```

## Notes

You can enter your state and town info directly into cvs_vaccine.rb if you don't want to have to keep typing it in each time
