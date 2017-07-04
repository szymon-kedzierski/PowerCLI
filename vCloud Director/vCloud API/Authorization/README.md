# Logging to vCloud Director API

## 1. Obtain session ID

First use Basic authentication to obtain session ID:
`POST https://vCD/api/sessions`

Header:

Content-Length ›1521
Content-Type ›application/vnd.vmware.vcloud.session+xml;version=9.0
Date ›Tue, 04 Jul 2017 08:34:56 GMT
X-VMWARE-VCLOUD-REQUEST-EXECUTION-TIME ›189
X-VMWARE-VCLOUD-REQUEST-ID › {request_ID}
<b> x-vcloud-authorization › {auth_ID} </b>

## 2. Now you can use this {auth_ID} in requests

`curl -X GET \
  https://vCD/api/org \
  -H 'accept: application/*+xml;version=9.0' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.vmware.admin.user+xml' \
  -H 'postman-token: c293afd7-8d1d-08d9-6910-391213c49a2e' \
  -H 'x-vcloud-authorization: {auth_ID}'`