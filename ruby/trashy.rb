require './gmail_credentials.rb'
require './conf.rb'
require 'net/smtp'
require 'time'

class Trashy
  @message = nil
  def init
    @message = File.read("email.txt")
    $receivers = $receivers.split(',')
  end
  
  def send_email
    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls

    smtp.start(Socket.gethostname,$gmail_username,$gmail_password,:login) do |server|
       $receivers.each {|receiver|
       server.send_message @message, $sender, receiver
       }
    end
  end
end