Feature: Automatizacion para el servicio SOAP de Consulta de Maestro de Recibos (OPCLRMAWS)

  Background:
    # URL de un servicio de consulta.
    * url opclrmaUrl + '/axis2/services/SAT_OPCLRMAWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

  Scenario: Consultar un recibo
    # Datos dinámicos para la solicitud
    * def entidad = '0015'
    * def password = '2020ChL1'
    * def tipoOperacion = 'VIEW'
    * def usuario = 'MDWSAT'
    * def centalta = '0001'
    * def cuenta = '000000001382'
    * def pan = '4455968233384635'


    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd" xmlns:xsd2="http://commons.soapwebservices.ease/xsd">
         <soapenv:Header/>
         <soapenv:Body>
            <web:runService>
               <web:msgEnvio>
                  <xsd:entidad>#(entidad)</xsd:entidad>
                  <xsd:password>#(password)</xsd:password>
                  <xsd:tipoOperacion>#(tipoOperacion)</xsd:tipoOperacion>
                  <xsd:usuario>#(usuario)</xsd:usuario>
                  <xsd1:centalta>#(centalta)</xsd1:centalta>
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
                  <xsd1:pan>#(pan)</xsd1:pan>
               </web:msgEnvio>
            </web:runService>
         </soapenv:Body>
      </soapenv:Envelope>
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