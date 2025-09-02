Feature: Automatizacion para el servicio SOAP de Bloqueo de Contratos de Tarjeta (TIALBCT)

  Background:
    # URL de un servicio de consulta.
    * url tialbctUrl + '/axis2/services/SAT_TIALBCTWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

  Scenario: Realizar un bloqueo de tarjeta con datos de prueba

    # Datos dinámicos para la solicitud
    * def usuario = 'MDWSAT'
    * def password = '2020ChL1'
    * def entidad = '0015'
    * def tipoOperacion = 'INSERT'
    * def centalta = '0001'
    * def codbloq = '02'
    * def cuenta = '000000000211'
    * def indblq = 'D'
    * def texblq = 'Por Robo'


    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
         <soapenv:Header/>
         <soapenv:Body>
            <web:runService>
               <web:msgEnvio>
                  <xsd:entidad>#(entidad)</xsd:entidad>
                  <xsd:password>#(password)</xsd:password>
                  <xsd:tipoOperacion>#(tipoOperacion)</xsd:tipoOperacion>
                  <xsd:usuario>#(usuario)</xsd:usuario>
                  <xsd1:centalta>#(centalta)</xsd1:centalta>
                  <xsd1:codbloq>#(codbloq)</xsd1:codbloq>
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
                  <xsd1:indblq>#(indblq)</xsd1:indblq>
                  <xsd1:texblq>#(texblq)</xsd1:texblq>
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