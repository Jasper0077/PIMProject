import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "AddEventServlet")
public class AddEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String color = request.getParameter("color");
        String calendar_id = request.getParameter("calendar_id");
        String calendarName = request.getParameter("calendarName");

        HttpSession session = request.getSession();
        String uid = (String) session.getAttribute("uid");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "insert into cld.event(title, startDate, endDate, color, calendar_id, user_id) " +
                    "values(?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, title);
            stm.setString(2, startDate);
            stm.setString(3, endDate);
            stm.setString(4, color);
            stm.setString(5, calendar_id);
            stm.setString(6, uid);

            stm.execute();

            response.sendRedirect("calendar.jsp?idcalendar=" + calendar_id + "&cname=" + calendarName);

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
