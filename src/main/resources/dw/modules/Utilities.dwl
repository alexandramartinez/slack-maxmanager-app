import try from dw::Runtime

fun isNumber(value: Any): Boolean = try(() -> value as Number).success
fun isArray(value: Any): Boolean = try(() -> value as Array).success
fun getNumber(value: Any): Number = (
    if ( isNumber(value) ) value as Number
    else 0
)
fun getArray(value: Any): Array = (
    if ( isArray(value) ) value as Array
    else []
)