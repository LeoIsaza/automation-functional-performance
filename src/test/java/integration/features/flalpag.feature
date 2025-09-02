# Archivo: src/test/resources/features/flalpag.feature
Feature: Automatización para el servicio SOAP de Pagos Unificados

  Background:
    # URL de un servicio de consulta.
    * url flalpagUrl + '/axis2/services/SAT_FLALPAGWS.SAT_FLALPAGWSHttpSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinámicos para la solicitud
    * def canal = '01020001020'
    * def clamons = '152'
    * def codaut = '101010'
    * def codproon = '350000'
    * def impfac = '2446204'
    * def pan = '4998471127209293'
    * def siaidcd = '0000000000000013436'
    * def tipodocpag = '3'
    * def tipomsgon = '1200'

  Scenario: Realizar un pago unificado exitoso y validar la respuesta

    # 1. Definir el cuerpo de la solicitud XML
    * def body =
      """
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
         <soap:Header/>
         <soap:Body>
            <web:runService>
               <web:msgEnvio>
                  <xsd:entidad>0015</xsd:entidad>
                  <xsd:usuario>#(usuario)</xsd:usuario>
                  <xsd:password>#(password)</xsd:password>
                  <xsd:tipoOperacion>INSERT</xsd:tipoOperacion>
                  <xsd1:canal>#(canal)</xsd1:canal>
                  <xsd1:clamon>#(clamons)</xsd1:clamon>
                  <xsd1:codaut>#(codaut)</xsd1:codaut>
                  <xsd1:codproon>#(codproon)</xsd1:codproon>
                  <xsd1:impfac>#(impfac)</xsd1:impfac>
                  <xsd1:pan>#(pan)</xsd1:pan>
                  <xsd1:siaidcd>#(siaidcd)</xsd1:siaidcd>
                  <xsd1:tipodocpag>#(tipodocpag)</xsd1:tipodocpag>
                  <xsd1:tipomsgon>#(tipomsgon)</xsd1:tipomsgon>
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
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_FLALPAG[0]/codaut == '#(codaut)'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_FLALPAG[0]/impfac == '#(impfac)'