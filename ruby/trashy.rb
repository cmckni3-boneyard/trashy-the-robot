require 'net/smtp'
require 'time'
require 'yaml'

class Trashy
  @message = nil
  def init
    @email_config = YAML.load_file('conf.yml')
    @message = File.read("email.txt")
    @receivers = @email_config["email"]["receivers"].split(',')
  end
  
  def send_email
    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    
    smtp.start(Socket.gethostname,@email_config["gmail_credentials"]["gmail_username"],@email_config["gmail_credentials"]["gmail_password"],:login) do |server|
       @receivers.each {|receiver|
       server.send_message @message, @email_config["email"]["sender"], receiver
       }
    end
  end
end