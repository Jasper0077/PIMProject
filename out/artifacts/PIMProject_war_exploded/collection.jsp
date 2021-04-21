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
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
      <%@include file="/css/style.css" %>

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
        String sql = "SELECT * FROM cld.file where collection_id = ? " +
                "order by fileName ASC";

        PreparedStatement stm = conn.prepareStatement(sql);
        stm.setString(1, request.getParameter("idcollection"));

        ResultSet rs = stm.executeQuery();
      %>

    <!-- Content section -->
    <div class="wrapper">
      <div class="collection-title">
      <%=request.getParameter("collectionName")%>
        <div style='position: absolute;transform: translate(610px, -15px)'>
          <span class="material-icons" style="color: white;cursor: pointer;" onclick="editTitle()">
          edit
          </span>
          <span class="material-icons" style="color: white;cursor: pointer;" onclick="deleteNote()">
          delete
          </span>
        </div>
      </div>
      <!--hidden-->
      <div id="titleEdit" class="modal">
        <span onclick="cancelEdit()" class="close" title="Close Modal">&times;</span>
        <form class="modal-content" action="EditCollectionServlet" method="post">
          <input type="text" name="idcollection" value="<%=request.getParameter("idcollection")%>" style="display: none;">
          <div class="form-container">
            <h1>Rename Collection</h1>
            <hr>
            <div class="form-label"><label for="name"><b>Collection Name</b></label><br></div>
            <input type="text" name="collectionName" value="<%=request.getParameter("collectionName")%>" required>

            <div class="clearfix">
              <button type="reset" class="reset-btn">Reset</button>
              <button type="submit" class="confirm-btn">Confirm</button>
            </div>
          </div>
        </form>
      </div>
      <div id="delete-collection" class="modal">
        <form class="confirm-form" action="DeleteCollectionServlet" method="post">
          <input type="text" name="idcollection" value="<%=request.getParameter("idcollection")%>" style="display: none">
          <div class="confirm-header">
            Collection Deletion <span style="float:right;font-size: 22px;cursor: pointer;margin-top: -5px;" onclick="document.getElementById('delete-collection').style.display='none'">&times;</span>
          </div>
          <div class="confirm-text">
            Are you sure you wish to delete <b><%=request.getParameter("collectionName")%></b> ?
          </div>
          <div class="confirm-form-but">
            <button type="submit" name="button">Confirm</button>
            <button type="button" onclick="document.getElementById('delete-collection').style.display='none'">Cancel</button>
          </div>
        </form>
      </div>

    <div class="file_upload_list">
      <ul>
        <%
          while (rs.next())
          {
        %>
        <!-- File item 1 -->
        <li>
          <div class="file_item">
            <div class="format">
              <p><%=rs.getString("type")%></p>
            </div>
            <div class="file_progress">
              <div class="file_info">
                <a id="file_name" href="DownloadFileServlet?idfile=<%=rs.getString("idfile")%>">
                  <div>
                    <%=rs.getString("fileName")%>
                  </div>
                </a>
                <div class="file_size_wrap">
                  <div class="file_size" ><%=rs.getString("size")%></div>
                  <div onclick="confirmDelete('<%=rs.getString("idfile")%>')" class="file_close">X</div>
                </div>
              </div>
              <div class="progress">
                <div class="inner_progress" style="width: 100%;"></div>
              </div>
            </div>
          </div>
        </li>
        <%
          }
        %>
        </ul>
      </div>

      <!-- Choose File section -->
      <div class="choose_file">
      <form action="UploadFileServlet" method="post" enctype="multipart/form-data">
        <input type="text" name="idcollection" value="<%=request.getParameter("idcollection")%>" style="display: none;">
        <input type="text" name="collectionName" value="<%=request.getParameter("collectionName")%>" style="display: none;">
        <input id="fileName" type="text" name="fileName" value="" style="display: none;">
        <input id="type" type="text" name="type" value="" style="display: none;">
        <input id="size" type="text" name="size" value="" style="display: none;">

        <div style="width: 90%;margin: 10px auto;">
          <label for="choose_file">
            <div style="padding: 20px;">
              <input type="file" id="choose_file" name="data" onchange="updateDisplay()" required>
              <span>Choose Files</span>
            </div>
          </label>
          <div id="preview" style="border: 2px dashed #8178d3;border-bottom: none;line-height:30px;padding: 0 5px;">

          </div>
          <div style="display: flex;">
            <span class="material-icons" style="position: absolute;transform: translate(245px,12px);font-size: 25px;">
            backup
            </span>
            <input id="uploadButton" type="submit" name="" value="   Upload">
          </div>
        </div>
      </form>
      </div>

  </div>
    <!--Delete file section -->
    <div style="display: none">
      <form action="DeleteFileServlet" method="post">
        <input id="idfile" type="text" name="idfile" value="">
        <input id="idcollection" type="text" name="idcollection" value="">
        <input id="collectionName" type="text" name="collectionName" value="">
        <input id="delete-file" type="submit">
      </form>
    </div>
      <!--Delete file section -->

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
    function updateDisplay() {
      let input = document.getElementById('choose_file');
      let preview = document.getElementById('preview');

      while(preview.firstChild) {
        preview.removeChild(preview.firstChild);
      }

      let allfiles = input.files;

      if (allfiles.length === 0) {
        let para = document.createElement('p');
        para.textContent = 'No files are selected for upload';
        preview.appendChild(para);
      }
      else {

        let file = allfiles[0];

        let para = document.createElement('p');
        para.textContent = 'File Name: ' + file.name + ', Size: ' + returnFileSize(file.size);

        preview.appendChild(para);

        document.getElementById('fileName').value = file.name;
        document.getElementById('type').value = file.type;
        document.getElementById('size').value = returnFileSize(file.size);

      }
    }
    function returnFileSize(number) {
      if(number < 1024) {
        return number + 'bytes';
      } else if(number >= 1024 && number < 1048576) {
        return (number/1024).toFixed(1) + 'KB';
      } else if(number >= 1048576) {
        return (number/1048576).toFixed(1) + 'MB';
      }
    }

    function editTitle() {
      document.getElementById('titleEdit').style.display = 'block';
    }

    function cancelEdit() {
      document.getElementById('titleEdit').style.display = 'none';
    }

    function deleteNote() {
      document.getElementById('delete-collection').style.display = 'block';
    }

    function confirmDelete(data)
    {
      if (confirm('Are you sure to delete this file?'))
      {
        document.getElementById('idfile').value = data;
        document.getElementById('idcollection').value = '<%=request.getParameter("idcollection")%>';
        document.getElementById('collectionName').value = '<%=request.getParameter("collectionName")%>';
        document.getElementById('delete-file').click();
      }
    }

    window.onclick = function(event) {
      let backContainer = document.getElementById('delete-collection');
      if (event.target == backContainer)
      {
        backContainer.style.display = "none";
      }
      let backContainer1 = document.getElementById('titleEdit');
      if (event.target == backContainer1)
      {
        backContainer1.style.display = "none";
      }
    }
  </script>
</html>
