Feature: Automatizacion para el servicio SOAP de Consulta de Bloqueos (TICOBLQ)

  Background:
    # URL de un servicio de consulta.
    * url ticoblqUrl + '/axis2/services/SAT_TICOBLQWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

  Scenario: Realizar una consulta de bloqueos con datos de prueba

    # Datos dinámicos para la solicitud
    * def usuario = 'MDWSAT'
    * def password = '2020ChL1'
    * def entidad = '0015'
    * def tipoOperacion = 'VIEW'
    * def centalta = '0810'
    * def cuenta = '108107133302'


    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
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
    And match /soapenv:Envelope/soapenv:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soapenv:Envelope/soapenv:Body/web:runServiceResponse/return/descRetorno contains 'OK'