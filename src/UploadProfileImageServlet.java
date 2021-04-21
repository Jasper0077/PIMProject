import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@MultipartConfig

@WebServlet(name = "UploadProfileImageServlet")
public class UploadProfileImageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String uid = (String)session.getAttribute("uid");

        InputStream inputStream = request.getPart("profileImageInput").getInputStream();

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "update cld.users set image = ? where id = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setBlob(1, inputStream);
            stm.setString(2, uid);

            stm.execute();

            response.sendRedirect("index.jsp");

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
