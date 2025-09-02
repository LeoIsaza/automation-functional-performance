# Archivo: src/test/resources/features/consultaDetalleMovimientos.feature
Feature: Automatización para el servicio SOAP de Consulta de Detalle de Movimientos

  Background:
    # URL del servicio de consultas.
    * url adaltarUrl + '/axis2/services/SAT_FLALDMIWS.SAT_FLALDMIWSHttpSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinámicos para la solicitud
    * def usuario = 'MDWSAT'
    * def password = '2020ChL1'
    * def entidad = '0015'
    * def tipoOperacion = 'VIEW'
    * def autoPaginable = 'false'
    * def avanzar = 'true'
    * def retroceder = 'false'
    * def centalta = '0001'
    * def cuenta = '000000000025'
    * def claveFin = '000000000000 0015 0001 000000000025 00000     22 0 A 000 152 0000000 1001 + 00000000001100000 20200612 20200312 6771 TI 00000000000000000 000     000000000 1201180221022350001 000000 000000350001'

  Scenario: Realizar una consulta de detalle de movimientos con paginación

    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
         <soap:Header/>
         <soap:Body>
            <web:runService>
               <web:msgEnvio>
                  <xsd:autoPaginable>#(autoPaginable)</xsd:autoPaginable>
                  <xsd:avanzar>#(avanzar)</xsd:avanzar>
                  <xsd:claveFin>#(claveFin)</xsd:claveFin>
                  <xsd:entidad>#(entidad)</xsd:entidad>
                  <xsd:password>#(password)</xsd:password>
                  <xsd:retroceder>#(retroceder)</xsd:retroceder>
                  <xsd:tipoOperacion>#(tipoOperacion)</xsd:tipoOperacion>
                  <xsd:usuario>#(usuario)</xsd:usuario>
                  <xsd1:centalta>#(centalta)</xsd1:centalta>
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
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
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_FLALDMI contains any