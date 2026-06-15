package simulations.queryAcBal

import com.intuit.karate.gatling.PreDef.{karateFeature, karateProtocol}
import io.gatling.core.Predef.{Simulation, configuration, constantUsersPerSec, csv, openInjectionProfileFactory, scenario}

import scala.concurrent.duration.{DurationDouble, DurationInt}
import scala.language.postfixOps

class consultaSaldoConsolidadoSimulation extends Simulation{

  val feed = csv("integration/features/queryAcVal/data/queryAcBalServicePass.csv").circular

  val getconsultaSaldoConsolidado = scenario("CONSULTAR SALDO CONSOLIDADO")
    .feed(feed)
    .exec(karateFeature("classpath:integration/features/queryAcVal/feature/query_ac_bal.feature@performance=queriAcBal"));

  val protocol = karateProtocol(

  )

  protocol.runner.karateEnv("dev")
  // 1 tps
  setUp(
    getconsultaSaldoConsolidado.inject(
      constantUsersPerSec(5) during ( 5 minutes),
      //constantUsersPerSec(20) during (1 minutes),
      //constantUsersPerSec(30) during (1 minutes),
      //constantUsersPerSec(40) during (1 minutes),
      //constantUsersPerSec(50) during (1 minutes),
      //constantUsersPerSec(60) during (1  minutes),
      //constantUsersPerSec(70) during (1  minutes),
      //constantUsersPerSec(80) during (1  minutes),
      //constantUsersPerSec(90) during (1  minutes),
      //constantUsersPerSec(100) during (1  minutes),

    ).protocols(protocol)
  ).maxDuration(5.minutes)
}