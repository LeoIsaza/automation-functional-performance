# Archivo: src/test/resources/features/flcldis.feature
Feature: Automatización para el servicio SOAP de Consulta de Disponibles

  Background:
    # URL de un servicio de consulta.
    * url flcldisUrl + '/axis2/services/SAT_FLCLDISWS.SAT_FLCLDISWSHttpSoap11Endpoint/'
    * def headers = { 'Content-Type': 'text/xml; charset=UTF-8', 'SOAPAction': 'urn:runService' }

    # Datos dinámicos para la solicitud
    * def entidad = '0015'
    * def tipoOperacion = 'VIEW'
    * def centalta = '0001'
    * def cuenta = '000000000300'
    * def pan = ''
    * def autoPaginable = 'False'

  Scenario: Realizar una consulta de disponibles exitosa y validar la respuesta

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
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
                  <xsd1:pan>#(pan)</xsd1:pan>
                  <xsd:autoPaginable>#(autoPaginable)</xsd:autoPaginable>
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
    And match /soapenv:Envelope/soapenv:Body/web:runServiceResponse/return/descRetorno == 'OK'

    # Validar que los datos de la respuesta son los esperados
    And match /soapenv:Envelope/soapenv:Body/web:runServiceResponse/return/registros_FLCLDIS[0]/linref == '1'
    And match /soapenv:Envelope/soapenv:Body/web:runServiceResponse/return/registros_FLCLDIS[0]/dislinreal == '#number'