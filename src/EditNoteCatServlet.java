import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "EditNoteCatServlet")
public class EditNoteCatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        String idnote_cat = request.getParameter("idnote_cat");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "update cld.note_cat set category = ? " +
                    "where  idnote_cat = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, category);
            stm.setString(2, idnote_cat);

            stm.execute();

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
