#!/bin/bash

curl -m 5 -X POST https://hubspot-webhook-r3j7hjaf2a-uc.a.run.app \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-H "x-hubspot-request-timestamp: $(date +%s%N | cut -b1-13)" \
-H "x-hubspot-signature-v3: QBHl8Su6/xUbM26w72sYvURh8lTXTSIkOq/j+u1SNRY=" \
-d '[
  {
    "objectId": 1246965,
    "propertyName": "lifecyclestage",
    "propertyValue": "subscriber",
    "changeSource": "ACADEMY",
    "eventId": 3816279340,
    "subscriptionId": 25,
    "portalId": 33,
    "appId": 1160452,
    "occurredAt": 1462216307945,
    "eventType":"contact.propertyChange",
    "attemptNumber": 0
  },
  {
    "objectId": 1246978,
    "changeSource": "IMPORT",
    "eventId": 3816279480,
    "subscriptionId": 22,
    "portalId": 33,
    "appId": 1160452,
    "occurredAt": 1462216307945,
    "eventType": "contact.creation",
    "attemptNumber": 0
  }
]
'
