FROM bhits/glassfish:2.1.1
COPY hieos-1.2 /hieos
COPY hieos-war /glassfish/domains/domain1/autodeploy
COPY mysql-connector-java-5.1.10-bin.jar /glassfish/domains/domain1/lib/ext/
ENV HIEOSxCodesFile=/hieos/codes/codes.xml HIEOSxConfigFile=/hieos/config/xconfig.xml HIEOSxSchemaDir=/hieos/schema HIEOSxLogDir=/hieos/logs