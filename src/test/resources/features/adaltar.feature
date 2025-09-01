# Archivo: src/test/resources/features/adaltar.feature
Feature: Automatización para el servicio SOAP de Alta de Tarjetas

  Background:
    # URL de un servicio de consulta.
    * url baseUrl + '/axis2/services/SAT_ADALTARWS.SAT_ADALTARWSHttpSoap12Endpoint/'
    * def headers = { 'Content-Type': 'application/soap+xml; charset=UTF-8; action="urn:runService"' }

    # Datos dinámicos para la solicitud
    * def nombenred = 'Ana Castaño Martinez'
    * def numper = '1122383'
    * def cuenta = '300000005748'

  Scenario: Realizar un alta de tarjeta exitosa y validar la respuesta

    # 1. Definir el cuerpo de la solicitud XML
    * def body =
      """
      <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
         <soap:Header/>
         <soap:Body>
            <web:runService>
               <web:msgEnvio>
                  <xsd:entidad>0062</xsd:entidad>
                  <xsd:password>#(password)</xsd:password>
                  <xsd:tipoOperacion>INSERT</xsd:tipoOperacion>
                  <xsd:usuario>#(usuario)</xsd:usuario>
                  <xsd1:calpart>BE</xsd1:calpart>
                  <xsd1:centalta>0015</xsd1:centalta>
                  <xsd1:centroest>0001</xsd1:centroest>
                  <xsd1:clamon_lim1>170</xsd1:clamon_lim1>
                  <xsd1:codbarras>0</xsd1:codbarras>
                  <xsd1:condest>013</xsd1:condest>
                  <xsd1:cuenta>#(cuenta)</xsd1:cuenta>
                  <xsd1:indactlim>2</xsd1:indactlim>
                  <xsd1:indenvcentest>S</xsd1:indenvcentest>
                  <xsd1:indenvcentpin>N</xsd1:indenvcentpin>
                  <xsd1:indesttarext>S</xsd1:indesttarext>
                  <xsd1:indesttarol>S</xsd1:indesttarol>
                  <xsd1:indexecuo>0</xsd1:indexecuo>
                  <xsd1:indimppinol>N</xsd1:indimppinol>
                  <xsd1:indtareme>0</xsd1:indtareme>
                  <xsd1:indtarprov>0</xsd1:indtarprov>
                  <xsd1:indtaremv>0</xsd1:indtaremv>
                  <xsd1:indtipt>23</xsd1:indtipt>
                  <xsd1:codmar>2</xsd1:codmar>
                  <xsd1:moncta_tar1>0</xsd1:moncta_tar1>
                  <xsd1:moncta_tar2>0</xsd1:moncta_tar2>
                  <xsd1:nombenred>#(nombenred)</xsd1:nombenred>
                  <xsd1:numper>#(numper)</xsd1:numper>
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

    # Validar el código de retorno y descripción del servicio
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/retorno == '0000'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/descRetorno == 'OK'

    # Validar que los datos de la respuesta son los esperados
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_ADALTAR[0]/numper == '#(numper)'
    And match /soap:Envelope/soap:Body/web:runServiceResponse/return/registros_ADALTAR[0]/nombenred == '#(nombenred)'
