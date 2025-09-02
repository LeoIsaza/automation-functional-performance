# Archivo: src/test/resources/features/opclmoc.feature
Feature: Automatización para el servicio SOAP de Consulta de Movimientos de Crédito

  Background:
    # URL de un servicio de consulta.
    * url opclmocUrl + '/axis2/services/SAT_OPCLMOCWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

  Scenario: Realizar una consulta de movimientos de crédito

    # Datos dinámicos para la solicitud
    * def usuario = 'MDWSAT'
    * def password = '2020ChL1'
    * def entidad = '0015'
    * def tipoOperacion = 'VIEW'
    * def centalta = '0001'
    * def cuenta = '300000000297'
    * def avanzar = false
    * def retroceder = true
    * def claveInicio = '000000000000'


    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
        <soap:Header/>
        <soap:Body>
          <web:runService>
            <web:msgEnvio>
              <xsd:avanzar>#(avanzar)</xsd:avanzar>
              <xsd:claveInicio>#(claveInicio)</xsd:claveInicio>
              <xsd:entidad>#(entidad)</xsd:entidad>
              <xsd:password>#(password)</xsd:password>
              <xsd:retroceder>#(retroceder)</xsd:retroceder>
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