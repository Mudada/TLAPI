# TLAPI
This crapy api is designed to get online streams, live events and upcoming events who are referenced in http://www.teamliquid.net/. Response are in JSON. Note that i didn't do error management for now so if you request a `/uevents/:id` with a bad `:id` it will probably answer with an error ¯\\_(ツ)_/¯


## How does this shit work
| endpoint  | result   |
|---------|--------------|
|`GET:/streams`  | ```{"featured":[{streamer:streamer,game:"game",url:"url"]}"non_featured":[{streamer:streamer,game:"game",url:"url"]}```  |
| `GET:/uevents` | ```{ids: [id, id1, ...]}``` |
| `GET:/uevents/:id`  | ```{"uevent":{name:"name",date:"date",timer:"time",game:"game"}}```|
| `GET:/levents` | ```{ids: [id, id1, ...]}``` |
| `GET:/levents/:id`  | ```{"levent":{name:"name",date:"date",timer:"time",game:"game"}}```|

