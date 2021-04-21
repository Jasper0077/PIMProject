<html>
  <head>
    <title>Personal Information Management System Homepage</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Galada&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
      body{
        background-image: url('img/ocean.jpg');
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center;
      }
    </style>
  </head>
  <!-- This is header section -->
  <body>
    <div class="menu">
      <ul style="margin-left: 200px;">
        <li class="logo" style="margin: 0;width: 30px;"><img src="img/home.png"></li>
        <li style="color: white;font-family: 'Merienda One', cursive;">HAPPY PIM</li>
      </ul>
    </div>

    <div style="height: 89vh;background-color: rgba(50,50,50,0.2)">
      <div style="width: 80%;margin:auto;padding-top: 100px;">
        <div style="color: white;text-align: center;font-family: 'Merienda One', cursive;font-size: 80px;">
          WELCOME TO HAPPY PIM
        </div>
        <span class="material-icons" style="color:white;float: right;transform: translate(-40px,-80px);
        font-size: 50px;">
        work
        </span>
        <div style="padding: 40px;color:white;text-align: center;font-family: 'Yanone Kaffeesatz', sans-serif;
        font-size: 20px;font-weight: bold;">
          Nice, Simple and Neat Personal Information Management System
          <span class="material-icons" style="color:white;position:relative;top:8;font-size: 30px;">
          event_available
          </span>
        </div>
        <div style="display: flex;padding: 15px 380px;">
          <a href="login.jsp">
            <div class="login-button">
              <b>Log in</b>
            </div>
          </a>

          <div style="color: white;margin:15px 50px;font-size: 20px;">
            <b>Or</b>
          </div>

          <a href="signup.jsp">
            <div class="signup-button">
              <b>Sign up</b>
            </div>
          </a>
        </div>
      </div>
    </div>

  </body>
  <style>
    .login-button
    {
      border-radius: 30px;
      color: white;
      padding: 15px 45px;
      border: 2px solid white;
      font-size: 20px;
      cursor: pointer;
    }
    .login-button:hover
    {
      background-color: white;
      color: black;
    }
    .login-button:active
    {
      margin-left: 5px;
      padding: 10px 40px;
    }
    .signup-button
    {
      border-radius: 30px;
      background-color: rgba(255,255,255,0.7);
      padding: 15px 40px;
      border: 2px solid white;
      font-size: 20px;
      cursor: pointer;
    }
    .signup-button:hover
    {
      background-color: rgba(255,255,255,1);
    }
    .signup-button:active
    {
      background: none;
      color: white;
    }
  </style>
</html>
