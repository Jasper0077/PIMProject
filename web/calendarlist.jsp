<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
  if (session.getAttribute("username") == null)
    response.sendRedirect("home.jsp");
%>
<html>
  <head>
    <title>PIM Calendar List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
      <%@include file="/css/style.css" %>
      a
      {
        text-decoration: none;
        color: inherit;
      }
    </style>
  </head>
  <!-- This is header section -->
  <body>
    <div class="menu">
      <ul>
        <a href="index.jsp"><li class="logo"><img src="img/home.png"></li></a>
        <a href="calendarlist.jsp"><li class="active">Calendar</li></a>
        <a href="contact.jsp"><li>Contact</li></a>
        <a href="notelist.jsp"><li>Note</li></a>
        <a href="collectionlist.jsp"><li>Collection</li></a>
        <a href="index.jsp"><li>Profile</li></a>
        <li><a href="LogOutServlet" class="signup-btn" style="color: white;"><span>Log Out</span></a></li>
      </ul>
    </div>

    <div class="container">

    <!-- Content section -->
    <!-- Here, we use the collectionlist css atribute to implement the calendar list as well -->
    <div class="collection-list">
      <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld","root","123456");
        String sql = "SELECT * FROM cld.calendar where user_id = ?";
        PreparedStatement stm = conn.prepareStatement(sql);

        stm.setString(1, (String) session.getAttribute("uid"));

        ResultSet rs = stm.executeQuery();
        int i = 1;
      %>
      <h2>Calendar</h2>
      <ul>
        <%
          while (rs.next())
          {
        %>
        <li>
          <a href="calendar.jsp?idcalendar=<%=rs.getString("idcalendar")%>&cname=<%=rs.getString("calendarName")%>">
            <span><%=i%></span><%=rs.getString("calendarName")%>
          </a>
        </li>
        <%
            i++;
          }
        %>
        <li>
          <a href="calendarall.jsp">
            <span><%=i%></span>All Event Calendar
          </a>
        </li>
        <h3 id="original" onclick="addCalendar()"><span>+</span>Add Calendar</h3>
        <h3 id="inputArea" style="display: none;">
          <form action="AddCalendarServlet" method="post">
            <span onclick="document.getElementById('submitAddCalendar').click()">+</span>
            <input type="text" name="calendarName" placeholder="Calendar Name" style="font-size: 20px;">
            <input type="submit" id="submitAddCalendar" hidden>
            <button type="button" style="padding: 5px;" onclick="cancelAdd()">Cancel</button>
          </form>
        </h3>
      </ul>
        <!--<h3><span>+</span>Add Calendar</h3>-->
    </div>




    </div>
    <!-- Footer section -->
    <div style="background-color: #ffffff;">
      <div class="footer">
        <ul>
          <li> <b> Contact: </b> swe1804134@xmu.edu.my </li>
          <li> <b> Office: </b> D5-304</li>
          <li> <b> Mobile: </b> 017-65897431</li>
        </ul>
      </div>
    </div>

  </body>
  <script>
    function addCalendar() {
      document.getElementById('original').style.display = 'none';
      document.getElementById('inputArea').style.display = 'block';
    }

    function cancelAdd() {
      document.getElementById('original').style.display = 'block';
      document.getElementById('inputArea').style.display = 'none';
    }

  </script>
</html>
