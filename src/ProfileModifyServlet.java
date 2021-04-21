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

@WebServlet(name = "ProfileModifyServlet")
public class ProfileModifyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gender = request.getParameter("gender");
        String birthday = request.getParameter("birthday");
        String university = request.getParameter("university");
        String home_town = request.getParameter("home_town");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String facebook = request.getParameter("facebook");
        String instagram = request.getParameter("instagram");
        String twitter = request.getParameter("twitter");
        String name = request.getParameter("name");
        String position = request.getParameter("position");
        String area = request.getParameter("area");
        String skill = request.getParameter("skill");
        String pwork = request.getParameter("pwork");
        String pworkAdd = request.getParameter("pworkAdd");
        String swork = request.getParameter("swork");
        String sworkAdd = request.getParameter("sworkAdd");

        HttpSession session = request.getSession();
        String uid = (String)session.getAttribute("uid");


        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "update cld.users set gender = ?, birthday = ?, university = ?, home_town = ?," +
                    " phone = ?, email = ?, address = ?, facebook = ? ,instagram = ?, twitter = ?, name = ?," +
                    " position = ?, area = ?, skill = ?, pwork = ?, pworkAdd = ?, swork = ?, sworkAdd = ? " +
                    "where users.id = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, gender);
            stm.setString(2, birthday);
            stm.setString(3, university);
            stm.setString(4, home_town);
            stm.setString(5, phone);
            stm.setString(6, email);
            stm.setString(7, address);
            stm.setString(8, facebook);
            stm.setString(9, instagram);
            stm.setString(10, twitter);
            stm.setString(11, name);
            stm.setString(12, position);
            stm.setString(13, area);
            stm.setString(14, skill);
            stm.setString(15, pwork);
            stm.setString(16, pworkAdd);
            stm.setString(17, swork);
            stm.setString(18, sworkAdd);
            stm.setString(19, uid);

            stm.execute();

            response.sendRedirect("index.jsp");

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
