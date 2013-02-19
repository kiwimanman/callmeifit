FactoryGirl.define do
  factory :ski_resort do
    address_line1 "Summit Stevens Pass, US Hwy 2"
    address_location "Skykomish, WA 98288"
    website "http://www.stevenspass.com/"
    image_url "http://www.stevenspass.com/Stevens/SiteBase/wrap/theme2/images/logo.png"
    webcam_url "http://www.stevenspass.com/Stevens/SiteAssets/_ftp/webcam/stevenspass.jpg"
    scrape_url "http://www.stevenspass.com/Stevens/snowreport.aspx"
    scrape_selector '#cmtContent table:nth-of-type(2) tr:nth-of-type(3) td:last-child'
    scrape_regex '^(?<value>\d+)'
    value 10
  end
end