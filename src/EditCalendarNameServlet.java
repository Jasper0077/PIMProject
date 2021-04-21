import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "EditCalendarNameServlet")
public class EditCalendarNameServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idcalendar = request.getParameter("idcalendar");
        String calendarName = request.getParameter("calendarName");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "update cld.calendar set calendarName = ? where idcalendar = ?";

            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, calendarName);
            stm.setString(2, idcalendar);

            stm.execute();

            response.sendRedirect("calendar.jsp?idcalendar=" + idcalendar + "&cname=" + calendarName);

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
