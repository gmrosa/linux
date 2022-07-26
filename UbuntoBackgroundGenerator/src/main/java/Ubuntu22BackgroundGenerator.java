import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.StringJoiner;

public class Ubuntu22BackgroundGenerator {

    private static final Float DURATION = 3600.0f;
    private static final String jammy = "jammy.xml";
    private static final String dir = "/usr/share/backgrounds";

    public static void main(String[] args) throws URISyntaxException, IOException {
        String jammyTemplate = getJammyTemplate();
        String photoTemplate = getPhotoTemplate();
        StringJoiner joiner = new StringJoiner(System.lineSeparator());

        Arrays.stream(new File(dir).listFiles())
                .filter(file -> file.isFile())
                .forEach(file -> joiner.add(photoTemplate
                        .replace("$duration", DURATION.toString())
                        .replace("$photo", dir + File.separator + file.getName())));

        String xml = jammyTemplate.replace("$photos", joiner.toString());

        Files.write(Paths.get(dir + File.separator + "contest" + File.separator + jammy), xml.getBytes());
        System.out.println(xml);
    }

    public static String getJammyTemplate() throws URISyntaxException, IOException {
        return getResourceAsString(jammy);
    }

    public static String getPhotoTemplate() throws URISyntaxException, IOException {
        return getResourceAsString("photo.xml");
    }

    public static String getResourceAsString(String resource) throws URISyntaxException, IOException {
        return Files.readString(Paths.get(Ubuntu22BackgroundGenerator.class.getResource(resource).toURI()));
    }
}
