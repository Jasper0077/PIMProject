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

@WebServlet(name = "AddNoteServlet")
public class AddNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String date = request.getParameter("date");
        String note_cat_id = request.getParameter("idnote_cat");
        String idnote = request.getParameter("idnote");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "insert into cld.note(title, content, date, note_cat_id) " +
                    "values(?, ?, ?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, title);
            stm.setString(2, content);
            stm.setString(3, date);
            stm.setString(4, note_cat_id);

            stm.execute();

            response.sendRedirect("note.jsp?idnote_cat=" + note_cat_id + "&idnote=" + idnote);

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
