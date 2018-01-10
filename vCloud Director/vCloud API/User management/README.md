# User management

## 1. Get organization UID
UID is needed to list or provision users in organization.

`GET https://vcd/api/org/`

Response:
Extract from response in tag Org – from href part behind …/org/ - this is UID for an organization in vCD.

`<?xml version="1.0" encoding="UTF-8"?>
<OrgList xmlns="http://www.vmware.com/vcloud/v1.5" href="https://vcd/api/org/" type="application/vnd.vmware.vcloud.orgList+xml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vmware.com/vcloud/v1.5 http://vcd/api/v1.5/schema/master.xsd">
    <Org href="https://vcd/api/org/Org_ID" name="OrgNAME" type="application/vnd.vmware.vcloud.org+xml"/>
</OrgList>`


## 2. Get list of users for organization

`GET https://vcd/api/admin/org/Org_ID`

You will get User list:

  `
  ...
  <Users>
        <UserReference href="https://vcd/api/admin/user/User_ID" name="test1@test.local" type="application/vnd.vmware.admin.user+xml"/>
        <UserReference href="https://vcd/api/admin/user/User_ID" name="test2@test.local" type="application/vnd.vmware.admin.user+xml"/>
        <UserReference href="https://vcd/api/admin/user/User_ID" name="test3" type="application/vnd.vmware.admin.user+xml"/>
        ...
    </Users>
    ...
    `

Same for groups:

`
...
<Groups>
        <GroupReference href="https://vcd/api/admin/group/group_ID" name="group1" type="application/vnd.vmware.admin.group+xml"/>
        <GroupReference href="https://vcd/api/admin/group/group_ID" name="group2" type="application/vnd.vmware.admin.group+xml"/>
    </Groups>
...    
`

## 3. Get user info

    `https://vcd/api/admin/user/user_ID`

Example:

`<?xml version="1.0" encoding="UTF-8"?>
<User xmlns="http://www.vmware.com/vcloud/v1.5" name="test@bartodav.local" id="urn:vcloud:user:2bb886d7-a83c-4434-9fde-b026c4571767" href="https://vcd/api/admin/user/user_ID" type="application/vnd.vmware.admin.user+xml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vmware.com/vcloud/v1.5 http://vcd/api/v1.5/schema/master.xsd">
    <Link rel="edit" href="https://vcd/api/admin/user/user_ID" type="application/vnd.vmware.admin.user+xml"/>
    <Link rel="remove" href="https://vcd/api/admin/user/user_ID"/>
    <Link rel="takeOwnership" href="https://vcd/api/admin/user/user_ID/action/takeOwnership"/>
    <Telephone/>
    <IsEnabled>false</IsEnabled>
    <IsLocked>false</IsLocked>
    <IM/>
    <NameInSource>test1@test1.local</NameInSource>
    <IsExternal>true</IsExternal>
    <ProviderType>SAML</ProviderType>
    <IsGroupRole>false</IsGroupRole>
    <StoredVmQuota>0</StoredVmQuota>
    <DeployedVmQuota>0</DeployedVmQuota>
    <Role href="https://vcd/api/admin/role/a08a8798-7d9b-34d6-8dad-48c7182c5f66" name="Organization Administrator" type="application/vnd.vmware.admin.role+xml"/>
    <GroupReferences/>
</User>`
 
From response you can extract if user is enabled, what role it has, and if it is SAML user.

## 4. Get available roles
From vCD 8.20 roles are assigned to Organization. You can get all roles in specific org by:

`GET https://vcd/api/admin/org/Org_ID`

Response:
`...
 <RoleReferences>
        <RoleReference href="vcd/api/admin/org/ORG_ID/role/ROLE_ID" name="ROLE NAME" type="application/vnd.vmware.admin.role+xml"/>
        ...
    </RoleReferences>
 ...`

## 5. Create SAML user with specified role

`curl -X POST
-H "Accept: application/*+xml;version=9.0"
-H "x-vcloud-authorization: XXX"
-H "Content-Type: application/vnd.vmware.admin.user+xml;version=9.0"
-d '<?xml version="1.0" encoding="UTF-8"?>
<User
xmlns="http://www.vmware.com/vcloud/v1.5"
name="user@example.com"
type="application/vnd.vmware.admin.user+xml">
<IsEnabled>true</IsEnabled>
<ProviderType>SAML</ProviderType>
<Role
type="application/vnd.vmware.admin.role+xml"
href="https://vcd/api/admin/role/role_ID" />
</User>'
"https://vcd/api/admin/org/Org_ID"`
 

Status: 201 Created

Response body:

`<?xml version="1.0" encoding="UTF-8"?>
<User xmlns="http://www.vmware.com/vcloud/v1.5" name="user@example.com" id="urn:vcloud:user:374235b1-7622-425c-bf4b-17be26bba6ca" href="https://vcd/api/admin/user/374235b1-7622-425c-bf4b-17be26bba6ca" type="application/vnd.vmware.admin.user+xml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vmware.com/vcloud/v1.5 http://vcd/api/v1.5/schema/master.xsd">
    <Link rel="edit" href="https://vcd/api/admin/user/374235b1-7622-425c-bf4b-17be26bba6ca" type="application/vnd.vmware.admin.user+xml"/>
    <Link rel="takeOwnership" href="https://vcd/api/admin/user/374235b1-7622-425c-bf4b-17be26bba6ca/action/takeOwnership"/>
    <Telephone/>
    <IsEnabled>true</IsEnabled>
    <IsLocked>false</IsLocked>
    <IM/>
    <NameInSource>user@example.com</NameInSource>
    <IsExternal>true</IsExternal>
    <ProviderType>SAML</ProviderType>
    <IsGroupRole>false</IsGroupRole>
    <StoredVmQuota>0</StoredVmQuota>
    <DeployedVmQuota>0</DeployedVmQuota>
    <Role href="https://vcd/api/admin/role/a08a8798-7d9b-34d6-8dad-48c7182c5f66" name="Organization Administrator" type="application/vnd.vmware.admin.role+xml"/>
    <GroupReferences/>
</User>`

## 6. Remove User
First we must disable the user (setting enabled tag to false – marked red) – referenced by user UID in the request link (marked red).
Curl Example:

`curl -X PUT
-H "Accept: application/*+xml;version=9.0"
-H "x-vcloud-authorization: 2496325dd20f4ba5b711a07f132b1f48"
-H "Content-Type: application/vnd.vmware.admin.user+xml;version=9.0"
-d '<?xml version="1.0" encoding="UTF-8"?>
<User xmlns="http://www.vmware.com/vcloud/v1.5" name="useeer@example.com" id="urn:vcloud:user:0b684c61-3179-46ac-ac49-5e9951c331d9" href="https://vcd/api/admin/user/0b684c61-3179-46ac-ac49-5e9951c331d9" type="application/vnd.vmware.admin.user+xml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vmware.com/vcloud/v1.5 http://vcd/api/v1.5/schema/master.xsd">
    <Link rel="edit" href="https://vcd/api/admin/user/0b684c61-3179-46ac-ac49-5e9951c331d9" type="application/vnd.vmware.admin.user+xml"/>
    <Link rel="takeOwnership" href="https://vcd/api/admin/user/0b684c61-3179-46ac-ac49-5e9951c331d9/action/takeOwnership"/>
    <Telephone/>
    <IsEnabled>false</IsEnabled>
    <IsLocked>false</IsLocked>
    <IM/>
    <NameInSource>useeer@example.com</NameInSource>
    <IsExternal>true</IsExternal>
    <ProviderType>SAML</ProviderType>
    <IsGroupRole>false</IsGroupRole>
    <StoredVmQuota>0</StoredVmQuota>
    <DeployedVmQuota>0</DeployedVmQuota>
    <Role href="https://vcd/api/admin/role/a08a8798-7d9b-34d6-8dad-48c7182c5f66" name="Organization Administrator" type="application/vnd.vmware.admin.role+xml"/>
    <GroupReferences/>
</User>'
"https://vcd/api/admin/user/0b684c61-3179-46ac-ac49-5e9951c331d9"
 
Then we execute delete command to user UID
Curl Example:
curl -X DELETE
-H "Accept: application/*+xml;version=9.0"
-H "x-vcloud-authorization: 2496325dd20f4ba5b711a07f132b1f48"
-H "Content-Type: application/vnd.vmware.admin.user+xml;version=9.0"
"https://vcd/api/admin/user/0b684c61-3179-46ac-ac49-5e9951c331d9"
 
## 7. User Modification
There are only possible modification to enable or disable the user.
These are handled similar way as disabling the user before deleting the account as explained in previous chapter. If new email is need to be set for account previous one need to be removed and new one should be created.
