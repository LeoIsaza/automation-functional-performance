# TEMPLATE_SERVICIOS

## v1.0

- Multiambiente
- Data Dinamica
- Estructura personalizada

# CATALOGO

| SERVICIOS OCI                                                                                  | TAG FEATURE     |
|------------------------------------------------------------------------------------------------|-----------------|


# INSTALACIÓN

Se necesita tener instalado
JAVA (11, soporta hasta 17)  y Maven (3.8.1)


- paso 1 Descargar proyecto

git clone git

-  paso 2 Instalar dependencias

mvn install -DskipTest=true

# REPORTERIA

Una vez concluida la ejecución de las pruebas, se generará un reporte en la ruta _
___target/karate-reports/karate-summary.html____.

# GITHUB

Para ejecutar desde este ambiente, es necesario contar con una cuenta en GitHub. Ademas de el acceso
al repositorio que necesitas ejecutar.

Luego ingresar al repositorio que necesitas ejecutar.

# PARAMETRIZACIÓN

- TAG= El tag o selector de la **Feature** a ejecutar *.
- ENV = Entorno de ejecucion ( dev, qa, perf).


# Comando para ejecutar

```bash

 mvn clean test  "-Dkarate.options=--tags @api_cuentas_200"  -Ddriver=karate -Dkarate.env=dev
```

# Soporte

Para soporte: leonardo.isazav@gmail.com.

Leonardo Isaza Villada.

Automatizador Líder.



