package datos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_NAME = "relaxzone";
    private static final String SERVER_URL = "jdbc:mysql://localhost:3306/"
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&serverTimezone=UTC"
            + "&characterEncoding=UTF-8";
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/" + DB_NAME
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&serverTimezone=UTC"
            + "&characterEncoding=UTF-8";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            throw new SQLException("No se encontró el driver de MySQL. Revisa que mysql-connector-j esté instalado en el proyecto.", ex);
        }

        String url = getConfig("RELAXZONE_DB_URL", DEFAULT_URL);
        String user = getConfig("RELAXZONE_DB_USER", "root");
        String password = getConfig("RELAXZONE_DB_PASSWORD", "Kevin_11");

        try {
            Connection connection = DriverManager.getConnection(url, user, password);
            ensureTables(connection);
            return connection;
        } catch (SQLException ex) {
            String message = ex.getMessage() == null ? "" : ex.getMessage().toLowerCase();
            if (!message.contains("unknown database")) {
                throw ex;
            }

            createDatabase(user, password);
            Connection connection = DriverManager.getConnection(DEFAULT_URL, user, password);
            ensureTables(connection);
            return connection;
        }
    }

    private static void createDatabase(String user, String password) throws SQLException {
        try (Connection connection = DriverManager.getConnection(SERVER_URL, user, password);
                java.sql.Statement statement = connection.createStatement()) {
            statement.executeUpdate("CREATE DATABASE IF NOT EXISTS " + DB_NAME
                    + " CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
        }
    }

    private static void ensureTables(Connection connection) throws SQLException {
        String usuariosSql = "CREATE TABLE IF NOT EXISTS usuarios ("
        + "id INT AUTO_INCREMENT PRIMARY KEY,"
        + "nombres VARCHAR(100) NOT NULL,"
        + "apellidos VARCHAR(100) NOT NULL,"
        + "fecha_nacimiento DATE NOT NULL,"
        + "correo VARCHAR(160) NOT NULL UNIQUE,"
        + "nombre_usuario VARCHAR(80) NOT NULL UNIQUE,"
        + "password_hash VARCHAR(64) NOT NULL,"
        + "foto_perfil VARCHAR(500) NULL,"
        + "sitio_web VARCHAR(500) NULL,"
        + "biografia TEXT NULL,"
        + "talentos TEXT NULL,"
        + "genero VARCHAR(30) NULL,"
        + "intereses TEXT NULL,"
        + "fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP"
        + ")";
        
        String publicacionesSql = "CREATE TABLE IF NOT EXISTS comunidad_publicaciones ("
            + "id INT AUTO_INCREMENT PRIMARY KEY,"
            + "usuario_id INT NOT NULL,"
            + "tipo VARCHAR(50) NOT NULL,"
            + "contenido TEXT NOT NULL,"
            + "fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,"
            + "FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE"
            + ")";

        String talentosSql = "CREATE TABLE IF NOT EXISTS comunidad_talentos ("
            + "id INT AUTO_INCREMENT PRIMARY KEY,"
            + "usuario_id INT NOT NULL UNIQUE,"
            + "talento TEXT NULL,"
            + "busca TEXT NULL,"
            + "fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,"
            + "FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE"
            + ")";


        try (java.sql.Statement statement = connection.createStatement()) {
        statement.executeUpdate(usuariosSql);
        statement.executeUpdate(publicacionesSql);
        statement.executeUpdate(talentosSql);
    }
    }

    private static String getConfig(String name, String defaultValue) {
        String value = System.getenv(name);
        if (value == null || value.trim().isEmpty()) {
            value = System.getProperty(name);
        }
        return value == null || value.trim().isEmpty() ? defaultValue : value;
    }
}
