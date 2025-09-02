# Archivo: src/test/resources/features/opclext.feature
Feature: Automatizacion para el servicio SOAP de Consulta de Extractos

  Background:
    # URL de un servicio de consulta.
    * url opclextUrl + '/axis2/services/SAT_OPCLEXTWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

  Scenario: Realizar una consulta de extractos

    # Datos dinámicos para la solicitud
    * def usuario = '17502333'
    * def password = 'Pepito.2020'
    * def entidad = '0015'
    * def centalta = '0001'
    * def cuenta = '200000000062'
    * def tipoOperacion = 'VIEW'


    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
        <soap:Header/>
        <soap:Body>
          <web:runService>
            <web:msgEnvio>
              <xsd:entidad>#(entidad)</xsd:entidad>
              <xsd:password>#(password)</xsd:password>
              <xsd:tipoOperacion>#(tipoOperacion)</xsd:tipoOperacion>
              <xsd:usuario>#(usuario)</xsd:usuario>
              <xsd1:centalta>#(centalta)</xsd1:centalta>
              <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
            </web:msgEnvio>
          </web:runService>
        </soap:Body>
      </soap:Envelope>
      """

    # 2. Enviar la solicitud POST
    Given headers headers
    And request body
    When method POST

    # 3. Validar la respuesta
    Then status 200

    # Validar el código de retorno y la descripción del servicio
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/descRetorno contains 'OK'