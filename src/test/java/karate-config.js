function fn() {

  let env = karate.env;

  karate.log('karate.env system property was:', env);
  karate.log('karate.dat:', karate.get("Server"));
  karate.configure('ssl', true);

  if (!env) {
    env = 'qa';
  }

  // ✅ ALLURE HISTORY HOOK (ANTES DE TODO)
  try {
    var File = Java.type('java.io.File');
    var Files = Java.type('java.nio.file.Files');
    var Paths = Java.type('java.nio.file.Paths');
    var StandardCopyOption = Java.type('java.nio.file.StandardCopyOption');

    var source = new File('allure-report/history');
    var target = new File('target/allure-results/history');

    if (source.exists()) {
      karate.log('Copiando Allure history...');

      if (!target.exists()) {
        target.mkdirs();
      }

      var sourcePath = Paths.get(source.getPath());
      var targetPath = Paths.get(target.getPath());

      Files.walk(sourcePath).forEach(function (path) {
        var dest = targetPath.resolve(sourcePath.relativize(path));

        if (path.toFile().isDirectory()) {
          dest.toFile().mkdirs();
        } else {
          Files.copy(path, dest, StandardCopyOption.REPLACE_EXISTING);
        }
      });

      karate.log('✅ Allure history copiado');
    } else {
      karate.log('⚠️ No hay history previo de Allure');
    }

  } catch (e) {
    karate.log('❌ Error copiando history:', e);
  }

  // ✅ CONFIGURACIÓN DE ENV
  let nameEnvFile = env === 'perf' ? 'env_performance.json' : `env_${env}.json`;
  let nameReadEnvFile = karate.read(`classpath:integration/env/${nameEnvFile}`);

  return nameReadEnvFile;
}
