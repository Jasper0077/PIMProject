import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "EditEventServlet")
public class EditEventNCServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String color = request.getParameter("color");
        String eventID = request.getParameter("eventID");
        String calendar_id = request.getParameter("calendar_id");
        String calendarName = request.getParameter("calendarName");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "update cld.event set title = ?, color = ? where idevent = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, title);
            stm.setString(2, color);
            stm.setString(3, eventID);

            stm.execute();

            if (calendar_id != null)
                response.sendRedirect("calendar.jsp?idcalendar=" + calendar_id + "&cname=" + calendarName);
            else
                response.sendRedirect("calendarall.jsp");

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
