<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
  if (session.getAttribute("username") == null)
    response.sendRedirect("home.jsp");
%>
<html>
  <head>
    <title>PIM Collection</title>
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
    <div class="container">
      <div class="menu">
        <ul>
          <a href="index.jsp"><li class="logo"><img src="img/home.png"></li></a>
          <a href="calendarlist.jsp"><li>Calendar</li></a>
          <a href="contact.jsp"><li>Contact</li></a>
          <a href="notelist.jsp"><li>Note</li></a>
          <a href="collectionlist.jsp"><li class="active">Collection</li></a>
          <a href="index.jsp"><li>Profile</li></a>
          <li><a href="LogOutServlet" class="signup-btn" style="color: white;"><span>Log Out</span></a></li>
        </ul>
      </div>
    <%
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld","root","123456");
      String sql = "SELECT * FROM cld.collection where user_id = ?";
      PreparedStatement stm = conn.prepareStatement(sql);

      stm.setString(1, (String) session.getAttribute("uid"));

      ResultSet rs = stm.executeQuery();
      int i = 1;
    %>
    <!-- Content section -->
    <div class="collection-list">
      <h2>Collection List</h2>
      <ul>
        <%
          while (rs.next())
          {
        %>
        <a href="collection.jsp?idcollection=<%=rs.getString("idcollection")%>&collectionName=<%=rs.getString("collectionName")%>">
        <li><span><%=i%></span><%=rs.getString("collectionName")%></li>
        </a>
        <%
            i++;
          }
        %>
      </ul>
      <h3 id="original" onclick="addCollection()"><span>+</span>Add Collection</h3>
      <h3 id="inputArea" style="display: none;">
        <form action="AddCollectionServlet" method="post">
          <span onclick="document.getElementById('submitAddCollection').click()">+</span>
          <input type="text" name="collectionName" placeholder="Collection Name" style="font-size: 20px;">
          <input type="submit" id="submitAddCollection" hidden>
          <button type="button" style="padding: 5px;" onclick="cancelAdd()">Cancel</button>
        </form>
      </h3>

    </div>


    </div>
    <!-- Footer section -->
    <div style="margin-top: 100px; background-color: #ffffff;">
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
    function addCollection() {
      document.getElementById('original').style.display = 'none';
      document.getElementById('inputArea').style.display = 'block';
    }

    function cancelAdd() {
      document.getElementById('original').style.display = 'block';
      document.getElementById('inputArea').style.display = 'none';
    }

  </script>
</html>
