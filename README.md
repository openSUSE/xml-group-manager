# About
The xml-group-manager is a little helper script to add, delete, update or init groups in XML catalogs or XML files in an easy way. That means you can edit catalog files without any XML commands and without knowledge of the XML syntax.

# Usage

## The Syntax

```
xml-group-manager [option] [file]


Options:

  -a GROUP, --add GROUP        add the XML group with the content
                               from the given file
  -d GROUP, --delete GROUP     delete the XML group
  -u GROUP, --update GROUP     update the XML group with the content
                               from the given file
  -i GROUP, --init GROUP       creates the XML group and
                               set delegatePublic and
                               delegateSystem to the given file

  -p STRING, --public STRING   defines the publicIdStartString for
                               the init group command
  -s STRING, --system STRING   defines the systemIdStartString for
                               the init group command

  -c FILE, --catalog FILE      set the output catalog file if
                               not specified /etc/xml/catalog
                               is used

  -h, --help                   print this help
```

## The Input File for Add and Update
The input file contains only the needed part and is copied directly into the group.

For Example:
```xml
<delegatePublic publicIdStartString="-//OASIS//ENTITIES DocBook Character Entities V4.2//EN" catalog="file:///usr/share/xml/docbook/schema/dtd/4.2/catalog.xml"/>
<delegateSystem systemIdStartString="http://www.docbook.org/xml/4.2" catalog="file:///usr/share/xml/docbook/schema/dtd/4.2/catalog.xml"/>
<delegateURI uriStartString="http://www.oasis-open.org/docbook/xml/4.2" catalog="file:///usr/share/xml/docbook/schema/dtd/4.2/catalog.xml"/>
<rewriteSystem systemIdStartString="http://www.oasis-open.org/docbook/xml/4.2" rewritePrefix="file:///usr/share/xml/docbook/schema/dtd/4.2"/>
```

## Examples
Add a group
```
xml-group-manager -a group_name -c catalog input_file</para>
```
Delete a group
```
xml-group-manager -d group_name -c catalog
```
Update a group
```
xml-group-manager -u group_name -c catalog input_file
```
Init a group
```
xml-group-manager -i group_name -p public_id_start_string -s system_id_start_string -c catalog target_file
```
