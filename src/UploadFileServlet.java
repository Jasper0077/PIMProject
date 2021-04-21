import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@MultipartConfig

@WebServlet(name = "UploadFileServlet")
public class UploadFileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idcollection = request.getParameter("idcollection");
        String collectionName = request.getParameter("collectionName");
        String fileName = request.getParameter("fileName");
        String type = request.getParameter("type");
        String size = request.getParameter("size");

        InputStream inputStream = request.getPart("data").getInputStream();

        HttpSession session = request.getSession();
        String uid = (String)session.getAttribute("uid");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "insert into cld.file(fileName, data, type, size, collection_id, user_id) " +
                    "values(?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, fileName);
            stm.setBlob(2, inputStream);
            stm.setString(3, type);
            stm.setString(4, size);
            stm.setString(5, idcollection);
            stm.setString(6, uid);

            stm.execute();

            response.sendRedirect("collection.jsp?idcollection=" + idcollection + "&collectionName=" + collectionName);

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
