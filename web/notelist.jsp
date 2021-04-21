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
    <title>Notes</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

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
        <a href="calendarlist.jsp"><li>Calendar</li></a>
        <a href="contact.jsp"><li>Contact</li></a>
        <a href="notelist.jsp"><li class="active">Note</li></a>
        <a href="collectionlist.jsp"><li>Collection</li></a>
        <a href="index.jsp"><li>Profile</li></a>
        <li><a href="LogOutServlet" class="signup-btn" style="color: white;"><span>Log Out</span></a></li>
      </ul>
    </div>

    <div class="container">
    <!-- Content section -->
    <div class="note">
      <h3>Notes</h3>
        <table width="100%">
          <!-- Add note button -->
          <tr>
            <td>
              <a hreaf="#"><button onclick="document.getElementById('add-note-cat').style.display='block'" class="add-note-btn"><span>+ New Note Category</span></button></a>
            </td>
          <tr>

          <%
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld","root","123456");
            String sql = "SELECT * FROM cld.note_cat where user_id = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, (String) session.getAttribute("uid"));

            ResultSet rs = stm.executeQuery();

            String sql_child = null;
            PreparedStatement stm_child = null;
            ResultSet rs_child = null;

            while (rs.next())
            {
          %>
          <!-- Note cells -->
          <tr>
            <td>
              <div class="cell">
                  <div class="title">
                    <%
                      sql_child = "SELECT * FROM cld.note where note_cat_id = ?";
                      stm_child = conn.prepareStatement(sql_child);
                      stm_child.setString(1, rs.getString("idnote_cat"));

                      rs_child = stm_child.executeQuery();

                      if (rs_child.next())
                      {
                    %>
                    <a href="note.jsp?idnote_cat=<%=rs.getString("idnote_cat")%>&idnote=<%=rs_child.getString("idnote")%>">
                    <%=rs.getString("category")%>
                    </a>
                    <%
                      }else
                      {
                    %>
                    <a href="note.jsp?idnote_cat=<%=rs.getString("idnote_cat")%>">
                      <%=rs.getString("category")%>
                    </a>
                    <%
                      }
                    %>
                  </div>
                  <div style="float:right;transform: translate(0, -50px)">
                    <span class="material-icons" style="font-size: 35px;cursor: pointer;"
                    onclick="document.getElementById('edit-note-cat<%=rs.getString("idnote_cat")%>').style.display='block'">
                    edit
                    </span>
                    <span class="material-icons" style="font-size: 35px;cursor: pointer;"
                          onclick="document.getElementById('delete-note-cat<%=rs.getString("idnote_cat")%>').style.display='block'">
                    delete
                    </span>
                  </div>
                  <div class="info">
                    <%=rs.getString("date")%>
                  </div>
              </div>
            </td>
          </tr>
          <%
            }
            if (rs.absolute(0))
              rs.absolute(0);
          %>

          <tr>
            <td>
              <div class="cell">
                <div onclick="document.getElementById('add-note-cat').style.display='block'" class="title">
                  + New Note Category
                </div>

              </div>
            </td>
          </tr>

        </table>
    </div>

    <div id="add-note-cat" class="modal">
      <span onclick="document.getElementById('add-note-cat').style.display='none'" class="close" title="Close Modal">&times;</span>
      <form class="modal-content" action="AddNoteCatServlet" method="post">
        <div class="form-container">
          <h1>New Note Category</h1>
          <hr>
          <div class="form-label"><label for="name"><b>Note Category Name</b></label><br></div>
          <input type="text" name="category" required>

          <div class="form-label"><label for="date"><b>Date</b></label><br></div>
          <input type="date" name="date" required><br>

          <div class="clearfix">
            <button type="reset" class="reset-btn">Reset</button>
            <button type="submit" class="confirm-btn">Confirm</button>
          </div>
        </div>
      </form>
    </div>
    <%
      while (rs.next())
      {
    %>
    <div id="edit-note-cat<%=rs.getString("idnote_cat")%>" class="modal">
      <span onclick="document.getElementById('edit-note-cat<%=rs.getString("idnote_cat")%>').style.display='none'" class="close" title="Close Modal">&times;</span>
      <form class="modal-content" action="EditNoteCatServlet" method="post">
        <input type="text" name="idnote_cat" value="<%=rs.getString("idnote_cat")%>" style="display: none;">
        <div class="form-container">
          <h1>Rename Note Category</h1>
          <hr>
          <div class="form-label"><label for="name"><b>Note Category Name</b></label><br></div>
          <input type="text" name="category" value="<%=rs.getString("category")%>" required>

          <div class="clearfix">
            <button type="reset" class="reset-btn">Reset</button>
            <button type="submit" class="confirm-btn">Confirm</button>
          </div>
        </div>
      </form>
    </div>

      <div id="delete-note-cat<%=rs.getString("idnote_cat")%>" class="modal">
        <form class="confirm-form" action="DeleteNoteCatServlet" method="post">
          <input type="text" name="idnote_cat" value="<%=rs.getString("idnote_cat")%>" style="display: none">
          <div class="confirm-header">
            Note Category Deletion <span style="float:right;font-size: 22px;cursor: pointer;margin-top: -5px;" onclick="document.getElementById('delete-note-cat<%=rs.getString("idnote_cat")%>').style.display='none'">&times;</span>
          </div>
          <div class="confirm-text">
            Are you sure you wish to delete <b><%=rs.getString("category")%></b> ?
          </div>
          <div class="confirm-form-but">
            <button type="submit" name="button">Confirm</button>
            <button type="button" onclick="document.getElementById('delete-note-cat<%=rs.getString("idnote_cat")%>').style.display='none'">Cancel</button>
          </div>
        </form>
      </div>
    <%
      }
    %>
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
  window.onclick = function(event) {
    let backContainer = document.getElementById('add-note-cat');
    if (event.target == backContainer)
    {
      backContainer.style.display = "none";
    }
  }

  </script>
</html>
