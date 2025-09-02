# Archivo: src/test/resources/features/reemisionDeTarjetas.feature
Feature: Automatizacion para el servicio SOAP de Reemision de Tarjetas

  Background:
    # URL del servicio de reemision de tarjetas.
    * url fltireeUrl + '/axis2/services/SAT_FLTIREEWS.SAT_FLTIREEWSHttpSoap11Endpoint/'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

    # Datos dinamicos para la solicitud
    * def entidad = '0015'
    * def password = 'Colombia21'
    * def tipoOperacion = 'SELECT'
    * def usuario = 'TESTSOP1'
    * def centalta = '0080'
    * def centro = '0001'
    * def condest = '012'
    * def cuenta = '200000000795'
    * def feccadtar = '0'
    * def indesttarol = 'S'
    * def numplastico = '2'
    * def panant = ''

  Scenario: Realizar la reemision de una tarjeta y validar la respuesta

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
                  <xsd1:centro>#(centro)</xsd1:centro>
                  <xsd1:condest>#(condest)</xsd1:condest>
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
                  <xsd1:feccadtar>#(feccadtar)</xsd1:feccadtar>
                  <xsd1:indesttarol>#(indesttarol)</xsd1:indesttarol>
                  <xsd1:numplastico>#(numplastico)</xsd1:numplastico>
                  <xsd1:panant>#(panant)</xsd1:panant>
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
    And match /soapenv:Envelope/soapenv:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soapenv:Envelope/soapenv:Body/web:runServiceResponse/return/descRetorno == 'OK'