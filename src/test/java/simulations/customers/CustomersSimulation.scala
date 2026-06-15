package simulations.customers

import com.intuit.karate.gatling.PreDef.{karateFeature, karateProtocol}
import io.gatling.core.Predef.{Simulation, configuration, constantUsersPerSec, csv, openInjectionProfileFactory, scenario}

import scala.concurrent.duration.DurationInt
import scala.language.postfixOps

class CustomersSimulation extends Simulation{

  val feed = csv("integration/features/customers/performance/data/createCustomers/createCustomer.csv").circular

  val putCreateCustomer = scenario("Create Customers")
    .feed(feed)
    .exec(karateFeature("classpath:integration/features/customers/performance/feature/createCustomers.feature@performance=createCustomer"));

  val protocol = karateProtocol(
  )

  protocol.runner.karateEnv("perf")
  // 1 tps
  setUp(
    putCreateCustomer.inject(
      constantUsersPerSec(3) during (20 seconds),
      constantUsersPerSec(4) during (20 seconds),
      constantUsersPerSec(5) during (20 seconds),
      constantUsersPerSec(6) during (20 seconds)
      //constantUsersPerSec(7) during (1 minutes),
    ).protocols(protocol)
  ).maxDuration(5.minutes)
}