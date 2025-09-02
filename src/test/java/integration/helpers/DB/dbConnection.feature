Feature: connect to database

  Background:
    * def envBd = karate.get('BD_ENV')
    * def config = read('classpath:integration/helpers/DB/querys/config_'+karate.get('env').BD_ENV+'.json')
    * def DbUtils = Java.type('integration.helpers.DB.querys.DbUtils')
    * def db = new DbUtils(config)



  @select_account_create
  Scenario:
    * def consulta_account_create = read('classpath:integration/helpers/DB/querys/select/creationAccount/select_account_create.txt')
    * replace consulta_account_create.ACC_NO = ACC_NO
    * print consulta_account_create
    * def list_params = db.readRows(consulta_account_create)
    * print list_params

