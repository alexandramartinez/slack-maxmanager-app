%dw 2.0
output application/json
var messageText = payload.message.text default ""
var triggerId = payload.trigger_id
var domain = payload.team.domain default ""
var channelId = payload.channel.id default ""
var messageTs = (payload.message_ts replace "." with "") default ""
var link = if ( !isEmpty(domain) and !isEmpty(channelId) and !isEmpty(messageTs) )
        "https://$(domain).slack.com/archives/$(channelId)/p$(messageTs)"
    else ""
---
{
    trigger_id: triggerId,
    view: {
        "type": "modal",
        "title": {
            "type": "plain_text",
            "text": "Create Task",
            "emoji": true
        },
        "submit": {
            "type": "plain_text",
            "text": "Submit",
            "emoji": true
        },
        "close": {
            "type": "plain_text",
            "text": "Cancel",
            "emoji": true
        },
        "blocks": [
            {
                "type": "input",
                "element": {
                    "type": "plain_text_input",
                    "action_id": "plain_text_input-action",
                    ("initial_value": messageText)
                        if ( !isEmpty(messageText) )
                },
                "label": {
                    "type": "plain_text",
                    "text": "Task Title",
                    "emoji": true
                }
            },
			({
				"type": "context",
				"elements": [
					{
						"type": "plain_text",
						"text": link,
						"emoji": true
					}
				]
			}) if ( !isEmpty(link) )
        ]
    }
}