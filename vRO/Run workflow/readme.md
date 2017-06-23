# Run workflow from API

## 1. Find workflow by name

Note: If the workflow name has spaces, replace the spaces with %20

`GET https://vRO:8281/vco/api/workflows/?conditions=name%3Dtest1`

Response: 200

`"link": [
    {
      "attributes": [
        {
          "value": "https://vRO:8281/vco/api/workflows/{WORKFLOW_ID}/",
          "name": "itemHref"
        },
		...
		`
## 2. Start workflow

`POST https://vRO:8281/vco/api/workflows/{WORKFLOW_ID}/executions/`

Body:

`<execution-context xmlns="http://www.vmware.com/vco">
    <parameters>
        <parameter type="string" name="par1" scope="local">
            <string>Value1</string>
        </parameter>
    </parameters>
</execution-context>`

Response: 202

`...
Location https://vRO:8281/vco/api/workflows/{workflowID}/executions/{Execution_ID}/
...`

## 3. Check executions

`GET https://vRO:8281/vco/api/workflows/{WORKFLOW_ID}/executions/{Execution_ID}`