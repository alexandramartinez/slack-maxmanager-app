%dw 2.0
output application/json
import getArray from dw::modules::Utilities

fun getCheckbox(text:String, id:String, link:String=""): Object = {
    text: {
        "type": "mrkdwn",
        text: text,
    },
    value: id,
    (description: {
        "type": "mrkdwn",
    	text: link
    }) if ( !isEmpty(link) )
}
fun getFormattedTasks(tasks:Array): Array = (
    tasks map getCheckbox($.text, $.id, $.link)
)
var tasksList:Array = getArray(payload) match {
    case [] -> getArray(payload.tasksList)
    else -> $
}
var checkedTasks:Array = tasksList filter ($.selected)
---
{
    user_id: vars.userId,
    "view": {
		"type": "home",
		"blocks": [
			{
				"type": "actions",
				"elements": [
					{
						"type": "checkboxes",
						("initial_options": getFormattedTasks(checkedTasks)) 
                            if ( !isEmpty(checkedTasks) ),
						"options": getFormattedTasks(tasksList)
					},
					{
						"type": "button",
						"text": {
							"type": "plain_text",
							"text": "Add Item",
							"emoji": true
						},
						"style": "primary"
					}
				]
			}
		]
	}
}