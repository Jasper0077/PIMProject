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

@WebServlet(name = "AddNoteCatServlet")
public class AddNoteCatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        String date = request.getParameter("date");

        String note_cat_id = request.getParameter("idnote_cat");
        String idnote = request.getParameter("idnote");

        HttpSession session = request.getSession();
        String uid = (String) session.getAttribute("uid");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "insert into cld.note_cat(category, date, user_id) " +
                    "values(?, ?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, category);
            stm.setString(2, date);
            stm.setString(3, uid);

            stm.execute();

            if (note_cat_id != null && idnote !=null)
                response.sendRedirect("note.jsp?idnote_cat=" + note_cat_id + "&idnote=" + idnote);

            else if (note_cat_id != null)
                response.sendRedirect("note.jsp?idnote_cat=" + note_cat_id);

            else
                response.sendRedirect("notelist.jsp");

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
