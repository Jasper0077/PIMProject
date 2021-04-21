<html>
<head>
  <title>Personal Management System Homepage</title>
  <link rel="stylesheet" href="css/login.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
<div class="background-container">
  <div class="loginform-container">
    <div class="login-title">
      Sign in
    </div>
    <form class="login-form" method="post" action="LoginServlet">
      <div class="input-box">
        <input type="text" name="username" required>
        <label for="username"><i class="material-icons" style="position: relative;top: 5px;">person</i> Username</label>
      </div>
      <div class="input-box">
        <input type="password" name="password" required>
        <label for="username"><i class="material-icons" style="position: relative;top: 5px;">vpn_key</i> Password</label>
      </div>
      <div class="login-button">
        <button type="submit">Sign in</button>
      </div>
    </form>
  </div>

</div>
</body>
</html>
