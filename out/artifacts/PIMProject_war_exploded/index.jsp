<%@ page import="java.sql.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.FileOutputStream" %>

<%
  if (session.getAttribute("username") == null)
    response.sendRedirect("home.jsp");
%>

<html>
  <head>
    <title>PIM Profile</title>
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
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  </head>
  <!-- This is header section -->
  <body>
    <div class="menu">
      <ul>
        <a href="index.jsp"><li class="logo"><img src="img/home.png"></li></a>
        <a href="calendarlist.jsp"><li>Calendar</li></a>
        <a href="contact.jsp"><li>Contact</li></a>
        <a href="notelist.jsp"><li>Note</li></a>
        <a href="collectionlist.jsp"><li>Collection</li></a>
        <a href="index.jsp"><li class="active">Profile</li></a>
        <li><a href="LogOutServlet" class="signup-btn" style="color: white;"><span>Log Out</span></a></li>
      </ul>
    </div>

    <div class="container">
    <!-- Content section -->
      <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld","root","123456");
        String sql = "select * from\n" +
                "(SELECT * FROM cld.users where users.id = ?) as T left join " +
                "(select * from cld.user_other_info where user_id =?) as P on id = user_id";
        PreparedStatement stm = conn.prepareStatement(sql);

        stm.setString(1,(String)session.getAttribute("uid"));
        stm.setString(2,(String)session.getAttribute("uid"));

        ResultSet rs = stm.executeQuery();

        if(rs.next())
        {
      %>
      <div class="profile-container" id="myprofile">
        <div class="profile-left">
          <div class="profile-photo" style="padding-bottom: 10px;">
            <%
              if(rs.getBlob("image") == null)
              {
            %>
              <img src="img/ironman.jpg" alt="">
            <%
              }
              else
              {
                byte[] buffer = new byte[100 * 1024 * 1024];
                InputStream inputStream = rs.getBlob("image").getBinaryStream();
                inputStream.read(buffer);

                String path = request.getSession().getServletContext().getRealPath("/uploads/" + rs.getString("id") + ".png");

                OutputStream outputStream = new FileOutputStream(path);
                outputStream.write(buffer);
                outputStream.flush();
                outputStream.close();
            %>
              <img src="uploads/<%=rs.getString("id")%>.png" alt="">
            <%
              }
            %>

          </div>
          <div class="block">
            <div class="block-content">
              <div style="display: inline-block;font-size: 12px;color: #8c8c8c;">
                  WORK
              </div>
              <div class="line" style="width: 87%;">
              </div>
            </div>

            <div class="block-content">
              <div class="content-header">
                <%=rs.getString("pwork")%>
                <div style="float: right;background-color: #cceeff;padding:10px;color: #0099ff;font-size: 14px;">
                  Primary
                </div>
              </div>
              <div class="content-text">
                <%=rs.getString("pworkAdd")%>
              </div>
            </div>
            <div class="block-content">
              <div class="content-header">
                <%=rs.getString("swork")%>
                <div style="float: right;background-color: #cceeff;padding:10px;color: #0099ff;font-size: 14px;">
                  Secondary
                </div>
              </div>
              <div class="content-text">
                <%=rs.getString("sworkAdd")%>
              </div>
            </div>
          </div>
          <div class="block">
            <div class="block-content">
              <div style="display: inline-block;font-size: 12px;color: #8c8c8c;">
                  SKILLS
              </div>
              <div class="line" style="width: 85%;">
              </div>
            </div>

            <div class="block-content">
              <div class="">
                <%=rs.getString("skill")%>
              </div>
            </div>
          </div>
        </div>
        <div class="profile-right">
          <div style="display: flex;">
            <h2><%=rs.getString("name")%></h2>
            <div style="padding: 7px 20px;font-size:13px;color: #8c8c8c;">
              <span class="material-icons" style="font-size:18px;position:relative; top:4;">
              place
              </span> <%=rs.getString("area")%>
            </div>
          </div>
          <div style="color: #0099ff;padding-bottom: 20px;">
            <%=rs.getString("position")%>
          </div>

          <div class="block">
            <div style="padding: 5px 0;">
              <div style="display: inline-block;font-size: 12px;color: #8c8c8c;">
                  RANKINGS
              </div>
            </div>
            <div>
              <div style="font-size: 20px;display: inline-block;">
                9.9
              </div>
              <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
              star
              </span>
              <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
              star
              </span>
              <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
              star
              </span>
              <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
              star
              </span>
              <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
              star
              </span>
            </div>
          </div>

          <div class="block">
            <div style="display: flex;">
              <div onclick="uploadProfileImage()" style="padding:5px 10px 14px 0;font-size: 14px;cursor: pointer;">
                <span class="material-icons" style="position: relative;top: 7;">
                portrait
                </span>
                Change Profile Photo
              </div>

              <div id="profileImageUploadContainer" class="modal" style="background-color: rgba(0,0,0,0.5);">
                <div style="width: 30%;margin: auto;background-color: white;">
                  <form action="UploadProfileImageServlet" method="post" enctype="multipart/form-data" onsubmit="return validateImageExist()">
                    <div>
                      <span style="float: right;font-size: 20px;margin: 10px;cursor: pointer;"
                            onclick="cancelImageUpload()">&times;
                      </span>
                    </div>
                    <div class="preview" style="margin: auto;padding: 20px;width: 70%;text-align: center;min-height: 250px;">
                      <p>Image Preview</p>
                    </div>
                    <div style="padding: 10px;">
                      <input type="file" id="profileImageInput" name="profileImageInput" onchange="updateImageDisplay()">
                      <input type="submit" value="Upload" style="padding: 5px;">
                      <button type="button" style="padding: 5px;" onclick="cancelImageUpload()">Cancel</button>
                    </div>
                  </form>
                </div>
              </div>

              <div style="background-color: #cceeff;margin-left: 20px;padding:8px 20px 0px 14px;font-size: 14px;cursor: pointer" onclick="edit()">
                <span class="material-icons" style="position: relative;top:4;font-size: 20px;">
                edit
                </span>
                Edit Info
              </div>
            </div>

          </div>


          <div style="padding: 20px 0;">
            <div style="border-bottom: 1px solid #8c8c8c;">
              <div style="border-bottom: 1.5px solid #0099ff;width: 10%;padding: 10px 0;font-size: 14px;">
                <span class="material-icons" style="position: relative;top:4;font-size: 20px;">
                person
                </span>
                 About
              </div>
            </div>
          </div>

          <div class="block">
            <div class="block-content">
              <div style="font-size: 12px;color: #8c8c8c;">
                  BASIC INFORMATION
              </div>
            </div>
            <div class="block-content">
              <table width="100%" style="line-height: 35px;">
                <tr>
                  <td width="17%">Gender: </td>
                  <td width="73%"><%=rs.getString("gender")%></td>
                  <td width="7%" style="font-size:13px;"></td>
                </tr>
                <tr>
                  <td>Birthday: </td>
                  <td><%=rs.getString("birthday")%></td>
                </tr>
                <tr>
                  <td>University: </td>
                  <td><%=rs.getString("university")%></td>
                </tr>
                <tr>
                  <td>Home Town: </td>
                  <td><%=rs.getString("home_town")%></td>
                </tr>
              </table>
            </div>
          </div>

          <div class="block">
            <div class="block-content">
              <div style="font-size: 12px;color: #8c8c8c;">
                  CONTACT INFORMATION
              </div>
            </div>
            <div class="block-content">
              <table width="100%" style="line-height: 35px;">
                <tr>
                  <td width="17%">Phone: </td>
                  <td width="73%"><%=rs.getString("phone")%></td>
                  <td width="7%" style="font-size:13px;"></td>
                </tr>
                <tr>
                  <td>Email:</td>
                  <td><%=rs.getString("email")%></td>
                </tr>
                <tr>
                  <td>Address: </td>
                  <td><%=rs.getString("address")%></td>
                </tr>
                <tr>
                  <td width="14%">Facebook: </td>
                  <td width="65%"><%=rs.getString("facebook")%></td>
                </tr>
                <tr>
                  <td width="14%">Instagram: </td>
                  <td width="65%"><%=rs.getString("instagram")%></td>
                </tr>
                <tr>
                  <td width="14%">Twitter: </td>
                  <td width="65%"><%=rs.getString("twitter")%></td>
                </tr>
              </table>
            </div>
          </div>

          <div class="block">
            <div class="block-content">
              <div style="font-size: 12px;color: #8c8c8c;">
                  OTHERS
                  <a href="#other_info_submit">
                    <span id="other_info_add" class="material-icons" style="font-size: 20px;position: relative; top: 5; margin-left: 5px;cursor: pointer" onclick="add_info()">
                      add_circle
                    </span>
                  </a>
              </div>
            </div>
            <div class="block-content">
              <form action="AddOtherInfoServlet" method="post">
              <table id="other_info_table" width="100%" style="line-height: 35px;">
                <%
                  do {
                %>
                <tr>
                  <td width="17%"><%=rs.getString("category")%>:</td>
                  <td width="73%"><%=rs.getString("value")%></td>
                  <td width="7%">
                    <a href="DeleteOtherInfoServlet?infoID=<%=rs.getString("iduser_other_info")%>">
                      <p id="removeHover" style="font-size: 13px;">remove</p>
                    </a>
                  </td>
                </tr>
                <%
                  }while (rs.next());

                  rs.absolute(1);
                %>
              </table>

              <div style="display: flex;">
                <button id="other_info_submit" type="submit" style="display: none;margin-right: 10px;padding: 5px;">Submit</button>
                <button id="other_info_cancel_submit" type="button" style="display: none;padding: 5px;" onclick="delete_add()">Cancel</button>
              </div>
              </form>
            </div>
          </div>

        </div>
      </div>

      <form id="editprofile" style="display: none" action="ProfileModifyServlet" method="post">
        <div class="profile-container">
          <div class="profile-left">

            <div class="block">
              <div class="block-content">
                <div style="display: inline-block;font-size: 12px;color: #8c8c8c;">
                    WORK
                </div>
                <div class="line" style="width: 87%;">
                </div>
              </div>

              <div class="block-content">
                <div class="content-header">
                  <input type="text" name="pwork" placeholder="Work" value="<%=rs.getString("pwork")%>" style="margin: 0;font-size: 20px;padding: 10px 2px;">
                  <div style="float: right;background-color: #cceeff;padding:10px;color: #0099ff;font-size: 14px;">
                    Primary
                  </div>
                </div>
                <div class="content-text">
                  <textarea name="pworkAdd" rows="8" cols="80" style="padding: 8px;"><%=rs.getString("pworkAdd")%></textarea>

                </div>
              </div>
              <div class="block-content">
                <div class="content-header">
                  <input type="text" name="swork" placeholder="Work" value="<%=rs.getString("swork")%>" style="margin: 0;font-size: 20px;padding: 10px 2px;">
                  <div style="float: right;background-color: #cceeff;padding:10px;color: #0099ff;font-size: 14px;">
                    Secondary
                  </div>
                </div>
                <div class="content-text">
                  <textarea name="sworkAdd" rows="8" cols="80" style="padding: 8px;"><%=rs.getString("sworkAdd")%></textarea>
                </div>
              </div>
            </div>
            <div class="block">
              <div class="block-content">
                <div style="display: inline-block;font-size: 12px;color: #8c8c8c;">
                    SKILLS
                </div>
                <div class="line" style="width: 85%;">
                </div>
              </div>

              <div class="block-content">
                <div>
                  <textarea name="skill" placeholder="Skills" rows="20" cols="60" style="padding: 8px;"><%=rs.getString("skill")%></textarea>
                </div>
              </div>
            </div>
          </div>

          <div class="profile-right">
            <div style="display: flex;">
              <h2><input type="text" name="name" placeholder="Name" value="<%=rs.getString("name")%>" style="margin: 0;font-size: 25px;padding: 10px;"></h2>
              <div style="display: flex;padding: 7px 20px;font-size:13px;color: #8c8c8c;">
                <span class="material-icons" style="font-size:18px;position:relative; top:15;">
                place
              </span> <input type="text" name="area" placeholder="Work Area" value="<%=rs.getString("area")%>" style="margin: 0;font-size: 15px;">
              </div>
            </div>
            <div style="color: #0099ff;padding-bottom: 20px;">
              <input type="text" name="position" placeholder="Position" value="<%=rs.getString("position")%>" style="margin: 0;width: 50%;font-size: 15px;">
            </div>

            <div class="block">
              <div style="padding: 5px 0;">
                <div style="display: inline-block;font-size: 12px;color: #8c8c8c;">
                    RANKINGS
                </div>
              </div>
              <div>
                <div style="font-size: 20px;display: inline-block;">
                  9.9
                </div>
                <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
                star
                </span>
                <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
                star
                </span>
                <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
                star
                </span>
                <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
                star
                </span>
                <span class="material-icons" style="position: relative;top: 4;color: #008ae6;">
                star
                </span>
              </div>
            </div>

            <div class="block">
              <div style="display: flex;">
                <button type="submit" style="background-color: #cceeff;margin-left: 0px;padding:14px 22px 12px 16px;font-size: 14px;display: flex;width: 100px;border: none;cursor: pointer;">
                  <span class="material-icons" style="font-size: 20px;padding:0;position: relative;bottom: 1;margin-right:4px;">
                  save
                  </span>
                  Save
                </button>
              </div>

            </div>


            <div style="padding: 20px 0;">
              <div style="border-bottom: 1px solid #8c8c8c;">
                <div style="border-bottom: 1.5px solid #0099ff;width: 10%;padding: 10px 0;font-size: 14px;">
                  <span class="material-icons" style="position: relative;top:4;font-size: 20px;">
                  person
                  </span>
                   About
                </div>
              </div>
            </div>

            <div class="block">
              <div class="block-content">
                <div style="font-size: 12px;color: #8c8c8c;">
                    BASIC INFORMATION
                </div>
              </div>
              <div class="block-content">
                <table width="100%" style="line-height: 35px;">
                  <tr>
                    <td width="17%">Gender: </td>
                    <td width="73%">
                      <select name="gender" style="width: 30%;padding: 2px;font-size: 15px;">
                        <%
                          if (rs.getString("gender").equals("Male"))
                          {
                        %>
                        <option value="Male" selected>Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                        <%
                          }else if (rs.getString("gender").equals("Female"))
                          {
                        %>
                        <option value="Male">Male</option>
                        <option value="Female" selected>Female</option>
                        <option value="Other">Other</option>
                        <%
                          }else
                          {
                        %>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other" selected>Other</option>
                        <%
                          }
                        %>
                      </select>
                    </td>
                    <td width="7%" style="font-size:13px;"></td>
                  </tr>
                  <tr>
                    <td>Birthday: </td>
                    <td>
                      <input type="date" name="birthday" value="<%=rs.getString("birthday")%>" style="margin: 0;width: 30%;padding: 0;font-size: 15px;color:grey;">
                    </td>
                  </tr>
                  <tr>
                    <td>University: </td>
                    <td>
                      <input type="text" name="university" value="<%=rs.getString("university")%>" style="margin: 0;font-size: 15px;">
                    </td>
                  </tr>
                  <tr>
                    <td>Home Town: </td>
                    <td>
                      <input type="text" name="home_town" value="<%=rs.getString("home_town")%>" style="margin: 0;font-size: 15px;">
                    </td>
                  </tr>
                </table>
              </div>
            </div>

            <div class="block">
              <div class="block-content">
                <div style="font-size: 12px;color: #8c8c8c;">
                    CONTACT INFORMATION
                </div>
              </div>
              <div class="block-content">
                <table width="100%" style="line-height: 35px;">
                  <tr>
                    <td width="17%">Phone: </td>
                    <td width="73%">
                      <input type="text" name="phone" value="<%=rs.getString("phone")%>" style="margin: 0;font-size: 15px;">
                    </td>
                    <td width="7%" style="font-size:13px;"></td>
                  </tr>
                  <tr>
                    <td>Email:</td>
                    <td>
                      <input type="text" name="email" value="<%=rs.getString("email")%>" style="margin: 0;font-size: 15px;">
                    </td>
                  </tr>
                  <tr>
                    <td>Address: </td>
                    <td>
                      <input type="text" name="address" value="<%=rs.getString("address")%>" style="margin: 0;font-size: 15px;">
                    </td>
                  </tr>
                  <tr>
                    <td width="14%">Facebook: </td>
                    <td width="65%">
                      <input type="text" name="facebook" value="<%=rs.getString("facebook")%>" style="margin: 0;font-size: 15px;">
                    </td>
                  </tr>
                  <tr>
                    <td width="14%">Instagram: </td>
                    <td width="65%">
                      <input type="text" name="instagram" value="<%=rs.getString("instagram")%>" style="margin: 0;font-size: 15px;">
                    </td>
                  </tr>
                  <tr>
                    <td width="14%">Twitter: </td>
                    <td width="65%">
                      <input type="text" name="twitter" value="<%=rs.getString("twitter")%>" style="margin: 0;font-size: 15px;">
                    </td>
                  </tr>
                </table>
              </div>
            </div>


          </div>
        </div>
      </form>

      <%
        }
      %>
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
  var x = 1;
  function edit()
  {
      document.getElementById('myprofile').style.display = 'none';
      document.getElementById('editprofile').style.display = 'block';
  }

  function save()
  {
    document.getElementById('myprofile').style.display = 'block';
    document.getElementById('editprofile').style.display = 'none';
  }

  function add_info()
  {
    let table = document.getElementById("other_info_table");
    let row = table.insertRow(table.rows.length);
    let cell1 = row.insertCell(0);
    let cell2 = row.insertCell(1);
    cell1.innerHTML = '<input type="text" name="otherCat" placeholder="Category">';
    cell2.innerHTML = '<input type="text" name="otherVal" placeholder="Value">';
    document.getElementById("other_info_submit").style.display = 'block';
    document.getElementById("other_info_cancel_submit").style.display = 'block';
    document.getElementById("other_info_add").style.display = 'none';
  }

  function delete_add()
  {
    let table = document.getElementById("other_info_table");
    table.deleteRow(table.rows.length - 1);
    document.getElementById("other_info_submit").style.display = 'none';
    document.getElementById("other_info_cancel_submit").style.display = 'none';
    document.getElementById("other_info_add").style.display = 'inline-block';
  }

  function uploadProfileImage() {
    let profileImageUploadContainer = document.getElementById('profileImageUploadContainer');
    profileImageUploadContainer.style.display = 'block';
  }
  
  function updateImageDisplay() {
    let preview = document.querySelector('.preview');
    let imageInput = document.getElementById('profileImageInput');

    while (preview.firstChild)
    {
      preview.removeChild(preview.firstChild);
    }

    let curr_files = imageInput.files;

    if (curr_files.length === 0)
    {
      let text = document.createElement('p');
      text.textContent = 'Image Preview';
      preview.appendChild(text);

    }
    else
    {
      let file = curr_files[0];

      if (validFileType(file))
      {
        let image = document.createElement('img');
        image.src = URL.createObjectURL(file);
        image.style.width = '100%';

        preview.appendChild(image);

      }
    }
  }
  const fileTypes = [
    "image/apng",
    "image/bmp",
    "image/gif",
    "image/jpeg",
    "image/pjpeg",
    "image/png",
    "image/svg+xml",
    "image/tiff",
    "image/webp",
    "image/x-icon"
  ];
  function validFileType(file) {
    return fileTypes.includes(file.type);
  }

  function cancelImageUpload() {
    let profileImageUploadContainer = document.getElementById('profileImageUploadContainer');
    profileImageUploadContainer.style.display = 'none';
  }

  function validateImageExist() {
    let imageInput = document.getElementById('profileImageInput');
    if (imageInput.files.length === 0)
    {
      alert('No Image is Selected !');
      return false;
    }
    return true;
  }

  </script>
</html>
