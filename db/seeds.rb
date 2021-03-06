# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Ski Resorts:

resort = SkiResort.find_or_create_by(name: "Stevens Pass")
resort.address_line1 = "Summit Stevens Pass, US Hwy 2"
resort.address_location = "Skykomish, WA 98288"
resort.website = "http://www.stevenspass.com/"
resort.image_url = "http://www.stevenspass.com/Stevens/SiteBase/wrap/theme2/images/logo.png"
resort.webcam_url = "http://www.stevenspass.com/cams/base1"
resort.scrape_url = "http://www.stevenspass.com/Stevens/snowreport.aspx"
resort.scrape_selector = "#cmtContent table:nth-of-type(2) tr:nth-of-type(3) td:last-child"
resort.scrape_regex = '^(?<value>\d+)'
resort.save

resort = SkiResort.find_or_create_by(name: "Crystal Mountain")
resort.address_line1 = "33914 Crystal Mountain Blvd"
resort.address_location = "Snoqualmie National Forest, Enumclaw, WA 98022"
resort.website = "http://crystalmountainresort.com/"
resort.image_url = "http://www.outdoorsforall.org/images/Logos/Logo_Crystal.jpg"
resort.webcam_url = "http://crystalmountainresort.com/images/webcams/cmsnowcam2.jpg"
resort.scrape_url = "http://crystalmountainresort.com/The-Mountain/mountain_report"
resort.scrape_selector = "#weather-conditions2 div:nth-of-type(3) div:nth-of-type(2) tr:first-child .standard"
resort.scrape_regex = '^(?<value>\d+)'
resort.save

resort = SkiResort.find_or_create_by(name: "Whistler Blackcomb")
resort.address_line1    = "4545 Blackcomb Way"
resort.address_location = "Whistler, B.C. V0N 1B4"
resort.website          = "http://www.whistlerblackcomb.com/"
resort.image_url        = "http://www.whistlerblackcomb.com/media/whistler/whistler-logo.png"
resort.webcam_url       = "http://snow.whistler-blackcomb.com/peakcam/1rhl.jpg"
resort.scrape_url       = "http://www.onthesnow.com/british-columbia/whistler-blackcomb/skireport.html"
resort.scrape_selector  = ".snow_table .today .white_pill"
resort.scrape_regex     = '^(?<value>\d+)'
resort.save

resort = SkiResort.find_or_create_by(name: "49 Degrees North")
resort.address_line1    = "3311 Flowery Trail Rd"
resort.address_location = "Chewelah, WA 99109"
resort.website          = "http://www.ski49n.com/"
resort.image_url        = nil
resort.webcam_url       = "http://www.ski49n.com/webcam/image.jpg"
resort.scrape_url       = "http://www.ski49n.com/"
resort.scrape_selector  = "body div table tbody tr td table:nth-of-type(2) tbody tr:nth-of-type(1) td:nth-of-type(2) div span:nth-of-type(3) div:nth-of-type(1) table:nth-of-type(2) tbody tr td.nth-of-type(1)table tbody tr:nth-of-type(2) td table tbody tr:nth-of-type(3) td:nth-of-type(2) span"
resort.scrape_regex     = '^(?<value>\d+)'
resort.save
