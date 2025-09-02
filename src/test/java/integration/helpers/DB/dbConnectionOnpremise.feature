Feature: connect to database

  Background:
    * def envBd = karate.get('BD_ENV')
    * def config = read('classpath:integration/helpers/DB/querys/config_'+karate.get('env').BD_ENV+'_onpremise.json')
    * def DbUtils = Java.type('integration.helpers.DB.querys.DbUtils')
    * def db = new DbUtils(config)

    ## ----- consultas onpremise
  @select_balance_Onmpremise
  Scenario:
    * def consulta_balance = read('classpath:integration/helpers/DB/querys/select/onpremise/select_balance.txt')
    * replace consulta_balance.CUST_AC_NO = CUST_AC_NO
    * print consulta_balance
    * def list_params = db.readRows(consulta_balance)
    * print list_params
