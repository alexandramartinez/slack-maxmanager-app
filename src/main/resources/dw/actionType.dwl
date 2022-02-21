%dw 2.0
output application/json
---
if ( !isEmpty(payload.event["type"]) )
    payload.event["type"]
else if ( !isEmpty(payload["type"]) )
    payload["type"]
else payload.command