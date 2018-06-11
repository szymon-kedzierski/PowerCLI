# How to interact with Tenant API

## Log same as system login:
`POST https://vCD/api/sessions`

If you use tenant user you will see only resources that belongs to this tenant.

## VM Metrics

To get current metrics there is no need for Cassandra DB.
For historic metrics there is need to set up Cassandra DB. 

Get current vm metrics

`GET https://vCD/api/vApp/vm-{id}/metrics/current`

Example response:

`<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<CurrentUsage xmlns="http://www.vmware.com/vcloud/v1.5" xmlns:ovf="http://schemas.dmtf.org/ovf/envelope/1" xmlns:vssd="http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_VirtualSystemSettingData" xmlns:common="http://schemas.dmtf.org/wbem/wscim/1/common" xmlns:rasd="http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_ResourceAllocationSettingData" xmlns:vmw="http://www.vmware.com/schema/ovf" xmlns:vmext="http://www.vmware.com/vcloud/extension/v1.5" xmlns:ovfenv="http://schemas.dmtf.org/ovf/environment/1" xmlns:ns9="http://www.vmware.com/vcloud/networkservice/1.0" xmlns:ns10="http://www.vmware.com/vcloud/networkservice/common/1.0" xmlns:ns11="http://www.vmware.com/vcloud/networkservice/ipam/1.0" xmlns:ns12="http://www.vmware.com/vcloud/versions">
    <Link rel="up" href="https://vcd/api/vApp/vm-{id}]" type="application/vnd.vmware.vcloud.vm+xml"/>
    <Metric name="disk.read.average" unit="KILOBYTES_PER_SECOND" value="0.0"/>
    <Metric name="cpu.usage.average" unit="PERCENT" value="0.62"/>
    <Metric name="disk.write.average" unit="KILOBYTES_PER_SECOND" value="2.0"/>
    <Metric name="cpu.usage.maximum" unit="PERCENT" value="0.62"/>
    <Metric name="cpu.usagemhz.average" unit="MEGAHERTZ" value="11.0"/>
    <Metric name="mem.usage.average" unit="PERCENT" value="3.99"/>
    <Metric name="disk.used.latest.0" unit="KILOBYTE" value="76868617"/>
    <Metric name="disk.used.latest.1" unit="KILOBYTE" value="76868617"/>
    <Metric name="disk.used.latest.2" unit="KILOBYTE" value="76868617"/>
    <Metric name="disk.provisioned.latest.0" unit="KILOBYTE" value="76868618"/>
    <Metric name="disk.provisioned.latest.1" unit="KILOBYTE" value="76868618"/>
    <Metric name="disk.provisioned.latest.2" unit="KILOBYTE" value="76868618"/>
</CurrentUsage>`
