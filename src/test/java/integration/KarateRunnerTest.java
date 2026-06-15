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

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}


