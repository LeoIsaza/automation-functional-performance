@customerServices
Feature: Test API Get Customers

  Background:
    * url urlCustomers

  Scenario Outline: Get user by ID _ <case>
    Given path 'users', <customerId>
    When method GET
    Then status <expectedStatus>
    And match response.id == <customerId>
    And match response.name != null
    Examples:
      | read('classpath:integration/features/customers/functional/data/queryCustomers/queryCustomer.json') |

  Scenario Outline: Get user by ID Failed _ <case>
    Given path 'users', <customerId>
    When method GET
    Then status <expectedStatus>
    And match response.id == '#notpresent'
    And match response.name == '#notpresent'
    Examples:
      | read('classpath:integration/features/customers/functional/data/queryCustomers/queryCustomerFailed.json') |


