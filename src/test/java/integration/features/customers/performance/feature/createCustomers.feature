Feature: Performance Test API create Customers

  Background:
    * url urlCustomers
    And def createCustomerBody = read('classpath:integration/features/customers/functional/request/createCustomerBody.json')
    * def util = Java.type('integration.Utils')

  @performance=createCustomer
  Scenario: Performance Create Customer
    Given path 'users'
    * def name = karate.get('__gatling.name','Prueba')
    * def username = karate.get('__gatling.username','Prueba') + util.getCont()
    * def email = karate.get('__gatling.email','Prueba')
    * set createCustomerBody.name = name
    * set createCustomerBody.username = username
    * set createCustomerBody.email = email
    And request createCustomerBody
    When method POST
    Then status 201
    * util.guardarDatos( ' ______REQUEST '+ karate.pretty(createCustomerBody) +' _____RESPONSE ' +karate.pretty(response))
    And match response.name == name
    And match response.username == username
    And match response.email == email

