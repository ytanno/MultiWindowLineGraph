//no lisense 

//Operation check 2015/11/06
//use processing 3.0 
//run sample https://www.youtube.com/watch?v=wlIiOlMpxOI&feature=youtu.be

//The following article is very useful
//ref https://forum.processing.org/two/discussion/3949/real-time-graph-plotting
//ref http://3846masa.blog.jp/archives/1038375725.html
//ref https://processing.org/tutorials/arrays/

SecondApplet second;
int[] plot1;
int[] plot2;

void settings() 
{
  size(400, 400);
}

void setup() 
{
  frameRate(60); //Update Gprah Time  
  drawStuff();
  plot1 = new int[width];
  plot2 = new int[width];
  second = new SecondApplet(this);
}

void draw() 
{
  drawStuff(); //clear drawed windows

  // beginning to avoid overwriting the data
  for (int i = plot1.length-1; i > 0; i--) 
  {
    plot1[i] = plot1[i-1];
    plot2[i] = plot2[i-1];
  }
  // Add new values to the beginning
  plot1[0] = mouseY;
  plot2[1] = mouseX;
  println(plot1[0]); 
  // Display each pair of values as a line
  for (int i = 1; i < plot1.length; i++) 
  {
    stroke(0, 0, 255); //Blue
    line(i, plot1[i], i-1, plot1[i-1]);
    stroke(255, 0, 0); //red
    line(i, plot2[i], i-1, plot2[i-1]);
  }
}

void drawStuff() 
{
  background(255);
  for (int i = 0; i <= width; i += 50) 
  {
    fill(0, 255, 0);
    text(i/2, i-10, height-15);
    stroke(0);
    line(i, height, i, 0);
  }
  for (int j = 0; j < height; j += 140) 
  {
    fill(0, 255, 0);
    text(6-j/(height/6), 0, j);
    stroke(0);
    line(0, j, width, j);
  }
}

class SecondApplet extends PApplet 
{
  PApplet parent;
  int[] plot2;

  SecondApplet(PApplet _parent) {
    super();
    // set parent
    this.parent = _parent;
    //// init window
    try {
      java.lang.reflect.Method handleSettingsMethod =
        this.getClass().getSuperclass().getDeclaredMethod("handleSettings", null);
      handleSettingsMethod.setAccessible(true);
      handleSettingsMethod.invoke(this, null);
    } 
    catch (Exception ex) {
      ex.printStackTrace();
    }

    PSurface surface = super.initSurface();
    surface.placeWindow(new int[]{0, 0}, new int[]{0, 0});

    this.showSurface();
    this.startSurface();
  }

  void settings() {
    size(400, 400);
  }

  void setup() {
    plot2 = new int[width];
  }

  void draw() 
  {
    background(0);
    drawStuff(); //clear drawed windows

    // beginning to avoid overwriting the data
    for (int i = plot1.length-1; i > 0; i--) 
    {
      plot2[i] = plot2[i-1];
    }
    // Add new values to the beginning
    plot2[0] = mouseY ;
    println(plot2[0]); 
    // Display each pair of values as a line
    for (int i = 1; i < plot1.length; i++) 
    {
      stroke(255, 0, 0); //Red
      line(i, plot2[i], i-1, plot2[i-1]);
    }
  }

  void drawStuff() 
  {
    background(255);
    for (int i = 0; i <= width; i += 50) 
    {
      fill(0, 255, 0);
      text(i/2, i-10, height-15);
      stroke(0);
      line(i, height, i, 0);
    }
    for (int j = 0; j < height; j += 140) {
      fill(0, 255, 0);
      text(6-j/(height/6), 0, j);
      stroke(0);
      line(0, j, width, j);
    }
  }
}