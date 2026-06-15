function fn() {

let env = karate.env;

  karate.log('karate.env system property was:', env);
  karate.log('karate.dat:', karate.get("Server"));
  karate.configure('ssl', true);


  if (!env) {
    env = 'qa';
  }
  let nameEnvFile = null;
  nameEnvFile = env==='perf' ? 'env_performance.json':`env_${env}.json`;
  let nameReadEnvFile = karate.read(`classpath:integration/env/${nameEnvFile}`);



  return nameReadEnvFile;

}