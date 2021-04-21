import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "DeleteOtherInfoServlet")
public class DeleteOtherInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String infoID = request.getParameter("infoID");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "delete from cld.user_other_info where iduser_other_info = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, infoID);

            stm.execute();

            response.sendRedirect("index.jsp");


        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
