# About
The xml-group-manager is a little helper script for add, delete or update groups in XML catalogs or XML files in an easy way. That means you can edit XML files without any XML commands and without hight knowledge of the XML syntax.

# Usage

## The Syntax

```
xml-group-manager <group> <add|delete|update> <suboptions>


Global Options:
  -g, --group     XML Group ID or Name

  -a, --add       add a XML group
  -d, --delete    delete a XML group
  -u, --update    update a XML group

  -h, --help      prints this help

Suboptions:
  -f, --file      input XML-File with the
                  XML-Deglarations
  -c, --catalog   set the default output catalog file
                  else /etc/xml/catalog is used
```


## The Input File
The input file contains only the part that copied directly into the group.

For Example:
```xml
<delegatePublic publicIdStartString="-//OASIS//ENTITIES DocBook Character Entities V4.2//EN" catalog="file:///usr/share/xml/docbook/schema/dtd/4.2/catalog.xml"/>
<delegateSystem systemIdStartString="http://www.docbook.org/xml/4.2" catalog="file:///usr/share/xml/docbook/schema/dtd/4.2/catalog.xml"/>
<delegateURI uriStartString="http://www.oasis-open.org/docbook/xml/4.2" catalog="file:///usr/share/xml/docbook/schema/dtd/4.2/catalog.xml"/>
<rewriteSystem systemIdStartString="http://www.oasis-open.org/docbook/xml/4.2" rewritePrefix="file:///usr/share/xml/docbook/schema/dtd/4.2"/>
```
