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
import java.sql.ResultSet;

@WebServlet(name = "SignUpServlet")
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String position = request.getParameter("position");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "SELECT username FROM cld.users where username = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, username);

            ResultSet rs = stm.executeQuery();

            if (rs.next())
            {
                request.getRequestDispatcher("signup.jsp").include(request,response);
                response.getWriter().println("<script>alert('Sorry! Username has been used.')</script>");
            }
            else
            {
                String sql_v = "insert into cld.users(username, password, gender, phone, email, address," +
                        "name, position) values (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stm_v = conn.prepareStatement(sql_v);

                stm_v.setString(1, username);
                stm_v.setString(2, password);
                stm_v.setString(3, gender);
                stm_v.setString(4, phone);
                stm_v.setString(5, email);
                stm_v.setString(6, address);
                stm_v.setString(7, name);
                stm_v.setString(8, position);

                stm_v.execute();

                HttpSession session = request.getSession();
                session.setAttribute("username",username);
                session.setAttribute("uid", rs.getString("id"));

                response.sendRedirect("index.jsp");
            }

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
