# Archivo: src/test/resources/features/eliminarPlasticoAdicional.feature
Feature: Automatizacion para el servicio SOAP de Eliminacion de Plastico Adicional

  Background:
    # URL del servicio de eliminacion de plastico.
    * url adaltarUrl + '/axis2/services/SAT_ADALTARWS.SAT_ADALTARWSHttpSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinamicos para la solicitud
    * def entidad = '0015'
    * def password = '2020ChL1'
    * def tipoOperacion = 'INSERT'
    * def usuario = 'MDWSAT'
    * def centalta = '0001'
    * def cuenta = '000000000400'
    * def indrecog = 'S'
    * def motbaja = '13'
    * def numplastico = '2'

  Scenario: Realizar la eliminacion de un plastico adicional y validar la respuesta

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
                  <xsd1:indrecog>#(indrecog)</xsd1:indrecog>
                  <xsd1:motbaja>#(motbaja)</xsd1:motbaja>
                  <xsd1:numplastico>#(numplastico)</xsd1:numplastico>
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
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/descRetorno == 'OK'