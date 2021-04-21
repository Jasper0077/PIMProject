<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
  if (session.getAttribute("username") == null)
    response.sendRedirect("home.jsp");
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <title>Notes</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="ckeditor/ckeditor.js"></script>

    <style>
      <%@include file="/css/note.css" %>
      <%@include file="/ckeditor/config.js"%>
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
      %>

      <!-- Content section -->
      <div style="width: 100%;min-height: 600px;">
        <table style="width:100%;min-height: 600px;">
          <tr>
            <td width="15%" style="border-right: 1px solid black;vertical-align: top;background-color: rgba(80,80,80,0.1);">
              <nav style="width: 100%;">
                <ul style="list-style-type: none;">
                  <%
                    while (rs.next())
                    {
                      if (rs.getString("idnote_cat").equals(request.getParameter("idnote_cat")))
                      {
                  %>
                  <li>
                    <div id="root-display" style="cursor: pointer;" >
                      <span id="arrow-down" class="material-icons" style="position: relative;top: 5px;">
                        expand_more
                      </span>
                      <b><%=rs.getString("category")%></b>
                      <span class="material-icons" style="position: relative;top: 6px;">notes
                      </span>
                    </div>

                    <ul id="display-menu" class="display-menu" style="list-style-type: none;line-height: 25px;padding: 7px 0;">
                      <%
                        sql_child = "SELECT * FROM cld.note where note_cat_id = ?";
                        stm_child = conn.prepareStatement(sql_child);
                        stm_child.setString(1, rs.getString("idnote_cat"));

                        rs_child = stm_child.executeQuery();

                        while (rs_child.next())
                        {
                          if (rs_child.getString("idnote").equals(request.getParameter("idnote")))
                          {
                      %>
                      <a href="note.jsp?idnote_cat=<%=rs.getString("idnote_cat")%>&idnote=<%=rs_child.getString("idnote")%>">
                      <li id="contactCategory" style="background-color: rgba(50,50,50,0.3);">
                          <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                          </span> <%=rs_child.getString("title")%>
                      </li>
                      </a>

                      <%
                          }
                          else {
                            %>
                      <a href="note.jsp?idnote_cat=<%=rs.getString("idnote_cat")%>&idnote=<%=rs_child.getString("idnote")%>">
                        <li id="contactCategory">
                          <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                          </span> <%=rs_child.getString("title")%>
                        </li>
                      </a>

                      <%
                          }
                        }
                      %>
                      <li id="contactCategory">
                        <div onclick="document.getElementById('add-note<%=rs.getString("idnote_cat")%>').style.display='block'" style="cursor: pointer">
                          <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                          </span><span class="material-icons" style="position: relative;top: 6px;font-weight: bold;">add</span>Add Note
                        </div>
                      </li>
                        <div id="add-note<%=rs.getString("idnote_cat")%>" class="modal">
                            <span onclick="document.getElementById('add-note<%=rs.getString("idnote_cat")%>').style.display='none'" class="close" title="Close Modal">&times;</span>
                            <form class="modal-content" action="AddNoteServlet" method="post">
                                <input type="text" name="idnote_cat" value="<%=rs.getString("idnote_cat")%>" style="display: none;">
                                <input type="text" name="idnote" value="<%=request.getParameter("idnote")%>" style="display: none;">
                                <div class="form-container">
                                    <h1>Add Note</h1>
                                    <hr>
                                    <div class="form-label"><label for="title"><b>Note Title</b></label><br></div>
                                    <input type="text" name="title" required>

                                    <div class="form-label"><label for="date"><b>Date</b></label><br></div>
                                    <input type="date" name="date" required><br>


                                    <div class="form-label"><label for="content"><b>Content</b></label></div>
                                    <textarea name="content" rows="20" cols="50"></textarea>

                                    <div class="clearfix">
                                        <button type="button" class="reset-btn" style="cursor: pointer;"
                                                onclick="document.getElementById('add-note<%=rs.getString("idnote_cat")%>').style.display='none'">
                                            Cancel
                                        </button>
                                        <button type="submit" class="confirm-btn" style="cursor: pointer">Confirm</button>
                                    </div>
                                </div>
                            </form>
                        </div>

                    </ul>

                    <script>
                    $(document).ready(function () {
                      $('#root-display').click(function(){
                        $('#display-menu').toggleClass("hide-menu");
                        $('#arrow-down').toggleClass("rotate-arrow-down");
                      });
                    });
                    </script>
                  </li>
                  <%
                      }
                      else
                      {
                  %>
                  <li>
                    <div id="root-hidden<%=rs.getString("idnote_cat")%>" style="cursor: pointer;padding: 2px 0;" >
                      <span id="arrow-hide<%=rs.getString("idnote_cat")%>" class="material-icons" style="position: relative;top: 5px;">
                        chevron_right
                      </span>
                      <b><%=rs.getString("category")%></b>
                      <span class="material-icons" style="position: relative;top: 6px;">notes
                      </span>
                    </div>

                    <ul id="hidden-menu<%=rs.getString("idnote_cat")%>" class="hidden-menu" style="list-style-type: none;line-height: 25px;padding: 7px 0;">
                      <%
                        sql_child = "SELECT * FROM cld.note where note_cat_id = ?";
                        stm_child = conn.prepareStatement(sql_child);
                        stm_child.setString(1, rs.getString("idnote_cat"));

                        rs_child = stm_child.executeQuery();

                        while (rs_child.next())
                        {
                          if (rs_child.getString("idnote").equals(request.getParameter("idnote")))
                          {
                      %>
                      <a href="note.jsp?idnote_cat=<%=rs.getString("idnote_cat")%>&idnote=<%=rs_child.getString("idnote")%>">
                        <li id="contactCategory" style="background-color: rgba(50,50,50,0.3);">
                          <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                          </span> <%=rs_child.getString("title")%>
                        </li>
                      </a>
                      <%
                      }
                      else {
                      %>

                      <a href="note.jsp?idnote_cat=<%=rs.getString("idnote_cat")%>&idnote=<%=rs_child.getString("idnote")%>">
                        <li id="contactCategory">
                          <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                          </span> <%=rs_child.getString("title")%>
                        </li>
                      </a>

                      <%
                          }
                        }
                      %>
                      <li id="contactCategory">
                        <div onclick="document.getElementById('add-note<%=rs.getString("idnote_cat")%>').style.display='block'" style="cursor: pointer">
                          <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                          </span><span class="material-icons" style="position: relative;top: 6px;font-weight: bold;">add</span>Add Note
                        </div>
                      </li>
                      <div id="add-note<%=rs.getString("idnote_cat")%>" class="modal">
                        <span onclick="document.getElementById('add-note<%=rs.getString("idnote_cat")%>').style.display='none'" class="close" title="Close Modal">&times;</span>
                        <form class="modal-content" action="AddNoteServlet" method="post">
                          <input type="text" name="idnote_cat" value="<%=rs.getString("idnote_cat")%>" style="display: none;">
                          <input type="text" name="idnote" value="<%=request.getParameter("idnote")%>" style="display: none;">
                          <div class="form-container">
                            <h1>Add Note</h1>
                            <hr>
                            <div class="form-label"><label for="title"><b>Note Title</b></label><br></div>
                            <input type="text" name="title" required>

                            <div class="form-label"><label for="date"><b>Date</b></label><br></div>
                            <input type="date" name="date" required><br>


                            <div class="form-label"><label for="content"><b>Content</b></label></div>
                            <textarea name="content" rows="20" cols="50"></textarea>

                            <div class="clearfix">
                              <button type="button" class="reset-btn" style="cursor: pointer;"
                                      onclick="document.getElementById('add-note<%=rs.getString("idnote_cat")%>').style.display='none'">
                                Cancel
                              </button>
                              <button type="submit" class="confirm-btn" style="cursor: pointer">Confirm</button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </ul>

                    <script>
                      $(document).ready(function () {
                        $('#root-hidden<%=rs.getString("idnote_cat")%>').click(function(){
                          $('#hidden-menu<%=rs.getString("idnote_cat")%>').toggleClass("show-menu");
                          $('#arrow-hide<%=rs.getString("idnote_cat")%>').toggleClass("rotate-arrow-hide");
                        });
                      });
                    </script>
                  </li>
                  <%
                      }
                    }
                  %>
                </ul>
              </nav>
              <div class="addnewcat" onclick="addnewcat()">
                <span class="material-icons" style="position: relative;top: 7px;font-weight: bold;">add</span> New Note Category
              </div>
            </td>

            <%
              String sql_note = "SELECT * FROM cld.note where idnote = ?";
              PreparedStatement stm_note = conn.prepareStatement(sql_note);
              stm_note.setString(1, request.getParameter("idnote"));

              ResultSet rs_note = stm_note.executeQuery();

            %>
            <td width="85%" style="vertical-align: top;" >
              <%
                if (rs_note.next())
                {
              %>
              <div id="note-area">
                <div style="border-bottom: 1px solid black;padding-bottom: 10px;padding-left: 10px;background-color: rgba(200,200,200,0.1);box-shadow: 0 0 5px 2px rgba(0, 0, 0, 0.2)">
                <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                </span> <%=rs_note.getString("title")%>
                  <div style="float:right; padding: 1px 10px;cursor: pointer;" onclick="document.getElementById('delete-confirm-container').style.display='block'" >
                    <span class="material-icons" style="position: relative;top: 5px;">delete</span>Delete Note
                  </div>
                  <div style="float:right; padding: 1px 10px;cursor: pointer;" onclick="document.getElementById('edit-note-area').style.display='block',
                document.getElementById('note-area').style.display='none'" >
                    <span class="material-icons" style="position: relative;top: 5px;">edit</span>Edit Note
                  </div>
                </div>
                <div style="padding:10px;">
                  Date : <%=rs_note.getString("date")%>
                </div>
                <div style="background-color: rgb(250, 235, 215);margin:10px; padding: 15px;">
                  <div class="content" style="">
                    <%=rs_note.getString("content")%>
                  </div>
                </div>
              </div>


              <div id="edit-note-area" style="display: none;">
                <form action="EditNoteServlet" method="post">
                  <input type="text" name="idnote" value="<%=rs_note.getString("idnote")%>" style="display: none;">
                  <input type="text" name="note_cat_id" value="<%=rs_note.getString("note_cat_id")%>" style="display: none;">
                <div style="border-bottom: 1px solid black;padding-bottom: 10px;padding-left: 10px;background-color: rgba(200,200,200,0.1);box-shadow: 0 0 5px 2px rgba(0, 0, 0, 0.2)">
                <span class="material-icons" style="position: relative;top: 6px;">sticky_note_2
                </span> <input type="text" name="title" value="<%=rs_note.getString("title")%>">

                  <div style="float:right;margin-right: 10px; padding:2px 10px;cursor: pointer;"
                       onclick="document.getElementById('edit-note-area').style.display='none',
                document.getElementById('note-area').style.display='block'">
                    <span class="material-icons" style="position: relative;top: 5px;">cancel</span>Cancel
                  </div>
                  <div style="float:right; padding:2px 10px;cursor: pointer;"
                       onclick="document.getElementById('save-note<%=rs_note.getString("idnote")%>').click()" >
                    <span class="material-icons" style="position: relative;top: 5px;">save</span>Save
                  </div>
                  <input id="save-note<%=rs_note.getString("idnote")%>" type="submit" hidden>

                </div>

                <div style="padding:10px;">
                  Date : <input type="date" name="date" value="<%=rs_note.getString("date")%>"
                                style="margin: 0;padding: 5px;font-size: 17px;width: 15%;">
                </div>

                <div style="background-color: rgb(250, 235, 215);margin:10px; padding: 0px;">
                  <div class="content" style="">
                     <textarea name="content" style="min-height: 800px;" id="content"><%=rs_note.getString("content")%></textarea>
                  </div>
                </div>
                </form>
              </div>

              <div id="delete-confirm-container" class="modal">
                <form class="confirm-form" action="DeleteNoteServlet" method="post">
                  <input type="text" name="idnote" value="<%=rs_note.getString("idnote")%>" style="display: none;">
                  <input type="text" name="idnote_cat" value="<%=request.getParameter("idnote_cat")%>" style="display: none;">
                  <div class="confirm-header">
                    Note Deletion <span style="float:right;font-size: 22px;cursor: pointer;margin-top: -5px;" onclick="document.getElementById('delete-confirm-container').style.display='none'">&times;</span>
                  </div>
                  <div class="confirm-text">
                    Are you sure you wish to delete <b><%=rs_note.getString("title")%></b> ?
                  </div>
                  <div class="confirm-form-but">
                    <button type="submit" name="button">Confirm</button>
                    <button type="button" onclick="document.getElementById('delete-confirm-container').style.display='none'">Cancel</button>
                  </div>
                </form>
              </div>
              <%
                }
              %>
            </td>
          </tr>
        </table>

      </div>


    </div>

    <div id="add-note-cat" class="modal">
      <span onclick="document.getElementById('add-note-cat').style.display='none'" class="close" title="Close Modal">&times;</span>
      <form class="modal-content" action="AddNoteCatServlet" method="post">
        <input type="text" name="idnote_cat" value="<%=request.getParameter("idnote_cat")%>" style="display: none;">
        <input type="text" name="idnote" value="<%=request.getParameter("idnote")%>" style="display: none;">
        <div class="form-container">
          <h1>New Note Category</h1>
          <hr>
          <div class="form-label"><label for="category"><b>Note Category Name</b></label><br></div>
          <input type="text" name="category" required>

          <div class="form-label"><label for="date"><b>Date</b></label><br></div>
          <input type="date" name="date" required><br>

          <div class="clearfix">
            <button onclick="document.getElementById('add-note-cat').style.display='none'" class="reset-btn">Cancel</button>
            <button type="submit" class="confirm-btn">Confirm</button>
          </div>
        </div>
      </form>
    </div>


    <div id="note1" class="modal">
      <span onclick="document.getElementById('note1').style.display='none'" class="close" title="Close Modal">&times;</span>
      <form class="modal-content" action="">
        <div class="form-container">
          <h1>Edit Note</h1>
          <hr>
          <div class="form-label"><label for="name"><b>Note Title</b></label><br></div>
          <input type="text" value="Note Title 1" name="name" required>

          <div class="form-label"><label for="date"><b>Date</b></label><br></div>
          <input type="date" value="2020-03-27" name="date" required><br>

          <div class="form-label"><label for="content"><b>Content</b></label></div>
          <textarea name="content" id="content">
            <h1>Hi</h1>

<p>how are you</p>

<p><span style="font-size:20px">this text is size 20</span></p>

<p>&nbsp;</p>
          </textarea>

          <div class="clearfix">
            <button type="reset" class="reset-btn">Reset</button>
            <button type="submit" class="confirm-btn">Update</button>
          </div>
        </div>
      </form>
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

    CKEDITOR.replace( 'content', {
        uiColor: '#9AB8F3',
        height: 500,

    });

    window.onclick = function(event) {
      let backContainer = document.getElementById('add-note');
      if (event.target == backContainer)
      {
        backContainer.style.display = "none";
      }
      let backContainer2 = document.getElementById('note1');
      if (event.target == backContainer2)
      {
        backContainer2.style.display = "none";
      }
      let backContainer3 = document.getElementById('add-note-cat');
      if (event.target == backContainer3)
      {
        backContainer3.style.display = "none";
      }
      let backContainer4 = document.getElementById('delete-confirm-container');
      if (event.target == backContainer4)
      {
        backContainer4.style.display = "none";
      }
    }

    function addnewcat()
    {
      document.getElementById('add-note-cat').style.display='block';
    }

  </script>
</html>
