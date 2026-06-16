package integration;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import io.qameta.allure.karate.AllureKarate;

import static org.junit.jupiter.api.Assertions.*;

class KarateRunnerTest {

    @org.junit.jupiter.api.Test
    void testParallel() {
        Results results = Runner.path("classpath:integration/features")
                .hook(new AllureKarate())
                .parallel(10);

        if (results.getFailCount() > 0) {
            System.out.println("❌ Tests fallaron:");
            System.out.println(results.getErrorMessages());
        } else {
            System.out.println("✅ Tests OK");
        }

        // ✅ Generar Allure report automáticamente
        generateAllureReport();
    }

    private void generateAllureReport() {
        try {
            System.out.println("🚀 Generando Allure report...");
            System.out.println("PATH: " + System.getenv("PATH"));

            ProcessBuilder processBuilder = new ProcessBuilder(
                    "allure.bat",
                    "generate",
                    "target/allure-results",
                    "--clean",
                    "-o",
                    "allure-report"
            );

            processBuilder.inheritIO(); // muestra logs en console
            Process process = processBuilder.start();
            int exitCode = process.waitFor();

            if (exitCode == 0) {
                System.out.println("✅ Allure report generado correctamente");
            } else {
                System.out.println("❌ Error generando Allure report");
            }

        } catch (Exception e) {
            System.out.println("❌ Exception al generar Allure report:");
            e.printStackTrace();
        }
    }
}
