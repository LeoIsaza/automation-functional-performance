# TEMPLATE_SERVICIOS

## Servicios GFT-SAT

## v1.0

- Multiambiente
- Data Dinamica
- Estructura personalizada

# CATALOGO

| SERVICIOS OCI                                                                                  | TAG FEATURE     |
|------------------------------------------------------------------------------------------------|-----------------|
| [adalcon](src/test/java/integration/features/adalconService/funtional/feature/adalcon.feature) | @adalconService | 

## INSTALACIÓN

Se necesita tener instalado
y [configurado](https://dev.azure.com/BiceCl/Gesti%C3%B3n%20de%20Proyectos%20DIVOT/_wiki/wikis/Gesti%C3%B3n-de-Proyectos-DIVOT.wiki/9860/Manual-B%C3%A1sico-Instalaciones-para-Uso-de-Framework-de-Automatizaci%C3%B3n-Skip-to-end-of-metadata)
JAVA (11, soporta hasta 17)  y Maven (3.8.1)

## java

# paso 1 Descargar proyecto

git clone git@github.com:Bice-QA-Automatizacion/template_services.git

# paso 2 Instalar dependencias

mvn install -DskipTest=true

#### REPORTERIA

Una vez concluida la ejecución de las pruebas, se generará un reporte en la ruta _
___target/karate-reports/karate-summary.html____.

### GITHUB

Para ejecutar desde este ambiente, es necesario contar con una cuenta en GitHub. Ademas de el acceso
al repositorio que necesitas ejecutar.

Primero necesitas acceder al
portal https://github.com/enterprises/banco-bice/ -> https://github.com/Bice-QA-Automatizacion

Luego ingresar al repositorio que necesitas ejecutar.

#### PARAMETRIZACIÓN

- TAG= El tag o selector de la **Feature** a ejecutar *.
- AUTOMATIONNAME = Nombre con el cual se agruparan los resultados en Azure Devops ( testPlan/runner).
- ENV = Entorno de ejecucion ( dev, qa, perf).

#### REPORTERIA

Una vez concluida la ejecución de las pruebas, puedes acceder al reporte generado en GitHub, desde el enlace.



<hr></hr>

## Comando para ejecutar

```bash

 mvn clean test  "-Dkarate.options=--tags @api_cuentas_200"  -Ddriver=karate -Dkarate.env=dev
```

## Soporte

Para soporte: lozv@gft.com
Leonardo Isaza Villada
Automatizador Líder



