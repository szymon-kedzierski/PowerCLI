# Getting metrics for VM

## Find VM by name

GET `https://VROPS/suite-api/api/resources?name=NAME`

Response:

`<ops:resource creationTime="x" identifier="ID">`

## Get all statkeys for VM resourcekind

`GET https://VROPS/suite-api/api/adapterkinds/VMWARE/resourcekinds/VirtualMachine/statkeys`

Example statkey:

` <ops:resource-kind-attribute>
        <ops:key>cpu|usage_average</ops:key>
        <ops:name>CPU|Usage</ops:name>
        <ops:description>Average CPU usage as a percentage</ops:description>
        <ops:defaultMonitored>true</ops:defaultMonitored>
        <ops:rollupType>AVG</ops:rollupType>
        <ops:instanceType>INSTANCED</ops:instanceType>
        <ops:unit>%</ops:unit>
        <ops:monitoring>false</ops:monitoring>
        <ops:property>false</ops:property>
    </ops:resource-kind-attribute>`
	
## All statkeys for specific VM

`GET https://vROPS/suite-api/api/resources/VM_ID/statkeys`

Response:

`...
<ops:stat-key>
        <ops:key>mem|usage_average</ops:key>
    </ops:stat-key>
...`

## Get latest data for keystat

`GET https://VROPS/suite-api/api/resources/stats/latest?resourceId=VM_ID&statKey=cpu|usage_average`

Response:
`<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ops:stats-of-resources xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ops="http://webservice.vmware.com/vRealizeOpsMgr/1.0/">
    <ops:stats-of-resource>
        <ops:resourceId>bab6715f-701c-45e4-ace3-bfd2d3bd4917</ops:resourceId>
        <ops:stat-list>
            <ops:stat>
                <ops:timestamps>1497018056574</ops:timestamps>
                <ops:statKey>
                    <ops:key>cpu|usage_average</ops:key>
                </ops:statKey>
                <ops:data>0.8953333497047424</ops:data>
            </ops:stat>
        </ops:stat-list>
    </ops:stats-of-resource>
</ops:stats-of-resources>`

## Get data for keystat in time period

Time is set as milliseconds since the UNIX epoch

`POST https://VROPS/suite-api/api/resources/stats/query`

Body:

`<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ops:stat-query xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ops="http://webservice.vmware.com/vRealizeOpsMgr/1.0/">
    <ops:resourceId>VM_ID</ops:resourceId>
    <ops:statKey>mem|usage_average</ops:statKey>
    <ops:begin>1497008818336</ops:begin>
    <ops:end>1497018828336</ops:end>
</ops:stat-query>`

