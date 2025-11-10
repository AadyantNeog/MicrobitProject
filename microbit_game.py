from microbit import *
import random
display.scroll("press A or B")
while True:
    if button_a.is_pressed():
        used=[[0,1],[0,3],[1,0],[1,1],[1,2],[1,3],[1,4],[2,1],[2,3],[3,0],[3,1],[3,2],[3,3],[3,4],[4,1],[4,3]]
        player1=[]
        player2=[]
        display.set_pixel(0,1,5)
        display.set_pixel(0,3,5)
        display.set_pixel(1,0,5)
        display.set_pixel(1,1,5)
        display.set_pixel(1,2,5)
        display.set_pixel(1,3,5)
        display.set_pixel(1,4,5)
        display.set_pixel(2,1,5)
        display.set_pixel(2,3,5)
        display.set_pixel(3,0,5)
        display.set_pixel(3,1,5)
        display.set_pixel(3,2,5)
        display.set_pixel(3,3,5)
        display.set_pixel(3,4,5)
        display.set_pixel(4,1,5)
        display.set_pixel(4,3,5)
        x=1
        y=1
        playernow=1
        while True:
            if x>4: x=4
            if x<0: x=0
            if y>4: y=4
            if y<0: y=0
            x=x+accelerometer.get_x()//400
            y=y+accelerometer.get_y()//400
            if x>4: x=4
            if x<0: x=0
            if y>4: y=4
            if y<0: y=0
            display.clear()
            for u in used:
                display.set_pixel(u[0],u[1],5)
            for p in player1:
                display.set_pixel(p[0],p[1],9)
            for p in player2:
                display.set_pixel(p[0],p[1],1)
            display.set_pixel(x,y,5)

            if playernow==1:
                if button_a.is_pressed() and [x,y] not in used:
                    display.set_pixel(x,y,6)
                    player1.append([x,y])
                    used.append([x,y])
                    row=0
                    col=0
                    diag1=0
                    diag2=0
                    for p in player1:
                        if p[0]==x:
                            row+=1
                        if p[1]==y:
                            col+=1
                        if p[0]==p[1]:
                            diag1+=1
                        if p[0]+p[1]==4:
                            diag2+=1
                    if row>=3 or col>=3 or diag1>=3 or diag2>=3:
                        display.scroll("P1 wins")
                        break
                    playernow=0

            elif playernow == 0:
                if button_b.is_pressed() and [x,y] not in used:
                    display.set_pixel(x,y,2)
                    player2.append([x,y])
                    used.append([x,y])
                    # Check win
                    row=0
                    col=0
                    diag1=0
                    diag2=0
                    for p in player2:
                        if p[0]==x:
                            row +=1
                        if p[1]==y:
                            col +=1
                        if p[0]==p[1]:
                            diag1 +=1
                        if p[0]+p[1]==4:
                            diag2 +=1
                    if row>=3 or col>=3 or diag1>=3 or diag2>=3:
                        display.scroll("P2 wins")
                        break
                    playernow=1
            if len(used)>=25:
                display.scroll("DRAW")
                break

            sleep(300)


    if button_b.is_pressed():
        xinitial=0
        xtarget=random.randint(0,4)
        yinitial=0
        ytarget=random.randint(0,4)
        points=0
        finishtime=running_time()+30000
        while running_time()<=finishtime:
            x=accelerometer.get_x()//195+xinitial
            y=accelerometer.get_y()//195+yinitial
            if x>4:
                x=4
            if y>4:
                y=4
            if y<0:
                y=0
            if x<0:
                x=0
            display.set_pixel(x,y,9)
            display.set_pixel(xtarget,ytarget,5)
            if button_a.is_pressed() and x==xtarget and y==ytarget:
               points+=1
               xtarget=random.randint(0,4)
               ytarget=random.randint(0,4)
            display.clear()
        q=str(points)
        display.scroll("POINT: "+q)