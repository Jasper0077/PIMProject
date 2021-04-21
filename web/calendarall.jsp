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
    <meta charset="utf-8">
    <title>PIM Calendar</title>
    <link rel="stylesheet" href="css/calendarstyle.css">
    <link rel="stylesheet" href="fullcalendar/core/main.css">
    <link rel="stylesheet" href="fullcalendar/daygrid/main.css">
    <link rel="stylesheet" href="fullcalendar/timegrid/main.css">
    <link rel="stylesheet" href="fullcalendar/list/main.css">

    <script src="fullcalendar/core/main.js"></script>
    <script src="fullcalendar/daygrid/main.js"></script>
    <script src="fullcalendar/timegrid/main.js"></script>
    <script src="fullcalendar/list/main.js"></script>
    <script src="fullcalendar/interaction/main.js"></script>
    <script src="fullcalendar/moment/main.js"></script>
    <script src="scripts/calendarjs.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function(){
            var calendarE1 = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarE1, {
                plugins: ['dayGrid','timeGrid','list','interaction','moment'],
                defaultView: 'dayGridMonth', //set default calendar view

                //themeSystem: bootstrap,
                height: "auto",
                //contentHeight: "500", set the contentHeight if i wish to change the height of calendar
                header: {
                    left: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek',
                    center: 'title',
                },

                buttonText: {
                    month: 'Month',
                    week: 'Week',
                    day: 'Day',
                    today: 'TODAY',
                    list: 'Event List'
                },

                views: {
                    dayGridMonth: {
                        fixedWeekCount: false, //set to does not show fix 6 week for every month
                        columnHeaderFormat: {weekday: 'long'},
                    },

                    timeGridWeek: {
                        slotEventOverlap: false
                    },

                    timeGridDay: {
                        slotEventOverlap: false
                    }
                },
                <%
                  Class.forName("com.mysql.jdbc.Driver");
                  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld","root","123456");
                  String sql = null;
                  PreparedStatement stm = null;

                  sql = "SELECT * FROM cld.event where user_id = ?";
                  stm = conn.prepareStatement(sql);
                  stm.setString(1, (String) session.getAttribute("uid"));

                  ResultSet rs = stm.executeQuery();

                %>
                events: [
                    <%
                     while (rs.next())
                      {
                    %>
                    {
                        id: '<%=rs.getString("idevent")%>',
                        title: '<%=rs.getString("title")%>',
                        start: '<%=rs.getString("startDate")%>',
                        end: '<%=rs.getString("endDate")%>',
                        color: '<%=rs.getString("color")%>',
                        allDay: <%=rs.getString("allDay")%>
                    },
                    <%
                      }
                    %>
                ],


                eventDisplay: 'list-item',

                selectable: true, //a box of date area can be selected
                editable: true, //the event bar can be drag
                eventResizableFromStart: true,

                select: function(info)
                {
                    alert("Cannot Add Event in 'All Event Calendar'");
                },

                eventDrop: function(info){
                    //this function will be called when an event is dropped to another cell
                    // this is to check confirm
                    if (!confirm("Are you sure about this change?")) {
                        info.revert();
                    }
                    else {
                        alert("updated");
                        //1. update database, first find the target event by id
                        document.getElementById('eventDropID').value = info.event.id;
                        //2. get the start and end date using info.event.start.toISOString() and info.event.end.toISOString()
                        try {
                            //normally
                            document.getElementById('eventDropStart').value = info.event.start.toISOString();
                            document.getElementById('eventDropEnd').value = info.event.end.toISOString();
                            document.getElementById('eventDropAllday').value = info.event.allDay;
                            console.log(info.event.start.toISOString());
                            console.log(info.event.end.toISOString());
                            //update the database with new data
                        } catch (e) {
                            //if move the event from allDay to non allDay or vice versa
                            //use info.event.allDay to check the event is move to where
                            document.getElementById('eventDropAllday').value = info.event.allDay;
                            document.getElementById('eventDropEnd').value = null;
                            console.log(info.event.allDay);//false or true
                            console.log(info.event.end);//null
                            //update the database with new info.event.start.toISOString() for start date,
                            //and "null" for end date, then update the allDay to info.event.allDay
                        }
                        finally {
                            document.getElementById('eventDropSubmit').click();
                        }
                    }


                },

                eventResize: function(info) {

                    if (!confirm("Confirm to Change?")) {
                        info.revert();
                    }
                    else {
                        document.getElementById('eventDropID').value = info.event.id;
                        document.getElementById('eventDropStart').value = info.event.start.toISOString();
                        document.getElementById('eventDropEnd').value = info.event.end.toISOString();
                        document.getElementById('eventDropAllday').value = info.event.allDay;
                        document.getElementById('eventDropSubmit').click();
                    }
                },

                eventClick: function(info){
                    let eventTitle = info.event.title;
                    let eventID = info.event.id;
                    let color = info.event.backgroundColor;
                    document.getElementById('titleofevent').innerHTML = eventTitle;
                    document.getElementById('002').value = eventTitle;
                    document.getElementById('eventID').value = eventID; //set for update name
                    document.getElementById('eventid').value = eventID;//set for delete
                    document.getElementById(color).selected = 'true';
                    changeEditDpColor();
                    document.getElementById('confirm-text').innerHTML = "  Are you sure you wish to delete <b>" + eventTitle + "</b> ?";
                    showAction();

                    //if (confirm("Confirm Changes?")) {
                    //update database
                    //}

                }
            });

            calendar.render();
        });

    </script>
</head>
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

<div id="cnameDisplay" style="width: 76%;margin: auto;text-align:center;font-size: 45px;padding: 30px;border-bottom: 1px solid black;background-color: #ffe6cc;">
    <b>All Event Calendar</b>
</div>

<div class="container">
    <div class="backContainer" id="backContainer">
        <div class="formContainer" id="formContainer">
            <form action="AddEventServlet" onsubmit="return validateEvent()" method="post">
                <input id="startDate" type="text" name="startDate" value="" hidden>
                <input id="endDate" type="text" name="endDate" value="" hidden>
                <input name="calendar_id" value="<%=request.getParameter("idcalendar")%>" hidden>
                <input name="calendarName" value="<%=request.getParameter("cname")%>" hidden>
                <div class="eventFormHeader">
                    <span id="closeForm" onclick="unShow()">&times</span>
                    <b>Add Event</b>
                </div>
                <div class="eventFormContent">
                    <label for="title">Event Title: </label>
                    <input id="001" type="text" name="title" placeholder="Enter Event Title">

                    <label for="color">Color: </label><div id="colorSelectDisplay"></div>
                    <select id="colorSelect" name="color" onchange="changeDpColor()">
                        <option value="#007acc">Blue</option>
                        <option value="green">Green</option>
                        <option value="#cc0000">Red</option>
                        <option value="purple">Purple</option>
                        <option value="#e65c00">Orange</option>
                        <option value="maroon">Maroon</option>
                        <option value="grey">Grey</option>
                        <option value="black">Black</option>
                        <option value="#ff33bb">Pink</option>
                    </select>

                </div>
                <div class="buttonContainer">
                    <input type="submit" name="submit" value="Add Event">
                    <input type="button" name="cancel" value="Cancel" onclick="unShow()">
                </div>
            </form>
        </div>
    </div>

    <div class="backContainer" id="eventEorD-Container">
        <div class="formContainer" style="width: 25%;">
            <div class="eventFormHeader">
                <span id="closeForm" onclick="unShow()">&times</span>
                <b id="titleofevent">Event</b>
            </div>
            <div class="eventFormContent">
                <div class="">
                    <button type="button" style="width: 100%;padding: 10px;" onclick="showEdit()">
                        <b>Edit Event Name</b>
                    </button>
                </div>
                <div class="">
                    <button type="button" style="width: 100%;padding: 10px;" onclick="unShow(), showDelete()"><b>Delete Event</b></button>
                </div>
            </div>
        </div>
    </div>

    <div class="backContainer" id="edit-event-name">
        <div class="formContainer">
            <form action="EditEventNCServlet" method="post" onsubmit="return validateEditEvent()">
                <input type="text" id="eventID" name="eventID" value="" hidden>
                <div class="eventFormHeader">
                    <span id="closeForm" onclick="unShow()">&times</span>
                    <b>Edit Event</b>
                </div>
                <div class="eventFormContent">
                    <label for="title">Edit Event Title: </label>
                    <input id="002" type="text" name="title" value="">

                    <label for="color">Edit Color: </label><div id="colorEditDisplay" style="width: 95%;"></div>
                    <select id="colorEdit" name="color" onchange="changeEditDpColor()">
                        <option id="#007acc" value="#007acc">Blue</option>
                        <option id="green" value="green">Green</option>
                        <option id="#cc0000" value="#cc0000">Red</option>
                        <option id="purple" value="purple">Purple</option>
                        <option id="#e65c00" value="#e65c00">Orange</option>
                        <option id="maroon" value="maroon">Maroon</option>
                        <option id="grey" value="grey">Grey</option>
                        <option id="black" value="black">Black</option>
                        <option id="#ff33bb" value="#ff33bb">Pink</option>
                    </select>

                </div>
                <div class="buttonContainer">
                    <input type="button" name="cancel" value="Previous" style="float:left; width: 90px;margin-left: 15px;" onclick="unShow(),showAction()">
                    <input type="submit" name="submit" value="Update">
                    <input type="button" name="cancel" value="Cancel" onclick="unShow()">
                </div>
            </form>
        </div>
    </div>

    <div id="delete-confirm-container" class="backContainer">
        <form class="confirm-form" action="DeleteEventServlet" method="post">
            <input type="text" id="eventid" name="eventID" value="" hidden>
            <div class="confirm-header">
                Event Deletion <span style="float:right;font-size: 22px;cursor: pointer;margin-top: -5px;" onclick="document.getElementById('delete-confirm-container').style.display='none'">&times;</span>
            </div>
            <div class="confirm-text" id="confirm-text">
                Are you sure you wish to delete this event?
            </div>
            <div class="confirm-form-but">
                <button type="submit" name="button">Confirm</button>
                <button type="button" onclick="document.getElementById('delete-confirm-container').style.display='none'">Cancel</button>
            </div>
        </form>
    </div>

    <form hidden action="EditEventDropServlet" method="post">
        <input type="text" id="eventDropID" name="eventDropID" value="">
        <input type="text" id="eventDropStart" name="eventDropStart" value="">
        <input type="text" id="eventDropEnd" name="eventDropEnd" value="">
        <input type="text" id="eventDropAllday" name="eventDropAllday" value="">
        <input type="submit" id="eventDropSubmit">
    </form>

    <div style="width: 80%; margin: auto;padding:10px 0;">
        <div id="calendar"></div>
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
</html>
