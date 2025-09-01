Feature: Consulta de autorizaciones (Opclaut)

  Scenario: Consultar autorizaciones con un siaidcd valido

    # URL de un servicio de consulta.
    * url opclautUrl
    * header SOAPANCTION = 'urn:runService'
    * header Content-Type = 'text/xml; charset=utf-8'
    * request
      """
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://webservice.sat.mediosdepago.tecnocom.com" xmlns:xsd="http://satNewAge.soapwebservices.ease/xsd" xmlns:xsd1="http://webservice.sat.mediosdepago.tecnocom.com/xsd">
      <soapenv:Header/>
      <soapenv:Body>
      <web:runService>
      <web:msgEnvio>
      	<xsd:autoPaginable>False</xsd:autoPaginable>
      	<xsd:entidad>0062</xsd:entidad>
      	<xsd:oficina>0116</xsd:oficina>
      	<xsd:password>Colombia_24</xsd:password>
      	<xsd:tipoOperacion>Select</xsd:tipoOperacion>
      	<xsd:usuario>ANDRESES</xsd:usuario>
      	<xsd1:siaidcd>0000724120014000054</xsd1:siaidcd>
      	</web:msgEnvio>
      </web:runService>
      </soapenv:Body>
      </soapenv:Envelope>

     * method post

    # Validaciones basicas
    * status 200
    * match /soap:Envelope/soap:Body/ns:runServiceResponse/return/descRetorno == '#notnull'
    * match /soap:Envelope/soap:Body/ns:runServiceResponse/return/retorno == 'OK'

    # Validaciones especificas del registro
    * match /soap:Envelope/soap:Body/ns:runServiceResponse/return/registros_OPCLAUT[0]/desclamon == 'TRANSACCION AUTORIZADA'
    * match /soap:Envelope/soap:Body/ns:runServiceResponse/return/registros_OPCLAUT[0]/imptrn == '150000.0'