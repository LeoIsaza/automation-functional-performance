# Archivo: src/test/resources/features/simularAvance.feature
Feature: Automatizacion para el servicio SOAP de Simulacion de Avance

  Background:
    # URL del servicio de simulacion de avance.
    * url flalinUrl + '/axis2/services/SAT_FLALINWS.SAT_FLALINWSSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinamicos para la solicitud
    * def entidad = '0015'
    * def password = '2020ChL1'
    * def tipoOperacion = 'VIEW'
    * def usuario = 'MDWSAT'
    * def centalta = '0001'
    * def clamon = '152'
    * def codtipcav = 'AVCE'
    * def cuenta = '000000000025'
    * def impfacav = '100000'
    * def indporint = 'S'
    * def indsimconf = 'S'
    * def porint = '1.30'
    * def totcuotasav = '6'

  Scenario: Realizar una simulacion de avance exitosa y validar la respuesta

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
                  <xsd1:clamon>#(clamon)</xsd1:clamon>
                  <xsd1:codtipcav>#(codtipcav)</xsd1:codtipcav>
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
                  <xsd1:impfacav>#(impfacav)</xsd1:impfacav>
                  <xsd1:indporint>#(indporint)</xsd1:indporint>
                  <xsd1:indsimconf>#(indsimconf)</xsd1:indsimconf>
                  <xsd1:porint>#(porint)</xsd1:porint>
                  <xsd1:totcuotasav>#(totcuotasav)</xsd1:totcuotasav>
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
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_FLALIN[0]/impavanc contains '#number'