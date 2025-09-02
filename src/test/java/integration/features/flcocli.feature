# Archivo: src/test/resources/features/consultarClientePorDocumento.feature
Feature: Automatizacion para el servicio SOAP de Consulta de Cliente por Documento

  Background:
    # URL del servicio de consulta.
    * url adaltarUrl + '/axis2/services/SAT_ADALCONWS.SAT_ADALCONWSHttpSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinamicos para la solicitud
    * def usuario = 'MDWSAT'
    * def password = '2020ChL1'
    * def entidad = '0015'
    * def tipoOperacion = 'SELECT'
    * def numdoc = '177783609'
    * def tipdoc = '001'

  Scenario: Realizar una consulta de cliente por documento y validar la respuesta

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
                  <xsd1:numdoc>#(numdoc)</xsd1:numdoc>
                  <xsd1:tipdoc>#(tipdoc)</xsd1:tipdoc>
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

    # Validar el codigo de retorno y la descripcion del servicio
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/descRetorno == 'OK'

    # Validar que los datos del documento de la respuesta son los esperados
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_ADALCON[0]/numdoc == '#(numdoc)'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_ADALCON[0]/tipdoc == '#(tipdoc)'