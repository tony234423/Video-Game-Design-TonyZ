public class entity {
  public int damage,health,facingx,facingy,immunity,maxHealth,money,attackCooldown;//money refers to the loot system
  public float xpos,ypos,movs,size,xmov,ymov,invincFrames;
  void move(){
    if(xpos-size/2<0&&xmov<0){
      xmov=0;
    }
    if(ypos-size/2<0&&ymov<0){
      ymov=0;
    }
    if(xpos+size/2>width&&xmov>0){
      xmov=0;
    }
    if(ypos+size/2>height&&ymov>0){
      ymov=0;
    }
    xpos+=movs*xmov;
    ypos+=movs*ymov;
    if(immunity>0){
      immunity-=1;
    }
    
    
  }
  void hit(int dam){
    if(immunity==0){
    health-=dam;
    immunity+=invincFrames;
  }
  }
  
}
public class player extends entity{
  
  
   int attackSpeed,reach;
  player(int h,float x ,float y,float m){
    health=h;
    xpos=x;
    ypos=y;
    movs=m;
    xmov=0;
    ymov=0;
    size=30;
    damage=20;
    facingx=1;
    facingy=0;
    immunity=0;
    invincFrames=60;
    attackCooldown=0;
    attackSpeed=15;
    reach=100;
    maxHealth=h;
    money=0;
  }
  void update(){
    if(attackCooldown==0){
    if(abs(mouseX-xpos)<abs(mouseY-ypos)){
      if(mouseY-ypos>0){
        facingy=1;
        facingx=0;
      }
      else{
        facingy=-1;
        facingx=0;
      }
    }
    else{
      if(mouseX-xpos>0){
        facingx=1;
        facingy=0;
      }
      else{
        facingx=-1;
        facingy=0;
      }
    }
    }
    else
    {
      imageMode(CORNER);
      if(facingy==1){
          
          if(reach==100){
            image(shortsword_back,xpos,ypos,20,reach);
            }
            else{
              image(longsword_back,xpos,ypos,20,reach);
            }
          
        }
        if(facingy==-1){
          
          if(reach==100){
            image(img_shortsword,xpos,ypos,20,-reach);
            }
            else{
              image(img_longsword,xpos,ypos,20,-reach);
            }
        }
        if(facingx==1){
          
          if(reach==100){
            image(img_shortsword_rotate,xpos,ypos,reach,20);
            }
            else{
              image(img_longsword_rotate,xpos,ypos,reach,20);
            }
        }
        if(facingx==-1){
          
          if(reach==100){
            image(shortsword_left,xpos,ypos,-reach,20);
            }
            else{
              image(longsword_left,xpos,ypos,-reach,20);
            }
        }
    }
    strokeWeight(3);
    fill(255);
    stroke(0);
    rectMode(CORNERS);
    rect(0,0,200,50);
    fill(255,0,0);

    rect(0,0,health*200/maxHealth,50);
    fill(0);
    textSize(25);
    textAlign(CENTER);
    text(health+"/"+maxHealth,100,25);
    //health bar chunk ^^^
    fill(0);
    noStroke();
    rectMode(CENTER);
    if(immunity>0){
      fill(255);
      stroke(0);
    }
    imageMode(CENTER);
    image(img_player,xpos,ypos,size,size);
    rectMode(CORNERS);
    if(health<=0){
      background(0);
      fill(255,0,0);
      textSize(200);
      text("Game Over",width/2,height/2);
      buttons[0].visib=true;
      
    }
      if(attackCooldown>0){
      attackCooldown-=1;
      }
}
  void attack(){
    if(attackCooldown==0&&!paused){
    ///strokeWeight(3);
    ///stroke(255,0,0);
    ///line(xpos+facingx*size/2,ypos+facingy*size/2,xpos+facingx*(size/2+reach),ypos+facingy*(size/2+reach));
    ///rectMode(CORNER);
    ///rect(xpos+facingx*size/2-5*(abs(facingx)-1),ypos+facingy*size/2-5*(abs(facingy)-1),xpos+facingx*(size/2+reach)+5*(abs(facingx)-1),ypos+facingy*(size/2+reach)+5*(abs(facingx)-1));
    attackCooldown+=attackSpeed;
    noStroke();
    imageMode(CORNER);
    
      for(enemy example:enemies[level]){
        if(example.inplay){
        if(facingy==1){
          if( abs(example.xpos-xpos)<example.size/2&&example.ypos>ypos+size/2&&ypos+facingy*(size/2+reach)>example.ypos-example.size/2){
            example.hit(damage);
          }
          if(reach==100){
            image(shortsword_back,xpos,ypos,20,reach);
            }
            else{
              image(longsword_back,xpos,ypos,20,reach);
            }
          
        }
        if(facingy==-1){
          if( abs(example.xpos-xpos)<example.size/2&&example.ypos<ypos-size/2&&ypos+facingy*(size/2+reach)<example.ypos+example.size/2){
            example.hit(damage);
            

          }
          if(reach==100){
            image(img_shortsword,xpos,ypos,20,-reach);
            }
            else{
              image(img_longsword,xpos,ypos,20,-reach);
            }
        }
        if(facingx==1){
          if( abs(example.ypos-ypos)<example.size/2&&example.xpos>xpos+size/2&&xpos+facingx*(size/2+reach)>example.xpos-example.size/2){
            example.hit(damage);
          }
          if(reach==100){
            image(img_shortsword_rotate,xpos,ypos,reach,20);
            }
            else{
              image(img_longsword_rotate,xpos,ypos,reach,20);
            }
        }
        if(facingx==-1){
          if( abs(example.ypos-ypos)<example.size/2&&example.xpos<xpos-size/2&&xpos+facingx*(size/2+reach)<example.xpos+example.size/2){
            example.hit(damage);
          }
          if(reach==100){
            image(shortsword_left,xpos,ypos,-reach,20);
            }
            else{
              image(longsword_left,xpos,ypos,-reach,20);
            }
        }
      }
    }
    
}
}
}
public class obstacle { 
  float leftx,topy,rightx,bottomy;
  boolean spiked,invis,door;
  obstacle(float lx, float ty, float rx, float by, boolean s,boolean inv,boolean dor){
    leftx=lx;//visually left
    topy=ty;//the one visually on top
    rightx=rx;
    bottomy=by;
    spiked=s;
    invis=inv;
    door=dor;
    
  }
void update(){
  if(door&&invis){
  int enemiesAlive=0;
  for(int i=0; i<enemies[level].length;i++){
  if(enemies[level][i].alive){
    enemiesAlive+=1;
  }
  
  }
  if(enemiesAlive==0){
    invis=false;
    for(int j=0; j<powerups[level].length;j++){
    powerups[level][j].inplay=true;
    }
  }
  }
  
    fill(128);
    if(spiked){
      fill(255,0,0);
    }
    
    
    
    noStroke();
    
    if(!invis){
      rectMode(CORNERS);
     rect(leftx,topy,rightx,bottomy);
      imageMode(CORNERS);
      if(spiked){
       if(level==0){
      image(spikedWall,leftx,topy,rightx,bottomy);
       }
       else{
         if(rightx-leftx>bottomy-topy){
           image(spikedWallHor,leftx,topy,rightx,bottomy);
         }
         else{
           image(spikedWallVer,leftx,topy,rightx,bottomy);
         }
       }
    }
    if(!door&&!spiked){
      if(level==0){
      image(normal,leftx,topy,rightx,bottomy);
       }
       else{
         if(rightx-leftx>bottomy-topy){
           image(normalHor,leftx,topy,rightx,bottomy);
         }
         else{
           image(normalVer,leftx,topy,rightx,bottomy);
         }
       }
    }
    
    if(door){
      if(level!=2&&level!=5){
      image(caveDoor,leftx,topy,rightx,bottomy);
      }
      else if(level==2){
       image(caveDoorLeft,leftx,topy,rightx,bottomy);
      }
      else{
        image(lightDoor,leftx,topy,rightx,bottomy);
      }
    }
    for(entity example:enemies[level]){
     collision(example);
    }
    collision(player1);
  }
}
  void collision(entity example){
     if(example.xpos-example.size/2<=rightx && example.xpos-example.size/2>=rightx-example.movs  && example.ypos+example.size/2 >= topy && example.ypos - example.size/2 <=bottomy){//right side collision
      if(example.xmov<0){
      example.xmov=0;
      }
      if(spiked&&example.immunity==0){
      example.hit(10);
      }
      if(door&&example==player1&&!invis){
        if(level<levelCap){
        level+=1;
        }
        else{
          won=true;
        }
        if(example.xpos>width/2){
        example.xpos=100;
        }
        else{
          example.xpos=width-100;
        }
      }
    }
    if(example.ypos-example.size/2<=bottomy && bottomy-example.movs <=example.ypos-example.size/2  && example.xpos + example.size/2 >=leftx && example.xpos-example.size/2 <= rightx ){//bottom side collision
      if(example.ymov<0){
      example.ymov=0;
      }
      if(spiked&&example.immunity==0){
      example.hit(10);
      }
     if(door&&example==player1&&!invis){
        if(level<levelCap){
        level+=1;
        }
        else{
          won=true;
        }
        example.ypos=height-100;
      }
    }
    if(leftx+example.movs>=example.xpos+example.size/2 && example.xpos+example.size/2 >= leftx && example.ypos+example.size/2 >= topy && example.ypos - example.size/2<=bottomy){//left side collision
      if(example.xmov>0){
      example.xmov=0;
      }
      if(spiked&&example.immunity==0){
      example.hit(10);
      }
      if(door&&example==player1&&!invis){
        if(level<levelCap){
        level+=1;
        }
        else{
          won=true;
        }
        example.xpos=width-100;
      }
    }
    if(example.ypos+example.size/2>=topy&& example.xpos + example.size/2 >= leftx && example.xpos-example.size/2 <= rightx && example.ypos+example.size/2 <= topy+example.movs){//top side collision
      if(example.ymov>0){
      example.ymov=0;
      }
      if(spiked&&example.immunity==0){
      example.hit(10);
      }
      if(door&&example==player1&&!invis){
        if(level<levelCap){
        level+=1;
        }
        else{
          won=true;
        }
        example.ypos=100;
      }
    }
    
  }
  
}
public class button {
  float leftx,topy,rightx,bottomy;
  String text, type;
  boolean visib;
  button(float lx, float ty, float rx, float by, String te, String typ, boolean vis){
    leftx=lx;
    topy=ty;
    rightx=rx;
    bottomy=by;
    text=te;
    type=typ;
    visib=vis;
  }
  void update(){
    noStroke();
    if(visib){
    fill(0,0,255);
    }
    else{
      noFill();
    }
    if(leftx<mouseX&&mouseX<rightx&&topy<mouseY&&mouseY<bottomy&&visib){
      
      if(mousePressed){
      if(type=="reset"){
        setup();
        visib=false;
      }
      if(type=="start"){
        level=0;
        visib=false;
        paused=false;
      }
      }
      fill(220);
    }
    
    rect(leftx,topy,rightx,bottomy);
    if(visib){
    fill(0,255,0);
    textAlign(CENTER);
    textSize(20);
    text(text,(leftx+rightx)/2,(topy+bottomy)/2);
    }
    
  }
}
public class enemy extends entity{
  String behavior, attackPattern;
  boolean alive,inplay;
  float direction;
  ///float direction2;
  enemy(int d, int h, float xpo, float ypo, float mov, float siz, String b, boolean inpla,int m){
    damage=d;
    xmov=0;
    ymov=0;
    health=h;
    facingx=1;
    facingy=0;
    xpos=xpo;
    ypos=ypo;
    movs=mov;
    size=siz;
    behavior=b;
    immunity=0;
    invincFrames= frameRate*0.5;
    alive=true;
    inplay=inpla;
    maxHealth=h;
    money=m;
    attackCooldown=0;
    attackPattern="";
    direction=0;//for sword enemies and boss enemies
   /// direction2=0;//dont want this to be x and y since just direction can be used
  }
  void update(){
    if(alive&&inplay){
    strokeWeight(3);
    fill(255,0,0.192);
    if(immunity>0){
      stroke(255,0,0);
      fill(255);
    }
    rectMode(CENTER);
    rect(xpos,ypos,size,size);
    rectMode(CORNERS);
    if(behavior=="melee"){
      imageMode(CENTER);
      
      if(immunity==0){
      if(frames % 16 >=0&&frames % 16<=3){
        image(meleeEnemyLow,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=4&&frames % 16<=7){
        image(meleeEnemy,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=8&&frames % 16<=11){
        image(meleeEnemyHigh,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=12&&frames % 16<=15){
        image(meleeEnemy,xpos,ypos,size*2,size*2);
       
      }
      
      }
      else{
        image(enemyHurt,xpos,ypos,size*2,size*2);
      }
      xmov=-(xpos-player1.xpos)*(xpos-player1.xpos)*(xpos-player1.xpos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((xpos-player1.xpos)));
      ymov=-(ypos-player1.ypos)*(ypos-player1.ypos)*(ypos-player1.ypos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((ypos-player1.ypos)));
      if(collision(player1)){
        player1.hit(damage);
      }
    }
    if(behavior=="boss1"){//referring to the first boss, whose behavior is quite simple
    imageMode(CENTER);
      
      if(immunity==0){
      if(frames % 16 >=0&&frames % 16<=3){
        image(meleeEnemyLow,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=4&&frames % 16<=7){
        image(meleeEnemy,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=8&&frames % 16<=11){
        image(meleeEnemyHigh,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=12&&frames % 16<=15){
        image(meleeEnemy,xpos,ypos,size*2,size*2);
       
      }
      
      }
      else{
        image(enemyHurt,xpos,ypos,size*2,size*2);
      }
       xmov=-(xpos-player1.xpos)*(xpos-player1.xpos)*(xpos-player1.xpos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((xpos-player1.xpos)));
       ymov=-(ypos-player1.ypos)*(ypos-player1.ypos)*(ypos-player1.ypos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((ypos-player1.ypos)));
      if(collision(player1)){
        player1.hit(damage);
      }
       if(maxHealth*0.5>health&&level==1&&!enemies[1][2].inplay){
         enemies[1][1].inplay=true;
         enemies[1][2].inplay=true;
         enemies[1][3].inplay=true;
       }
     }
     if(behavior=="limit melee"){//enemies will only move within a certain radius of the player
     imageMode(CENTER);
      
      if(immunity==0){
      if(frames % 16 >=0&&frames % 16<=3){
        image(meleeEnemyLow,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=4&&frames % 16<=7){
        image(meleeEnemy,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=8&&frames % 16<=11){
        image(meleeEnemyHigh,xpos,ypos,size*2,size*2);
        
      }
      if(frames % 16 >=12&&frames % 16<=15){
        image(meleeEnemy,xpos,ypos,size*2,size*2);
       
      }
      
      }
      else{
        image(enemyHurt,xpos,ypos,size*2,size*2);
      }
      if((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos)<200*200){
      xmov=-(xpos-player1.xpos)*(xpos-player1.xpos)*(xpos-player1.xpos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs(xpos-player1.xpos));
      ymov=-(ypos-player1.ypos)*(ypos-player1.ypos)*(ypos-player1.ypos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs(ypos-player1.ypos));
      }
      else{
        xmov=0;
        ymov=0;
      }
      
      if(collision(player1)){
        player1.hit(damage);
      }
    }
    if(behavior=="sword"){
      imageMode(CENTER);
      ////image(sword_enemy,xpos,ypos,size,size);
      imageMode(CORNER);
      if(attackCooldown>0){//this use of negative and positive attackCooldown is useful
        attackCooldown-=1;
        
            if(direction>0){
            image(shortsword_left,xpos,ypos,-100,20);
            
            }
            else{
              image(img_shortsword_rotate,xpos,ypos,100,20);
            }
      }
      else if(attackCooldown<0){
        attackCooldown+=1;
       
        if(direction<0){
            image(shortsword_back,xpos,ypos,20,100);
            
            }
            else{
              image(img_shortsword,xpos,ypos,20,-100);
            }
      }
      imageMode(CORNER);
        if(abs(xpos-player1.xpos)>abs(ypos-player1.ypos)){
          xmov= -(xpos-player1.xpos)*(abs(xpos-player1.xpos)-80)*(abs(xpos-player1.xpos)-80)/(((abs(xpos-player1.xpos)-80)*(abs(xpos-player1.xpos)-80)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs(xpos-player1.xpos));
          ymov=-(ypos-player1.ypos)*(ypos-player1.ypos)*(ypos-player1.ypos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs(ypos-player1.ypos));
          if(abs(xpos-player1.xpos)<100&&(ypos-player1.ypos)<player1.size&&attackCooldown==0){
            
            
            direction=(xpos-player1.xpos)/abs(xpos-player1.xpos);
            
            if(direction>0){
            image(shortsword_left,xpos,ypos,-100,20);
            
            }
            else{
              image(img_shortsword_rotate,xpos,ypos,100,20);
            }
            player1.hit(damage);
            attackCooldown+=frameRate*0.5;
          }
        }
        else{
           ymov= -(ypos-player1.ypos)*(abs(ypos-player1.ypos)-80)*(abs(ypos-player1.ypos)-80)/(((abs(ypos-player1.ypos)-80)*(abs(ypos-player1.ypos)-80)+(xpos-player1.xpos)*(xpos-player1.xpos))*abs(ypos-player1.ypos));
            xmov=-(xpos-player1.xpos)*(xpos-player1.xpos)*(xpos-player1.xpos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs(xpos-player1.xpos));
            if(abs(ypos-player1.ypos)<100&&(xpos-player1.xpos)<player1.size&&attackCooldown==0){
              strokeWeight(5);
            
            direction=(ypos-player1.ypos)/abs(ypos-player1.ypos);
            if(direction<0){
            image(shortsword_back,xpos,ypos,20,100);
            
            }
            else{
              image(img_shortsword,xpos,ypos,20,-100);
            }
            player1.hit(damage);
            attackCooldown-=frameRate*0.5;
          }
        }
      
      
    }
    if(behavior=="boss2"){//second and final bossfight
    imageMode(CENTER);
    ////image(boss2,xpos,ypos,size,size);
      if(attackCooldown==0){
        float i=random(0,2);
        if(0<=i&&i<=1){
          attackCooldown=720;
        }
        else{
          attackCooldown=-300;
        }
      }
      else{
        if(attackCooldown>0){
          attackCooldown-=1;
        }
        else if(attackCooldown<0){
          attackCooldown+=1;
        }
      }
      if(attackCooldown<=720&&attackCooldown>=300){
        xmov=0;
        ymov=0;
        strokeWeight(1);
        stroke(255,0,0);
        line(player1.xpos,player1.ypos,xpos,ypos);
        ///direction=-(xpos-player1.xpos)*(xpos-player1.xpos)*(xpos-player1.xpos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((xpos-player1.xpos)));
        ///direction2=-(ypos-player1.ypos)*(ypos-player1.ypos)*(ypos-player1.ypos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs(ypos-player1.ypos));
      }
      if(attackCooldown<300&&attackCooldown>0){
        xmov=3*-(xpos-player1.xpos)*(xpos-player1.xpos)*(xpos-player1.xpos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((xpos-player1.xpos)));
        ymov=3*-(ypos-player1.ypos)*(ypos-player1.ypos)*(ypos-player1.ypos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs(ypos-player1.ypos));
       
      }
      if(attackCooldown>=-300&&attackCooldown<0){
        ellipseMode(CENTER);
        if(attackCooldown<=-60){
          fill(255,0,0,64);
          ellipse(xpos,ypos,250,250);
           xmov=-(xpos-player1.xpos)*(xpos-player1.xpos)*(xpos-player1.xpos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((xpos-player1.xpos)));
           ymov=-(ypos-player1.ypos)*(ypos-player1.ypos)*(ypos-player1.ypos)/(((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos))*abs((ypos-player1.ypos)));
        }
        if(attackCooldown>=-60){
          fill(255,0,0,192);
          ellipse(xpos,ypos,250*(60+attackCooldown)/60,250*(60+attackCooldown)/60);
          if((xpos-player1.xpos)*(xpos-player1.xpos)+(ypos-player1.ypos)*(ypos-player1.ypos)<(250*(60+attackCooldown)/60)*-250*(60+attackCooldown)/60){
            player1.hit(damage);
            xmov=0;
            ymov=0;
          }
          
        }
      }
      if(health<maxHealth/2&&enemies[5][1].inplay==false){
        
        enemies[5][1].inplay=true;
        enemies[5][2].inplay=true;
        enemies[5][3].inplay=true;
      }
      if(collision(player1)){
        player1.hit(damage);
      }
    }
    for(int i=0;i<enemies[level].length;i++){
      if(inplay&&alive&&enemies[level][i].alive&&enemies[level][i].inplay){
          if(xpos-enemies[level][i].xpos<(size+enemies[level][i].size)*0.5&&xpos-enemies[level][i].xpos>0&&abs(ypos-enemies[level][i].ypos)<(size+enemies[level][i].size)*0.5){
            if(xmov<0){
              xmov=0;
            }
            if(enemies[level][i].xmov>0){
              enemies[level][i].xmov=0;
            }
          }
          if(-xpos+enemies[level][i].xpos<(size+enemies[level][i].size)*0.5&&-xpos+enemies[level][i].xpos>0&&abs(ypos-enemies[level][i].ypos)<(size+enemies[level][i].size)*0.5){
            if(xmov>0){
              xmov=0;
            }
            if(enemies[level][i].xmov<0){
              enemies[level][i].xmov=0;
            }
          }
          if(ypos-enemies[level][i].ypos<(size+enemies[level][i].size)*0.5&&ypos-enemies[level][i].ypos>0&&abs(xpos-enemies[level][i].xpos)<(size+enemies[level][i].size)*0.5){
            if(ymov<0){
              ymov=0;
            }
            if(enemies[level][i].ymov>0){
              enemies[level][i].ymov=0;
            }
          }
          if(-ypos+enemies[level][i].ypos<(size+enemies[level][i].size)*0.5&&-ypos+enemies[level][i].ypos>0&&abs(xpos-enemies[level][i].xpos)<(size+enemies[level][i].size)*0.5){
            if(ymov>0){
              ymov=0;
            }
            if(enemies[level][i].ymov<0){
              enemies[level][i].ymov=0;
            }
          }
        }
    }
  }
  if(health<=0&&alive){
    alive=false;
    if(inplay){
    player1.money +=money;
    }
  }
  }
  boolean collision(entity entity1){
  if(abs((xpos-entity1.xpos))<(entity1.size+size)/2&&abs((ypos-entity1.ypos))<(entity1.size+size)/2){
      return true;
    }
    else{
    return false;
    }
}
}
class powerup{
  String type;
  float xpos,ypos;
  boolean inplay;
  boolean used;
  int price;
  powerup(float x, float y, String t, boolean i, boolean u, int p){
    xpos=x;
    ypos=y;
    type=t;
    inplay=i;
    used=u;
    price=p;
  }
  void update(){
    fill(128,128,128,128);
    rectMode(CENTER);

    if(inplay&&!used){
    rect(xpos,ypos,100,100);
    if(price!=0){
      textSize(50);
      fill(0);
      text(price,xpos,ypos+100);
      
    }
    imageMode(CENTER);
    if(type=="health_canister"){
     image(health,xpos,ypos,200,200);
    }
      if(type=="damage"){
        image(damage,xpos,ypos,100,100);
      }
      if(type=="reach"){
        image(range,xpos,ypos,100,100);
        
      }
      if(type=="movement"){
        
        image(movement,xpos,ypos,100,100);
      }
    if((player1.xpos-xpos)*(player1.xpos-xpos)+(player1.ypos-ypos)*(player1.ypos-ypos)<2500&&player1.money>=price){
      if(type=="health_canister"){
        player1.maxHealth+=50;
        player1.health=player1.maxHealth;
      }
      
      if(type=="damage"){
        
        player1.damage+=20;
        
      }
      if(type=="reach"){
        
        player1.reach+=50;
      }
      if(type=="movement"){
        
        player1.movs+=3;
      }
      used=true;
      player1.money-=price;
    }
    
  }
  }
}
