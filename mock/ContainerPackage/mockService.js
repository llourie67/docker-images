/* mockServices.js
     Simple "Customer" nodejs service.
   Usage:
     node mockServices.js [port]
   Author:
     Leif Lourie
*/

// Use strict mode
'use strict';

// Constants
// ---------
// The default port to use
const PORT = 8080;

// Variables
// ---------
// Use the express framework for this application  
var express = require('express');
var app = express();

// The bodyParser will be used to populate the req.body property with the parsed body from the request.
var bodyParser = require('body-parser');

// Keeping the small data-sets in local variables for simplicity
var customers = [
{
"customer_id": "1234",
"name": "Mark",
"gender": "Male",
"birthyear": "1967",
"hobby": "Hunting"
},
{
"customer_id": "5678",
"name": "Maria",
"gender": "Female",
"birthyear": "1981",
"hobby": "Horses"
}
];

// Setting the port to use
// -----------------------
// The port can be specified in several ways.
// If the port is not specified, we will use the default.
var port;
// First we check if the port is passed as argument
var args = process.argv.slice(2);
if (!args[0]) {
  // If the port is not passed in, then will check for MOCK_PORT env variable
  if (!process.env.MOCK_PORT) {
    //Cannot resolve the port, setting it to default
    port = PORT;
  } else {
    //Port was not passed in, but env variable is set, so taking that.
    port = process.env.MOCK_PORT;
  }
} else {
  // Port was passed in as an argument.
  port = args[0];
}


/* Accepting any type and assuming it is application/json, otherwise the caller
   is forced to pass the content-type specifically.
*/
function defaultContentTypeMiddleware (req, res, next) {
  req.headers['content-type'] = req.headers['content-type'] || 'application/json';
  next();
}

app.use(defaultContentTypeMiddleware);
app.use(bodyParser.json({ type: '*/*' }));

// /customer api
app.get('/customer/:id', function(req, res) {
  if (req.params.id == 999) {
  res.statusCode = 500;
  res.end('Sneaky, sneaky...');
  }

  for (var i=0; i<customers.length; i++) {
    if (customers[i].customer_id == req.params.id) {
    customers[i].serviceID = port.toString();
    res.statusCode = 200;
    res.json(customers[i]);
    }
  }

  res.statusCode = 404;
  res.end('Customer not found!');
});

app.post('/customer', function(req, res) {
  console.log('');
  console.log('----------------------------------');
  console.log('customer_id : ' + req.body.customer_id);
  console.log('phone_number : ' + req.body.phone_number);
  console.log('----------------------------------');
  console.log('');
  console.log('----------------------------------');
  console.log('Authorization header : ' +
  req.headers['authorization']);
  console.log('x-app-key header : ' + req.headers['x-appkey']);
  console.log('----------------------------------');
  console.log('');

  if (req.params.id == 999) {
    res.statusCode = 500;
    res.end('Sneaky, sneaky...');
  }

  for (var i=0; i<customers.length; i++) {
    if (customers[i].customer_id.toString() == req.body.customer_id) {
      customers[i].phone_number = req.body.phone_number;
      customers[i].serviceID = port.toString();
      res.statusCode = 200;
      res.json(customers[i]);
    }
  }

  res.statusCode = 404;
  res.end('Customer not found!');
});

// root
app.get('/', (req, res) => {
  res.send('You have reached the Mock Service');
});

//Creating the server process
app.listen(port);
console.log('Listening on port ' + port);
