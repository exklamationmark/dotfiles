# schemaSpy

[schemaSpy](http://schemaspy.sourceforge.net/) generates a graphical, navigatable db schema
for a database. It can be used on most SQL db, provided there is an db adapter.

Adapter:

- [postgresql](https://jdbc.postgresql.org/)

# Installing

- Install `java` (i.e: oracle / openjdk)
- Install `graphviz` -> used for generating the graphics
# Usage

```
java -jar schemaSpy_jar -t dbType -host dbHost -u dbUser -p dbPassword -db dbName [-s dbSchema] -dp jdbc_driver_jar -hq -o output_folder

i.e:
-----------------------------------
java -jar schemaSpy_5.0.0.jar -t pgsql -host localhost -u postgres -p 'password' -db my_db -s public -dp postgresql-9.4.1208.jre6.jar -hq -o temp/
```
