Create custom group via API

1. Create group tyspe in GUI
To create a custom group you always need a group type. This group type is internally defined as a so called resourceKind. This is a type defined in the default container. You are not able to create group type by official API, only external API have such call therefore we will use GUI for that (one time action).
2. First you need to obtain ID of the default container:
GET https://vROPS/suite-api/api/resources?name=Container
You should get status 200 and ID in the response:
<ops:resource creationTime="Y" identifier="Cointainer_ID ">
3. Now you can create custom group:
POST https://vROPS/suite-api//api/resources/adapters/Container_ID
Body:
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ops:resource xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ops="http://webservice.vmware.com/vRealizeOpsMgr/1.0/">
<ops:description>Description of this group</ops:description>
<ops:resourceKey>
<ops:name>Group name</ops:name>
<ops:adapterKindKey>Container</ops:adapterKindKey>
<ops:resourceKindKey>Group type(created earlier)</ops:resourceKindKey>
<ops:resourceIdentifiers/>
</ops:resourceKey>
<ops:credentialInstanceId/>
<ops:resourceStatusStates/>
<ops:dtEnabled>true</ops:dtEnabled>
<ops:badges/>
</ops:resource>

In response you will get ID of this group:
<ops:resource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ops="http://webservice.vmware.com/vRealizeOpsMgr/1.0/" identifier="Group_ID">


4. Then find ID of vm that you want to add to this group: 
GET https://vROPS/suite-api/api/resources?name=VM_NAME
    Response:
<ops:resource creationTime="X" identifier="VM_ID">

5. Add your vm to this group:
PUT https://vROPS/suite-api/api/resources/GROUP_ID/relationships/children
    Body:
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<ops:uuid-values xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ops="http://webservice.vmware.com/vRealizeOpsMgr/1.0/">
<ops:uuids>VM_ID</ops:uuids>
</ops:uuid-values>


6. Now you must start monitoring to enable metrics gathering:
PUT https://vROPS/suite-api/api/resources/GROUP_ID/monitoringstate/start
    Response: 200

A se result you have custom group with static member.
