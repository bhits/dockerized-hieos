FROM bhits/glassfish:2.1.1
COPY hieos-1.2/xref/web /hieos
COPY hieos-1.2/dist /glassfish/domains/domain1/autodeploy
COPY hieos-1.2/lib/mysql-connector-java-5.1.10-bin.jar /glassfish/domains/domain1/lib/ext/
ENV HIEOSxCodesFile=/hieos/codes/codes.xml HIEOSxConfigFile=/hieos/config/xconfig.xml HIEOSxSchemaDir=/hieos/schema HIEOSxLogDir=/hieos/logs