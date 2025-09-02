@Regresion  @adalconService @adalconFuntional

Feature: Automatización para el servicio SOAP de Alta de Contrato ADALCON

  Background:
    * def util = Java.type('integration.Utils')
    Given url adalconUrl
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }
    * def body = read('classpath:integration/features/adalconService/request/adalcon.txt')

  Scenario Outline: Realizar un alta de contrato exitosa y validar la respuesta
    Given headers headers
    * def body = body.replaceAll('#(usuario)', <usuario>)
    * def body = body.replaceAll('#(password)', <password>)
    * def body = body.replaceAll('#(numper)', <numper>)
    * def body = body.replaceAll('#(nombenredtar)', <nombenredtar>)
    And request body
    When method POST
    Then status 200
    And match util.extractValuesXml(response, "retorno") == '0000'
    And match util.extractValuesXml(response, "descRetorno") == 'OK'
    And match util.extractValuesXml(response, "calparttar") == 'TI'
    And match util.extractValuesXml(response, "numper") == <numper>
    And match util.extractValuesXml(response, "nombenredtar") == <nombenredtar>

    Examples:
      | read('classpath:integration/features/adalconService/data/adalconServicePass.json') |

