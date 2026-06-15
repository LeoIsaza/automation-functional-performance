@customerServices
Feature: Test API create Customers

  Background:
    * url urlCustomers
    And def createCustomerBody = read('classpath:integration/features/customers/functional/request/createCustomerBody.json')


  Scenario Outline: Create new user _ <case>
    Given path 'users'
    * set createCustomerBody.name = <name>
    * set createCustomerBody.username = <username>
    * set createCustomerBody.email = <email>
    And request createCustomerBody
    When method POST
    Then status <expectedStatus>
    And match response.name == <name>
    And match response.username == <username>
    And match response.email == <email>

    Examples:
      | read('classpath:integration/features/customers/functional/data/createCustomers/createCustomer.json') |

