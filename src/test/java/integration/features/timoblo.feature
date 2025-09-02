Feature: Automatizacion para el servicio SOAP de Bloqueo-Desbloqueo de Tarjetas (TIMOBLO)

  Background:
    # URL de un servicio de consulta.
    * url timobloUrl + '/axis2/services/SAT_TIMOBLOWS'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

  Scenario: Bloquear una tarjeta

    # Datos dinámicos para la solicitud
    * def entidad = '0015'
    * def password = 'Pepito.2020'
    * def tipoOperacion = 'BL'
    * def usuario = '15189568'
    * def codblq = 1
    * def pan = '1234567890123456'
    * def texblq = 'BLOQUEO DE PRUEBA'


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
                  <xsd1:codblq>#(codblq)</xsd1:codblq>
                  <xsd1:pan>#(pan)</xsd1:pan>
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
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/descRetorno contains 'OK'