require 'mechanize'
require 'nokogiri'
require 'csv'
require 'nkf'

agent = Mechanize.new
agent.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36'
#agent.set_proxy('proxy.example.com',8080)

agent.get('https://mixi.jp') do |page|

  login_result = page.form_with(name: 'login_form') do |login|
    login['email'] = "mail" 
    login['password'] = "pass"
  end.submit

end

agent.get('http://mixi.jp/home.pl') do |page|
  html  = Nokogiri::HTML(page.body)
    html.css('.feedContent').each do |div|
      puts NKF.nkf('-w',div)
    end
end

