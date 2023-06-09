const functions = require('@google-cloud/functions-framework');

const crypto = require('crypto');
const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { getFirestore, Timestamp, FieldValue, Filter } = require('firebase-admin/firestore');

initializeApp();

const db = getFirestore();
const secret = "helloworld"; // Store this somewhere secure!

functions.http('hubspot_webhook', (req, res) => {
  console.log('Handling request');
  if (!validateV3RequestSignature(req,secret)) {
    res.status(403).send('Unauthorized');
  } else {
    insertDocuments(req.body);
    res.end(`Created ${req.body.length} documents`);
  }
  
});

function validateV3RequestSignature(request, secret) {
  // Get the request headers.
  const timestamp = request.headers["x-hubspot-request-timestamp"];
  const signature = request.headers["x-hubspot-signature-v3"];

  // Validate the timestamp.
  const now = Date.now();
  if (Math.abs(now - timestamp) > 300000) {
    return false;
  }

  // Create the HMAC SHA-256 hash.
  const hmac = crypto.createHmac("sha256", secret);
  hmac.update(request.method + request.originalUrl + request.rawBody + timestamp, "utf-8");
  const hash = hmac.digest("base64");

  // Compare the hash to the signature.
  return signature === hash;
}

function insertDocuments(forms) {
  const collection = db.collection('forms');
  // TODO(markeccles): Use the batch API.
  for (const form of forms) {
    collection.add(form);
  }
}

