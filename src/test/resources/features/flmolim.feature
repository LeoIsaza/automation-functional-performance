# Archivo: src/test/resources/features/asignacionLimitesCredito.feature
Feature: Automatizacion para el servicio SOAP de Asignacion de Limites de Credito

  Background:
    # URL del servicio de asignacion de limites.
    * url flmolimUrl + '/axis2/services/SAT_FLMOLIMWS.SAT_FLMOLIMWSHttpSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinamicos para la solicitud
    * def entidad = '0015'
    * def password = 'Colombia22'
    * def tipoOperacion = 'INSERT'
    * def usuario = 'SOPHOS1'
    * def centalta = '6666'
    * def clamon = 152
    * def cuenta = '200000000103'
    * def format = 'dd-MM-yyyy'
    * def fecfin = '20-03-2099'
    * def fecini = '04-11-2021'
    * def indporlim = 'I'
    * def limcrelin = 4000000
    * def tipolin = '0002'

  Scenario: Realizar la asignacion de limites de credito y validar la respuesta

    # 1. Cuerpo de la solicitud XML
    * def body =
      """
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd" xmlns:xsd2="http://commons.soapwebservices.ease/xsd">
         <soap:Header/>
         <soap:Body>
            <web:runService>
               <web:msgEnvio>
                  <xsd:entidad>#(entidad)</xsd:entidad>
                  <xsd:password>#(password)</xsd:password>
                  <xsd:tipoOperacion>#(tipoOperacion)</xsd:tipoOperacion>
                  <xsd:usuario>#(usuario)</xsd:usuario>
                  <xsd1:centalta>#(centalta)</xsd1:centalta>
                  <xsd1:clamon>#(clamon)</xsd1:clamon>
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
                  <xsd1:fecfin>
                      <xsd2:format>#(format)</xsd2:format>
                      <xsd2:valueDate>#(fecfin)</xsd2:valueDate>
                  </xsd1:fecfin>
                  <xsd1:fecini>
                      <xsd2:format>#(format)</xsd2:format>
                      <xsd2:valueDate>#(fecini)</xsd2:valueDate>
                  </xsd1:fecini>
                  <xsd1:indporlim>#(indporlim)</xsd1:indporlim>
                  <xsd1:limcrelin>#(limcrelin)</xsd1:limcrelin>
                  <xsd1:tipolin>#(tipolin)</xsd1:tipolin>
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

    # Validar que al menos un registro fue devuelto
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_FLMOLIM contains any