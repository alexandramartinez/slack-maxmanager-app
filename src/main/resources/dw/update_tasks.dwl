%dw 2.0
output application/json
import getArray from dw::modules::Utilities
import update from dw::util::Values

var checkedTasksIds:Array = getArray(vars.checkedTasksIds)
---
tasksList: payload map (
    if (checkedTasksIds contains $.id)
        $ update "selected" with true
    else 
        $ update "selected" with false
)