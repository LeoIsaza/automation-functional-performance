# Archivo: src/test/resources/features/opclccc.feature
Feature: Automatizacion para el servicio SOAP de Consulta de Compra en Cuotas

  Background:
    * url opclcccUrl + '/axis2/services/SAT_OPCLCCCWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

    # Datos dinámicos para la solicitud
    * def usuario = 'MDWSAT'
    * def password = '2020ChL1'
    * def entidad = '0015'
    * def tipoOperacion = 'VIEW'
    * def avanzar = 'false'
    * def retroceder = 'false'
    * def pantPagina = '001'
    * def centalta = '0510'
    * def cuenta = '108102249201'
    * def estcompraf = '01'
    * def fecha_des = '01-01-2020'
    * def fecha_has = '01-08-2021'
    * def pan = null

  Scenario: Realizar una consulta de compra en cuotas exitosa

    * def body =
      """
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd" xmlns:xsd2="http://commons.soapwebservices.ease/xsd">
        <soapenv:Header/>
        <soapenv:Body>
          <web:runService>
            <web:msgEnvio>
              <xsd:avanzar>#(avanzar)</xsd:avanzar>
              <xsd:entidad>#(entidad)</xsd:entidad>
              <xsd:pantPagina>#(pantPagina)</xsd:pantPagina>
              <xsd:password>#(password)</xsd:password>
              <xsd:retroceder>#(retroceder)</xsd:retroceder>
              <xsd:tipoOperacion>#(tipoOperacion)</xsd:tipoOperacion>
              <xsd:usuario>#(usuario)</xsd:usuario>
              <xsd1:centalta>#(centalta)</xsd1:centalta>
              <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
              <xsd1:estcompraf>#(estcompraf)</xsd1:estcompraf>
              <xsd1:fecha_des>
                <xsd2:valueDate>#(fecha_des)</xsd2:valueDate>
              </xsd1:fecha_des>
              <xsd1:fecha_has>
                <xsd2:valueDate>#(fecha_has)</xsd2:valueDate>
              </xsd1:fecha_has>
              <xsd1:pan xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"></xsd1:pan>
            </web:msgEnvio>
          </web:runService>
        </soapenv:Body>
      </soapenv:Envelope>
      """

    Given headers headers
    And request body
    When method POST
    Then status 200

    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/descRetorno contains 'OK'