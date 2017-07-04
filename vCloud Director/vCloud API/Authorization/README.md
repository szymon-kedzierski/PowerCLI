# Logging to vCloud Director API

## 1. Obtain session ID

First use Basic authentication to obtain session ID:
`POST https://vCD/api/sessions`

Header response:
...

x-vcloud-authorization › {auth_ID} </b>

## 2. Now you can use this {auth_ID} in requests

`curl -X GET \
  https://vCD/api/org \
  -H 'accept: application/*+xml;version=9.0' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/vnd.vmware.admin.user+xml' \
  -H 'postman-token: c293afd7-8d1d-08d9-6910-391213c49a2e' \
  -H 'x-vcloud-authorization: {auth_ID}'`
