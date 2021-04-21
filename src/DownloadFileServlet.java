import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;

@WebServlet(name = "DownloadFileServlet")
public class DownloadFileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idfile = request.getParameter("idfile");

        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cld",
                    "root","123456");
            String sql = "SELECT * FROM cld.file where idfile = ?";
            PreparedStatement stm = conn.prepareStatement(sql);

            stm.setString(1, idfile);

            ResultSet rs = stm.executeQuery();

            if (rs.next())
            {
                String fileName = rs.getString("fileName");
                Blob blob = rs.getBlob("data");
                InputStream inputStream = blob.getBinaryStream();

                int fileLength = inputStream.available();

                ServletContext context = getServletContext();

                // sets MIME type for the file download
                String mimeType = context.getMimeType(fileName);
                if (mimeType == null)
                    mimeType = "application/octet-stream";

                // set content properties and header attributes for the response
                response.setContentType(mimeType);
                response.setContentLength(fileLength);
                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", fileName);
                response.setHeader(headerKey, headerValue);

                byte[] buffer = new byte[100 * 1000 * 1000];
                inputStream.read(buffer);

                // writes the file to the client
                OutputStream outputStream = response.getOutputStream();
                outputStream.write(buffer);

                inputStream.close();
                outputStream.flush();
                outputStream.close();


            }

        }catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }
}
