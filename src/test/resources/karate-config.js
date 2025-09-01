function fn() {
  var env = karate.env;
  if (!env) {
    env = 'qa';
  }

  var config = {
    qa: {
      adalconUrl: 'http://10.140.40.12:7005',
      adaltarUrl: 'http://10.140.40.12:7009',
      flaldmiUrl: 'http://10.140.40.12:7005',
      flalpagUrl: 'http://10.140.40.90:7119',
      flcldisUrl: 'http://10.140.40.12:7005',
      flalinUrl: 'http://10.140.40.12:7005',
      flmolimUrl: 'http://10.140.40.94:7007',
      fltireeUrl: 'http://10.140.40.12:7005',
      opclautUrl: 'https://sat-co-qa-priv.fif.tech/axis2/services/SAT_OPCLAUTWS'
      opclcccUrl: 'http://10.140.40.12:7005'
      opclcuoUrl: 'http://10.140.40.12:7005'
      opclextUrl: 'http://10.140.40.12:7005'
      opclmocUrl: 'http://10.140.40.12:7005'
      tialbctUrl: 'http://10.140.40.12:7005'
      ticoblqUrl: 'http://10.140.40.12:7005'
      ticolimUrl: 'http://10.140.40.12:7005'
      timobloUrl: 'http://10.140.40.90:7119'
      opclrmaUrl: 'http://10.140.40.12:7005',
          // Nueva URL
    },
    prod: {
      adalconUrl: 'http://dominio-produccion.com:8080',
      adaltarUrl: 'http://dominio-produccion.com:8081',
      flaldmiUrl: 'http://dominio-produccion.com:8080',
      flalpagUrl: 'http://dominio-produccion.com:8082',
      flcldisUrl: 'http://dominio-produccion.com:8083',
      flalinUrl: 'http://dominio-produccion.com:8084',
      flmolimUrl: 'http://dominio-produccion.com:8085',
      fltireeUrl: 'http://dominio-produccion.com:8086',
      opclautUrl: 'https://sat-co-prod-priv.fif.tech/axis2/services/SAT_OPCLAUTWS'
      opclcccUrl: 'http://dominio-prod-opclccc.com:7005'
      opclcuoUrl: 'http://dominio-prod-opclcuo.com:7005'
      opclextUrl: 'http://dominio-prod-opclext.com:7005'
      opclmocUrl: 'http://dominio-prod-opclmoc.com:7005'
      tialbctUrl: 'http://dominio-prod-tialbct.com:7005'
      ticoblqUrl: 'http://dominio-prod-ticoblq.com:7005'
      ticolimUrl: 'http://dominio-prod-ticolim.com:7005'
      timobloUrl: 'http://dominio-prod-timoblo.com:7119'
      opclrmaUrl: 'http://dominio-prod-opclrma.com:7005'

    }
  };

  karate.log('Cargando configuracion para el entorno:', env);
  karate.log('URL de Adalcon:', config[env].adalconUrl);
  karate.log('URL de Adaltar:', config[env].adaltarUrl);
  karate.log('URL de Flaldmi:', config[env].flaldmiUrl);
  karate.log('URL de Flalpag:', config[env].flalpagUrl);
  karate.log('URL de Flcldis:', config[env].flcldisUrl);
  karate.log('URL de Flalin:', config[env].flalinUrl);
  karate.log('URL de Flmolim:', config[env].flmolimUrl);
  karate.log('URL de Fltiree:', config[env].fltireeUrl);
  karate.log('URL de Opclaut:', config[env].opclautUrl);
  karate.log('URL de Opclccc:', config[env].opclcccUrl);
  karate.log('URL de Opclcuo:', config[env].opclcuoUrl);
  karate.log('URL de Opclexp:', config[env].opclextUrl);
  karate.log('URL de Opclmoc:', config[env].opclmocUrl);
  karate.log('URL de Tialbct:', config[env].tialbctUrl);
  karate.log('URL de Ticoblq:', config[env].ticoblqUrl);
  karate.log('URL de Ticolim:', config[env].ticolimUrl);
  karate.log('URL de Timoblo:', config[env].timobloUrl);
  karate.log('URL de Opclrma:', config[env].opclrmaUrl);


  return config[env];
}