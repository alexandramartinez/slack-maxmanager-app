%dw 2.0
output application/json
import getNumber, getArray from dw::modules::Utilities

var newCounter:Number = (getNumber(vars.counter)) + 1
var newTask:Object = {
	id: "task " ++ newCounter,
	text: vars.taskText default "",
	selected: false,
	link: vars.messageLink default ""
}
---
{
	counter: newCounter,
	tasksList: getArray(payload) + newTask
}