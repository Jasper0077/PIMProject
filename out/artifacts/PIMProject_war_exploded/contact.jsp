<%@ page import="java.sql.*" %>
<%
  if (session.getAttribute("username") == null)
    response.sendRedirect("home.jsp");
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <title>Contact</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
      <%@include file="/css/style.css" %>
      <%@include file="/css/contact.css"%>
      a
      {
        text-decoration: none;
        color: inherit;
      }
    </style>
    <script>
      function addnewcat()
      {
        document.getElementById('add-cont-cat').style.display='block';
      }
    </script>
  </head>
  <!-- This is header section -->
  <body>
    <div class="menu">
      <ul>
        <a href="index.jsp"><li class="logo"><img src="img/home.png"></li></a>
        <a href="calendarlist.jsp"><li>Calendar</li></a>
        <a href="contact.jsp"><li class="active">Contact</li></a>
        <a href="notelist.jsp"><li>Note</li></a>
        <a href="collectionlist.jsp"><li>Collection</li></a>
        <a href="index.jsp"><li>Profile</li></a>
        <li><a href="LogOutServlet" class="signup-btn" style="color: white;"><span>Log Out</span></a></li>
      </ul>
    </div>

    <div class="container">
      <!-- Add new contact & Edit contact-->
      <div style="margin: 50px; background-color: #FFFFFF;display: none">
        <a hreaf="#"><button onclick="document.getElementById('id01').style.display='block'" class="button"><span>+ Add New Contact</span></button></a>
      </div>

      <!-- Content section -->

      <div style="width: 100%;min-height: 100vh;">
        <table width="100%" style="min-height: 800px;" >
          <tr>
            <td width="15%" style="border-right: 1px solid black;vertical-align: top;background-color: rgba(80,80,80,0.1);">
              <nav style="width: 100%;">
                <ul style="list-style-type: none;">
                  <li>
                      <span class="material-icons" style="position: relative;top: 5px;">
                        chevron_right
                      </span>
                      <b>My Contact</b>
                      <img src="img/contactbook.png" style="position: relative;top: 5px;width: 20px;">

                    <ul style="list-style-type: none;line-height: 25px;padding: 7px 0;">
                      <%
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn_h = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                                "root","123456");
                        String sql_h = "SELECT * FROM cld.contact_cat where user_id = ?";
                        PreparedStatement stm_h = conn_h.prepareStatement(sql_h);

                        stm_h.setString(1 ,(String) session.getAttribute("uid"));

                        ResultSet rs_h = stm_h.executeQuery();

                        while (rs_h.next())
                        {
                          try {
                            if (rs_h.getString("idcontact_cat").equals(request.getParameter("idcontact_cat")))
                            {
                        %>
                        <a href="contact.jsp?idcontact_cat=<%=rs_h.getString("idcontact_cat")%>">
                          <li id="contactCategory" style="background-color: rgba(50,50,50,0.3);">
                            <span class="material-icons" style="position: relative;top: 6px;">perm_contact_calendar
                            </span> <%=rs_h.getString("category")%>
                          </li>
                        </a>
                        <%
                            }else
                            {
                        %>
                        <a href="contact.jsp?idcontact_cat=<%=rs_h.getString("idcontact_cat")%>">
                          <li id="contactCategory">
                            <span class="material-icons" style="position: relative;top: 6px;">perm_contact_calendar
                            </span> <%=rs_h.getString("category")%>
                          </li>
                        </a>
                        <%
                            }
                          } catch (SQLException e) {
                            e.printStackTrace();
                          }
                        }
                      %>
                      <li id="contactCategory" class="addnewcat" onclick="addnewcat()">
                        <span class="material-icons" style="position: relative;top: 6px;font-weight: bold;">add</span>New Contact Category
                      </li>
                    </ul>
                  </li>
                </ul>
              </nav>

            </td>

            <td width="85%" style="vertical-align: top;">
              <div style="border-bottom: 1px solid black;padding-bottom: 10px;padding-left: 10px;background-color: rgba(200,200,200,0.1);box-shadow: 0 0 5px 2px rgba(0, 0, 0, 0.2)">
                <%
                  String sql_t = "SELECT * FROM cld.contact_cat where idcontact_cat = ?";
                  PreparedStatement stm_t = conn_h.prepareStatement(sql_t);
                  ResultSet rs_t = null;

                  try {
                    stm_t.setString(1, request.getParameter("idcontact_cat"));
                  } catch (SQLException e) {
                    e.printStackTrace();
                  }

                  rs_t = stm_t.executeQuery();
                  if (rs_t.next())
                  {
                %>
                <span class="material-icons" style="position: relative;top: 6px;">perm_contact_calendar
                </span> <%=rs_t.getString("category")%>
                <%
                  }

                %>
                <div style="float:right; padding:8px 10px 8px 0px;cursor: pointer;" onclick="document.getElementById('delete-confirm-container').style.display='block'">
                  [Delete Category]
                </div>
                <div style="float:right; padding:8px 10px 8px 0px;cursor: pointer;" onclick="document.getElementById('edit-cont-cat').style.display='block'" >
                  [Rename Category]
                </div>
                <div style="display: inline-block;padding:8px 10px;cursor: pointer;" onclick="document.getElementById('id01').style.display='block'" >
                  [Add New Contact]
                </div>

              </div>

              <%
                String sql = "SELECT * FROM cld.contact where contact_cat_id = ?";
                PreparedStatement stm = conn_h.prepareStatement(sql);
                ResultSet rs = null;


                try {
                  stm.setString(1, request.getParameter("idcontact_cat"));
                } catch (SQLException e) {
                  e.printStackTrace();
                }

                rs = stm.executeQuery();
                int i = 0;
                while (rs.next())
                {
                  if (i % 2 == 0)
                  {
              %>
              <div style="display: flex">
                <div class="person">
                  <div class="left">
                      <img src="https://i.imgur.com/cMy8V5j.png" alt="user">
                      <div style="padding: 15px 0;">
                        <h4><%=rs.getString("position")%></h4>
                         <p>@<%=rs.getString("location")%></p>
                      </div>
                  </div>
                  <div class="right">
                      <div class="info">
                          <h3><%=rs.getString("name")%></h3>
                          <div class="info_data">
                            <div class="data">
                              <h4>Gender</h4>
                              <p><%=rs.getString("gender")%></p>
                            </div>
                            <div class="data">
                                <h4>Email</h4>
                                <p><%=rs.getString("email")%></p>
                            </div>
                          </div>
                          <div class="info_data">
                            <div class="data">
                              <h4>Address</h4>
                              <p><%=rs.getString("address")%></p>
                            </div>
                            <div class="data">
                              <h4>Phone</h4>
                              <p><%=rs.getString("phone")%></p>
                            </div>
                          </div>

                      </div>
                      <div style="display:flex;margin: 10px 0;justify-content: space-between;">
                        <div>
                          <button onclick="document.getElementById('del<%=rs.getString("idcontact")%>').style.display='block'" class="delete-contact-btn"><span>Delete Contact</span></button></a>
                        </div>
                        <div>
                          <button onclick="document.getElementById('edit<%=rs.getString("idcontact")%>').style.display='block'" class="edit-contact-btn"><span>Edit Contact</span></button>
                        </div>
                      </div>

                  </div>
                </div>
              <%
                  }
                  else
                  {
              %>
                <div class="person">
                  <div class="left">
                    <img src="https://i.imgur.com/cMy8V5j.png" alt="user">
                    <div style="padding: 15px 0;">
                      <h4><%=rs.getString("position")%></h4>
                      <p>@<%=rs.getString("location")%></p>
                    </div>
                  </div>
                  <div class="right">
                    <div class="info">
                      <h3><%=rs.getString("name")%></h3>
                      <div class="info_data">
                        <div class="data">
                          <h4>Gender</h4>
                          <p><%=rs.getString("gender")%></p>
                        </div>
                        <div class="data">
                          <h4>Email</h4>
                          <p><%=rs.getString("email")%></p>
                        </div>
                      </div>
                      <div class="info_data">
                        <div class="data">
                          <h4>Address</h4>
                          <p><%=rs.getString("address")%></p>
                        </div>
                        <div class="data">
                          <h4>Phone</h4>
                          <p><%=rs.getString("phone")%></p>
                        </div>
                      </div>

                    </div>
                    <div style="display:flex;margin: 10px 0;justify-content: space-between;">
                      <div>
                        <button onclick="document.getElementById('del<%=rs.getString("idcontact")%>').style.display='block'" class="delete-contact-btn"><span>Delete Contact</span></button></a>
                      </div>
                      <div>
                        <button onclick="document.getElementById('edit<%=rs.getString("idcontact")%>').style.display='block'" class="edit-contact-btn"><span>Edit Contact</span></button>
                      </div>
                    </div>

                  </div>
                </div>
              </div>
              <%
                  }
                  i++;
                }
                rs.absolute(0);
              %>


            </td>
          </tr>
        </table>

      </div>


      <div id="add-cont-cat" class="modal">
        <span onclick="document.getElementById('add-cont-cat').style.display='none'" class="close" title="Close Modal">&times;</span>
        <form class="modal-content" action="AddContactCatServlet" method="post">
          <div class="form-container">
            <h1>New Contact Category</h1>
            <hr>
            <div class="form-label"><label for="name"><b>Contact Category Name</b></label><br></div>
            <input type="text" name="name" required>
            <input type="text" name="idcontact_cat" value="<%=request.getParameter("idcontact_cat")%>" style="display: none">
            <div class="clearfix">
              <button onclick="document.getElementById('add-cont-cat').style.display='none'" class="reset-btn">Cancel</button>
              <button type="submit" class="confirm-btn">Confirm</button>
            </div>
          </div>
        </form>
      </div>

      <div id="edit-cont-cat" class="modal">
        <span onclick="document.getElementById('edit-cont-cat').style.display='none'" class="close" title="Close Modal">&times;</span>
        <form class="modal-content" action="EditContactCatServlet" method="post">
          <div class="form-container">
            <h1>Rename Contact Category</h1>
            <hr>
            <div class="form-label"><label for="name"><b>Contact Category Name</b></label><br></div>
            <input type="text" name="name" value="<%=rs_t.getString("category")%>" required>
            <input type="text" name="idcontact_cat" value="<%=request.getParameter("idcontact_cat")%>" style="display: none">
            <div class="clearfix">
              <button type="reset" class="reset-btn">Reset</button>
              <button type="submit" class="confirm-btn">Confirm</button>
            </div>
          </div>
        </form>
      </div>

      <div id="delete-confirm-container" class="modal">
        <form class="confirm-form" action="DeleteContactCatServlet" method="post">
          <input type="text" name="idcontact_cat" value="<%=request.getParameter("idcontact_cat")%>" style="display: none">
          <div class="confirm-header">
            Category Deletion <span style="float:right;font-size: 22px;cursor: pointer;margin-top: -5px;" onclick="document.getElementById('delete-confirm-container').style.display='none'">&times;</span>
          </div>
          <div class="confirm-text">
            Are you sure you wish to delete this contact category?
          </div>
          <div class="confirm-form-but">
            <button type="submit" name="button">Confirm</button>
            <button type="button" onclick="document.getElementById('delete-confirm-container').style.display='none'">Cancel</button>
          </div>
        </form>
      </div>

      <!--<button onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Sign Up</button>-->

      <div id="id01" class="modal">
        <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
        <form name="form1" class="modal-content" action="AddContactServlet" method="post">
          <input type="text" name="idcontact_cat" value="<%=request.getParameter("idcontact_cat")%>" style="display: none">
          <div class="form-container">
            <h1>Add Contact</h1>
            <hr>
            <div class="form-label"><label for="name"><b>Name</b></label></div>
            <input onblur="return allLetter(document.form1.name)" type="text" placeholder="Name" name="name" required>


            <div class="form-label"><label for="position"><b>Position</b></label></div>
            <input onchange="return allLetter(document.form1.position)" type="text" placeholder="Software Engineering" name="position" required>

            <div class="form-label"><label for="location"><b>Location</b></label></div>
            <input type="text" placeholder="Xiamen University" name="location" required>

            <div class="form-label"><label for="gender"><b>Gender</b></label></div>
            <div class="form-label">
              <input type="radio" id="male" name="gender" value="Male" style="margin: 15px;">
              <label for="male">Male</label><br>
              <input type="radio" id="female" name="gender" value="Female" style="margin: 15px;">
              <label for="female">Female</label><br>
            </div>

            <div class="form-label">
              <label for="email"><b>Email</b></label>
              <input onchange="return validateEmail(document.form1.email)" type="text" placeholder="example@123.com" name="email" required>
            </div>

            <div class="form-label">
              <label for=""><b>Phone</b></label>
              <input onblur="return stringlength(document.form1.num, 10, 11)" type="number" placeholder="0123456789" name="phone" required>
            </div>

            <div class="form-label">
              <label for="Address"><b>Address</b></label>
              <input type="text" placeholder="No 719A, Jalan Jambu of Pisang Road West, 93150, Kuching, Sarawak" name="address" required>
            </div>

            <div class="clearfix">
              <button type="reset" class="reset-btn">Reset All</button>
              <button type="submit" class="confirm-btn">Confirm</button>
            </div>
          </div>
        </form>
      </div>

    <%
        while (rs.next())
        {
    %>
      <div id="edit<%=rs.getString("idcontact")%>" class="modal">
        <span onclick="document.getElementById('edit<%=rs.getString("idcontact")%>').style.display='none'" class="close" title="Close Modal">&times;</span>
        <form name="form2" class="modal-content" action="EditContactServlet" method="post">
          <input type="text" name="idcontact" value="<%=rs.getString("idcontact")%>" style="display: none">
          <input type="text" name="idcontact_cat" value="<%=request.getParameter("idcontact_cat")%>" style="display: none">
          <div class="form-container">
            <h1>Edit Contact</h1>
            <hr>
            <div class="form-label">
              <label for="name"><b>Name</b></label>
              <input onchange="return allLetter(document.form2.name)" type="text" value="<%=rs.getString("name")%>" name="name" required>
            </div>

            <div class="form-label">
              <label for="position"><b>Position</b></label>
              <input onchange="return allLetter(document.form2.position)" type="text" value="<%=rs.getString("position")%>" name="position" required>
            </div>

             <div class="form-label"><label for="location"><b>Location</b></label></div>
             <input type="text" placeholder="Xiamen University" name="location" value="<%=rs.getString("location")%>" required>

            <div class="form-label"><label for="gender"><b>Gender</b></label></div>
            <div class="form-label">
              <input type="radio" id="male" name="gender" checked value="Male" style="margin: 15px;">
              <label for="male">Male</label><br>
              <input type="radio" id="female" name="gender" value="Female" style="margin: 15px;">
              <label for="female">Female</label><br>
            </div>

            <div class="form-label">
              <label for="email"><b>Email</b></label>
              <input onchange="return validateEmail(document.form2.email)" type="text" value="<%=rs.getString("email")%>" name="email" required>
            </div>

            <div class="form-label">
              <label for="num"><b>Phone</b></label>
              <input onchange="return stringlength(document.form2.num)" type="number" value="<%=rs.getString("phone")%>" name="phone" required>
            </div>

            <div class="form-label">
              <label for="Address"><b>Address</b></label>
              <input type="text" value="Jalan Sunsuria, Bandar Sunsuria, Sepang" name="address" value="<%=rs.getString("address")%>"  required>
            </div>

            <div class="clearfix">
              <button type="reset" class="reset-btn">Reset All</button>
              <button type="submit" class="confirm-btn">Update</button>
            </div>
          </div>
        </form>
      </div>

      <div id="del<%=rs.getString("idcontact")%>" class="modal">
            <form class="confirm-form" action="DeleteContactServlet" method="post">
                <input type="text" name="idcontact" value="<%=rs.getString("idcontact")%>" style="display: none">
                <input type="text" name="idcontact_cat" value="<%=request.getParameter("idcontact_cat")%>" style="display: none">
                <div class="confirm-header">
                    Category Deletion <span style="float:right;font-size: 22px;cursor: pointer;margin-top: -5px;" onclick="document.getElementById('del<%=rs.getString("idcontact")%>').style.display='none'">&times;</span>
                </div>
                <div class="confirm-text">
                    Are you sure you wish to delete <b><%=rs.getString("name")%></b> ?
                </div>
                <div class="confirm-form-but">
                    <button type="submit" name="button">Confirm</button>
                    <button type="button" onclick="document.getElementById('del<%=rs.getString("idcontact")%>').style.display='none'">Cancel</button>
                </div>
            </form>
        </div>
    <%
        }
    %>


    </div>
    <div style="margin-top: 20px; background-color: #FFFFFF;">
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

  window.onclick = function(event) {
    let backContainer = document.getElementById('add-cont-cat');
    if (event.target == backContainer)
    {
      backContainer.style.display = "none";
    }
    let backContainer3 = document.getElementById('delete-confirm-container');
    if (event.target == backContainer3)
    {
      backContainer3.style.display = "none";
    }
    let backContainer4 = document.getElementById('edit-cont-cat');
    if (event.target == backContainer4)
    {
      backContainer4.style.display = "none";
    }
    let backContainer5 = document.getElementById('id01');
    if (event.target == backContainer5)
    {
      backContainer5.style.display = "none";
    }
  }


  </script>
</html>
