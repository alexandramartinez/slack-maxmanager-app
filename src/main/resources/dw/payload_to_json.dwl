%dw 2.0
output application/json
import decodeURIComponent from dw::core::URL
import try from dw::Runtime

var urlEncodedResult = try(() -> 
    read(decodeURIComponent(payload.payload))
)
---
urlEncodedResult match {
    case r if r.success == true -> r.result
    else -> payload
}