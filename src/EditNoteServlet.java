import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "EditNoteServlet")
public class EditNoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idnote = request.getParameter("idnote");
        String note_cat_id = request.getParameter("note_cat_id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String date = request.getParameter("date");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "update cld.note set title = ?, content = ?, date = ?, note_cat_id = ? " +
                    "where  idnote = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, title);
            stm.setString(2, content);
            stm.setString(3, date);
            stm.setString(4, note_cat_id);
            stm.setString(5, idnote);

            stm.execute();

            response.sendRedirect("note.jsp?idnote_cat=" + note_cat_id +"&idnote=" + idnote);

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
