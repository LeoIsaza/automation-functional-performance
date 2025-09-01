# Archivo: src/test/resources/features/opclcuo.feature
Feature: Automatizacion para el servicio SOAP de Consulta de Cuotas

  Background:

    # URL de un servicio de consulta.
    * url opclcuoUrl + '/axis2/services/SAT_OPCLCUAWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

  Scenario: Realizar una consulta de cuotas con retroceso

    # Datos dinámicos para la solicitud
    * def usuario = 'MDWSAT'
    * def password = '2020ChL1'
    * def entidad = '0015'
    * def tipoOperacion = 'VIEW'
    * def avanzar = 'false'
    * def retroceder = 'true'
    * def pantPagina = '002'
    * def centalta = '0001'
    * def clamon = '152'
    * def cuenta = '300000000297'
    * def numfinan = '1'
    * def numopecuo = '14'
    * def claveInicio = '000000000000 0015 0001 300000000297 152 000014 001 001 000000001 2021-07-29 00000000000140700 00000000000068700 00000000000072000 00000000000000000 02 LIQUIDADA          2021-07-29 0001-01'

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
              <xsd:pantPagina>#(pantPagina)</xsd:pantPagina>
              <xsd:password>#(password)</xsd:password>
              <xsd:retroceder>#(retroceder)</xsd:retroceder>
              <xsd:tipoOperacion>#(tipoOperacion)</xsd:tipoOperacion>
              <xsd:usuario>#(usuario)</xsd:usuario>
              <xsd1:centalta>#(centalta)</xsd1:centalta>
              <xsd1:clamon>#(clamon)</xsd1:clamon>
              <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
              <xsd1:numfinan>#(numfinan)</xsd1:numfinan>
              <xsd1:numopecuo>#(numopecuo)</xsd1:numopecuo>
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