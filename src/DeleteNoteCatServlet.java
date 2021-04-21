import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "DeleteNoteCatServlet")
public class DeleteNoteCatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idnote_cat = request.getParameter("idnote_cat");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "delete from cld.note_cat " +
                    "where idnote_cat = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, idnote_cat);

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
