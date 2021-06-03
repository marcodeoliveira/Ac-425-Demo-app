import socket
import mysql.connector
import time
import datetime
from datetime import date

# Socket handling
TCP_IP = '192.168.1.1' #AC-425 address
TCP_PORT = 11001 #AC-425 port
BUFFER_SIZE = 1024 #Delimiter for package sizes to avoid network congestion
REPLY = '0003WDG' #standard AC-425 alive repply...

# Open socket, send message, close socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((TCP_IP, TCP_PORT))
s.send('0015AIV00051.mp4000'.encode())

# Open SQL connection
mydb = mysql.connector.connect(
  host="localhost",
  user="user",
  password="pass1234",
  database="ac425"
)
cur = mydb.cursor()

# Watchdog loop!
while True:
    data = s.recv(BUFFER_SIZE)
    if (data.decode()) == REPLY :
        print (data.decode())
        s.send('0013FIL0006BDGWDG'.encode()) # Invoke watchdog for badge reader everytime the alive repply is heard

    if (data.decode()) != REPLY :
        badge_number = data.decode().replace('0018BDG100100', '') # Removes the leading chars on the badge id reply
        sql = "SELECT * FROM badges WHERE number = '%s'" % (badge_number)
        cur.execute(sql)
        row = cur.fetchone()
        # Badge not found!
        if row == None :
            s.send('0028AFM0002G0016BADGE NOT FOUND!'.encode())
            s.send('0035AFM0004M0023PLEASE USE THE INTERCOM'.encode())
            s.send('0021AFM0005M0009TO REPORT'.encode())
            time.sleep(4)
            s.send('0007RZE|01|'.encode())
            s.send('0015AIV00051.mp4000'.encode()) # Invoke the video 1.mp4
        # Badge found
        else :
            # Check expiry date
            today = date.today()
            d1 = row[4].strftime("%Y-%m-%d")
            d2 = today.strftime("%Y-%m-%d")
            if d2 < d1 :
                # All good with badge routine
                s.send('0019AFM0002G0007WELCOME'.encode())
                # Making the personalized name string message
                x = len(row[2])
                x = str(x)
                x = x.zfill(4)
                message = 'AFM0003G' + x + row[2]
                x = len(message)
                x = str(x)
                x = x.zfill(4)
                message = x + message
                s.send(message.encode())
                s.send('0031AFM0005M0019PLEASE DRIVE SAFELY'.encode())
                time.sleep(4)
                # Additional Message for other passengers
                s.send('0007RZE|01|'.encode()) # Clear screen
                s.send('0027AFM0002G0015PLEASE SCAN ANY'.encode())
                s.send('0027AFM0003G0015OTHER PASSENGER'.encode())
                s.send('0026AFM0004G0014IN THE VEHICLE'.encode())
                s.send('0011TIC00019999'.encode()) # Set output 1 to ON state for 9.999s
                time.sleep(4)
                s.send('0007RZE|01|'.encode())
                s.send('0015AIV00051.mp4000'.encode())
            else :
                # Expired badge routine
                s.send('0033AFM0002G0021YOUR CARD IS EXPIRED!'.encode())
                s.send('0035AFM0004M0023PLEASE USE THE INTERCOM'.encode())
                s.send('0021AFM0005M0009TO REPORT'.encode())
                time.sleep(4)
                s.send('0007RZE|01|'.encode())
                s.send('0015AIV00051.mp4000'.encode())
    mydb.commit()
s.close()
"""

||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
   |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||  
     |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||      
        |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||         
          |||||||||||||||                           ||||||||||||||||            
             |||||||||||||||                    |||||||||||||||||               
               |||||||||||||||               ||||||||||||||||                   
                  |||||||||||||||         ||||||||||||||||                      
                     ||||||||||||||    ||||||||||||||||                         
                      |||||||||||||||||||||||||||||                            
Precia Molen NZ LTD     |||||||||||||||||||||||                               
Marco DE OLIVEIRA          ||||||||||||||||||                                  
2021                           |||||||||||                                      
                                 ||||||                                         

"""
