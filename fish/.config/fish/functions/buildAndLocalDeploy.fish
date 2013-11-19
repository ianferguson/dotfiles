function buildAndLocalDeploy
	set TOMCAT_HOME /usr/local/Cellar/tomcat/7.0.42/libexec
    catalina stop
    rm -rf $TOMCAT_HOME/webapps/*
    mvn clean package	
    and cp ./creditconsole-core/target/*.war $TOMCAT_HOME/webapps/creditconsole.war
    and catalina start
    and tail -f $TOMCAT_HOME/logs/*.out
end
