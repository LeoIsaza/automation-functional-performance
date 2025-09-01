# File: src/test/resources/features/flaldmi.feature
Feature: Automatización para el servicio SOAP de Alta de Cliente

  Background:
    # URL de un servicio de consulta.
    * url baseUrl + '/axis2/services/SAT_FLALDMIWS.SAT_FLALDMIWSHttpSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinámicos para la solicitud
    * def apellido1 = 'JORQUERA'
    * def apellido2 = 'SOPHOS'
    * def identcli = '15151515'
    * def nombre = 'GASTON'
    * def numdoc = '81818181'
    * def tipdoc = '001'
    * def indempleado = '1'
    * def catcliente = '1'

  Scenario: Perform a successful customer registration and validate the response

    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
         <soap:Header/>
         <soap:Body>
            <web:runService>
               <web:msgEnvio>
                  <xsd:entidad>0015</xsd:entidad>
                  <xsd:password>#(password)</xsd:password>
                  <xsd:tipoOperacion>INSERT</xsd:tipoOperacion>
                  <xsd:usuario>#(usuario)</xsd:usuario>
                  <xsd1:apellido1>#(apellido1)</xsd1:apellido1>
                  <xsd1:apellido2>#(apellido2)</xsd1:apellido2>
                  <xsd1:catcliente>#(catcliente)</xsd1:catcliente>
                  <xsd1:identcli>#(identcli)</xsd1:identcli>
                  <xsd1:indempleado>#(indempleado)</xsd1:indempleado>
                  <xsd1:nombre>#(nombre)</xsd1:nombre>
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

    # Validar el código de retorno y la descripción del servicio
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/descRetorno == 'OK'

    # Validar que los datos de la respuesta son los esperados
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_FLALDMI[0]/identcli == '#(identcli)'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_FLALDMI[0]/nombre == '#(nombre)'