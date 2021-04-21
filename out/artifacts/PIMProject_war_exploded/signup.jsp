<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
  <head>
    <title>PIM Signup</title>
    <link rel="stylesheet" href="css/signup.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  </head>
  <!-- This is header section -->

  <body>
    <!-- Content section -->
      <div class="modal">

        <form name="form1" class="modal-content" action="SignUpServlet" method="post" onsubmit="return checkPassword(document.form1.password, document.form1.repeatpassword)">
          <div class="form-container">
            <h1>Sign Up</h1>
            <hr>
            <div class="form-label"><label for="username"><b>Username</b></label></div>
            <input type="text" placeholder="Jasper8762" name="username" required>

            <div class="form-label"><label for="password"><b>Password</b></label></div>
            <input type="password" name="password" required>

            <div class="form-label"><label for="R-Password"><b>Repeat Password</b></label></div>
            <input type="password" onblur="return checkPassword(document.form1.password, document.form1.repeatpassword)"name="repeatpassword" required>

            <h1>Personal Information</h1>

            <div class="form-label"><label for="Name"><b>Name</b></label></div>
            <input type="text" onblur="return allLetter(document.fomr1.name)" placeholder="Jasper Hwong" name="name" required>

            <div class="form-label"><label for="position"><b>Position</b></label></div>
            <input onchange="return allLetter(document.form1.position)" type="text" placeholder="Software Engineering" name="position" required>


            <div class="form-label"><label for="gender"><b>Gender:</b></label></div>
            <div style="margin-left: 15px;margin-bottom: 30px;">
              <input type="radio" checked="checked" name="gender" value="Male" style=""> Male
              <input type="radio" name="gender" value="Female" style="margin-left: 15px;"> Female
            </div>

            <div class="form-label">
              <label for=""><b>Email</b></label>
              <input onchange="return validateEmail(document.form1.email)" type="text" placeholder="example@123.com" name="email" required>
            </div>

            <div class="form-label">
              <label for=""><b>Phone</b></label>
              <input onblur="return stringlength(document.form1.num, 5, 19)" type="text" placeholder="0123456789" name="phone" required>
            </div>

            <div class="form-label">
              <label for="Address"><b>Address</b></label>
              <input type="text" placeholder="No 719A, Jalan Jambu of Pisang Road West, 93150, Kuching, Sarawak" name="address" required>
            </div>

            <div class="clearfix">
              <a href="home.jsp"><button type="button" class="reset-btn">Back</button></a>
              <button type="submit" class="confirm-btn">Confirm</button>
            </div>
          </div>
        </form>
      </div>

      <script>
      function allLetter(input)
      {
        var letters = /^[A-Za-z]+$/;
        if(input.value.match(letters))
        {
          return true;
        }
        else
        {
          alert('Please input alphabet characters only for name or position');
        }
      }

      function checkPassword(input1, input2)
      {
        if(input1.value === input2.value)
        {
          return true;
        }
        else
        {
          alert('Passwords are not same!')
          return false;
        }
      }

      function stringlength(inputtxt, minlength, maxlength)
      {
        var field = inputtxt.value;
        var mnlen = minlength;
        var mxlen = maxlength;

        if(field.length<mnlen || field.length> mxlen)
        {
          alert("Make sure the phone number between " +mnlen+ " and " +mxlen+ " characters");
          return false;
        }
        else
        {
          return true;
        }
      }

      function validateEmail(inputtxt)
      {
        var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if(inputtxt.value.match(mailformat))
        {
            return true;
        }
        else
        {
          alert("You have entered an invalid email address!");
          return false;
        }
      }
      </script>


    </div>



  </body>
</html>
