package example;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

class TestRunner {

        @Karate.Test
        Karate runAdaltarTests() {
                return Karate.run("classpath:features/adaltar.feature");
        }
        @Karate.Test
        Karate runFlaldmiTests() {
                return Karate.run("classpath:features/flaldmi.feature");
        }
        @Karate.Test
        Karate runFlalpagTests() {
                return Karate.run("classpath:features/flalpag.feature");
        }
        @Karate.Test
        Karate runFlcipanTests() {
                return Karate.run("classpath:features/flcipan.feature");
        }

        @Karate.Test
        Karate runFlclcctTests() {
                return Karate.run("classpath:features/flclcct.feature");
        }

        @Karate.Test
        Karate runFlcldisTests() {
                return Karate.run("classpath:features/flcldis.feature");
        }
        @Karate.Test
        Karate runFlclmfaTests() {
                return Karate.run("classpath:features/flclmfa.feature");
        }

        @Karate.Test
        Karate runFlclmnfTests() {
                return Karate.run("classpath:features/flclmnf.feature");
        }
        @Karate.Test
        Karate runFlcltcoTests() {
                return Karate.run("classpath:features/flcltco.feature");
        }
        @Karate.Test
        Karate runFlcocliTests() {
                return Karate.run("classpath:features/flcocli.feature");
        }
        @Karate.Test
        Karate runFlcosccTests() {
                return Karate.run("classpath:features/flcoscc.feature");
        }
        @Karate.Test
        Karate runFlmolinTests() {
                return Karate.run("classpath:features/flmolim.feature");
        }
        @Karate.Test
        Karate runFlmonttTests() {
                return Karate.run("classpath:features/flmontt.feature");
        }
        @Karate.Test
        Karate runFltireeTests() {
                return Karate.run("classpath:features/fltiree.feature");
        }
        @Karate.Test
        Karate runOpclautTests() {
                return Karate.run("classpath:features/opclaut.feature");
        }
        @Karate.Test
        Karate runOpclcccTests() {
                return Karate.run("classpath:features/opclccc.feature");
        }
        @Karate.Test
        Karate runOpclcuoTests() {
                return Karate.run("classpath:features/opclcuo.feature");
        }
        @Karate.Test
        Karate runOpclexpTests() {
                return Karate.run("classpath:features/opclext.feature");
        }
        @Karate.Test
        Karate runOpclmocTests() {
                return Karate.run("classpath:features/opclmoc.feature");
        }
        @Karate.Test
        Karate runTialbctTests() {
                return Karate.run("classpath:features/tialbct.feature");
        }
        @Karate.Test
        Karate runTicoblqTests() {
                return Karate.run("classpath:features/ticoblq.feature");
        }
        @Karate.Test
        Karate runTicolimTests() {
                return Karate.run("classpath:features/ticolim.feature");
        }
        @Karate.Test
        Karate runTimobloTests() {
                return Karate.run("classpath:features/timoblo.feature");
        }
        @Karate.Test
        Karate runOpclrmaTests() {
                return Karate.run("classpath:features/opclrma.feature");
        }
}