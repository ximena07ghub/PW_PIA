import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

    public static String hash(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encoded = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder result = new StringBuilder();

            for (byte b : encoded) {
                result.append(String.format("%02x", b));
            }

            return result.toString();
        } catch (NoSuchAlgorithmException ex) {
            throw new IllegalStateException("No se pudo cifrar la contraseña.", ex);
        }
    }
}
