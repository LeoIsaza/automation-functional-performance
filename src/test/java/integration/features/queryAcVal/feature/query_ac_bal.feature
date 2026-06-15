
Feature: Validar ejecución del servicio Consulta Saldo Consolidado Perormace

  Background:
    Given def env =  karate.get('env')
    * def util = Java.type('integration.Utils')
    * def body = read('classpath:integration/features/queryAcVal/request/queryAcBal.txt')
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8' }
    * configure connectTimeout = 300000
    * configure readTimeout = 300000

  @performance=queriAcBal
  Scenario:Performance consulta saldo
    Given url urlService
    And headers headers
    * def transaccionReferenceNumber = util.generarExternalReference();
    * def cuenta = karate.get('__gatling.cuenta','001')
    * def soapRequest = body.replace('@ACC', cuenta).replace('@TXNID', transaccionReferenceNumber)
    And request soapRequest
    * print soapRequest
    And method POST
    * def xmlRaw = new java.lang.String(responseBytes)
    * util.guardarDatos(transaccionReferenceNumber + ' ______REQUEST '+ soapRequest +' _____RESPONSE ' +xmlRaw)
    Then status 200
    Then match xmlRaw contains 'AVLBAL>'
    Then assert !xmlRaw.contains('ERROR>')


  @pruebaFuncional
  Scenario:prueba consulta saldo
    Given url urlService
    And headers headers
    ##* def customerNumber = karate.get('__gatling.customerNumber','001')
    * def customerNumber = "002070126110"
    * def transaccionReferenceNumber = util.generarExternalReference();
    * def soapRequest = body.replace('@ACC', customerNumber).replace('@TXNID', transaccionReferenceNumber)
    And request soapRequest
    * print soapRequest
    And method POST
    * util.guardarDatos(transaccionReferenceNumber + ' ______REQUEST '+ soapRequest +' _____RESPONSE ' +xmlRaw)
    Then status 200
    * def xmlRaw = new java.lang.String(responseBytes)
    Then match xmlRaw contains 'AVLBAL>'
    Then assert !xmlRaw.contains('ERROR>')
