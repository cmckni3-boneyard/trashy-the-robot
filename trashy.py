import smtplib
import time, datetime
from email.mime.text import MIMEText

import conf
import gmail_credentials

SECOND= 1
MINUTE= 60*SECOND
HOUR= 60*MINUTE

while True:
	time=datetime.datetime.utcfromtimestamp(time.time())

	#we check at 4am on Wednesday because time is UTC!!
	if (time.weekday()==3 and time.hour==4):
		# Open a plain text file for reading.  For this example, assume that
		# the text file contains only ASCII characters.
		textfile= "email.txt"
		fp = open(textfile, 'rb')
		# Create a text/plain message
		msg = MIMEText(fp.read())
		fp.close()

		sender = conf.sender
		receivers = conf.receivers

		msg['Subject'] = 'Reminder from Trashy, the trash robot'
		msg['From'] = sender
		msg['To'] = receivers

		# Send the message via our own SMTP server, but don't include the
		# envelope header.
		s = smtplib.SMTP('smtp.gmail.com:587')
		s.starttls()  
		s.login(gmail_credentials.GMAIL_LOGIN, gmail_credentials.GMAIL_PASS) #defined in gmail_credentials.py
		
		for r in receivers:
			s.sendmail(sender, r, msg.as_string())
		s.quit()
	
	else :
		time.sleep(30*MINUTE)