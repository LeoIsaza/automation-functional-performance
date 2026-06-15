Feature: Performance Test API consultar Customers

  Background:
    * url urlCustomers
    * def util = Java.type('integration.Utils')

  @performance=queryCustomer
  Scenario: Performance Create Customer
    * def customerId = karate.get('__gatling.customerId','Prueba')
    Given path 'users', customerId
    When method GET
    Then status 200
    * util.guardarDatos(' _____RESPONSE ' +karate.pretty(response))
    And match response.id == Number(customerId)
    And match response.name != null

