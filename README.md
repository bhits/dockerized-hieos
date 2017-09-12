## Dockerized HIEOS1.2
Health Information Exchange Open Source (HIEOS) is an open source implementation of, primarily server-side, Integrating the Healthcare Enterprise (IHE) Integration Profiles including Cross Enterprise Document Sharing (XDS.b) and Cross Community Access (XCA) integration profiles.

For more information about HIEOS and related downloads, please visit their [website](https://sourceforge.net/projects/hieos/).

## Run as Web Application

### Prerequisites
+ [Sun GlassFish Enterprise Server 2.1.1](http://www.oracle.com/technetwork/java/javaee/downloads/java-archive-downloads-glassfish-419424.html)
+ [MySQL](https://www.mysql.com/)

### Deployment
1. Setup MySQL database `adt`, `log`, `omar`, `repo` with [`adt schema`](openempi-2.2.9/hieos-db/adt/createadtddl.sql), [`log schema`](openempi-2.2.9/hieos-db/log/createlogddl.sql), [`registry schema`](openempi-2.2.9/hieos-db/registry/createregistryddl.sql), [`repository schema`](openempi-2.2.9/hieos-db/repository/createrepoddl.sql). 
2. Copy [`mysql-connector-java-5.1.10-bin.jar`](hieos-1.2/lib/mysql-connector-java-5.1.10-bin.jar) under `GLASFHISH_ROOT/domains/domain1/lib/ext` directory.
3. Copy [`all application deployable files`](hieos-1.2/dist/) to `GLASFHISH_ROOT/domains/domain1/autodeploy` directory.
4. Create an environment variable named `HIEOSxCodesFile`, and set its value to point to [`codes.xml`](hieos-1.2/xref/web/codes/codes.xml) file.
5. Create an environment variable named `HIEOSxConfigFile`, and set its value to point to [`xconfig.xml`](hieos-1.2/xref/web/cconfig/xconfig.xml) file.
6. Create an environment variable named `HIEOSxSchemaDir`, and set its value to point to [`schema`](hieos-1.2/xref/web/schema) folder.
7. Create an environment variable named `HIEOSxLogDir`, and set its value to [`logs`](hieos-1.2/xref/web/logs) folder.

#### Configuration
After start up glassfish, log into the web management interface as admin, for example, `http://localhost:4848`.
##### Setup Connection pool
Go to `Resources>JDBC>Connection Pool`, create following MySql connection pools `hieos-adt-pool`, `hieos-log-pool`, `hieos-registry-pool`, `hieos-repo-pool` 
* Resource Type: `javax.sql.ConnectionPoolDataSource`
* Vendor: `MySQL`   
* Setup `Password`, `Url`, `User` value from the “Additional Properties section”  and delete others. 
* After finished, click `ping` to verify connection.
##### Configure JNDI Connection Pool
Go to `Resources>JDBC>JDBC Resources`, create following `JDBC Resources`
* Click `New`, set JNDI Name: jdbc/hieos-adt, Pool Name: hieos-adt-pool, click `OK`.
* Click `New`, set JNDI Name: jdbc/hieos-adt, Pool Name: hieos-adt-pool, click `OK`.
* Click `New`, Set JNDI Name: jdbc/hieos-registry, Pool Name: hieos-registry-pool, click `OK`.
* Click `New`, Set JNDI Name: jdbc/hieos-repo, Pool Name: hieos-repo-pool, click `OK`.
##### Configure JMS Resources
* Go to `Resources>JMS Resources>Connection Factories`, select `New`, Enter JNDI Name: `jms/XLoggerFactory`,  Select Resource Type: `javax.jms.QueueConnectionFactory`, Delete all the properties.
* Go to `Resources>JMS Resources>Connection Factories`, select `New`, Enter JNDI Name: `jms/XLogger`,  Select Physical Destination Name: `PhysicalQueue`, Select Resource Type: `javax.jms.Queue`.
##### JVM settings
Go to `Application Server>JVM Settings>JVM Options>Add JVM Option`, create new property as  `-Dcom.vangent.hieos.xconfig=${com.sun.aas.instanceRoot}/applications/j2ee-modules/xref/config/xconfig.xml`
Restart server after configuration, verify by following links `http://localhost:8080/axis2/services/listServices`

## Run as Docker Container
The docker images bhits/hieos:1.2.1 is configured with [`domain.xml`](domain.xml) which including all above configuration. Connection pool is using MySQL docker containers. 

`docker run  --name hieos --link="adt-db.c2s.com"  --link="log-db.c2s.com" --link="repo-db.c2s.com" --link="registry-db.c2s.com" -d bhits/hieos:1.2.1`

To fully run bhits/hieos:1.2, please refer following `docker-compose.yml`,
 
```yml
version: '2'
services:
...
  hieos.c2s.com:
    image: bhits/hieos:1.2.1
    ports:
      - "80:8080"
      - "81:4848"
    restart: always      
  adt-db.c2s.com:
    image: mysql:5.7.19
    environment:
      MYSQL_ROOT_PASSWORD: admin
      MYSQL_DATABASE: adt
    volumes:
      - ${C2S_BASE_PATH}/java/C2S_PROPS/hieos-db/adt:/docker-entrypoint-initdb.d
    command: mysqld --lower_case_table_names=1 --skip-ssl
    restart: always
  log-db.c2s.com:
    ...
  repo-db.c2s.com:
    ...
  registry-db.c2s.com:
...
```

## License

1. View [license](LICENSE) information for the software contained in this image.
2. HIEOS 1.2 artifacts in this repository are downloaded from [HIEOS](https://sourceforge.net/projects/hieos/).

## Contact
If you have any questions, comments, or concerns please see [Consent2Share](https://bhits.github.io/consent2share/) project site.

## Report Issues

Please use [GitHub Issues](https://github.com/bhits-dev/dockerized-openempi/issues) page to report issues.

