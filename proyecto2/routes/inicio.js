var express = require('express');
var router = express.Router();
var mongo = require('mongodb').MongoClient;
var objectId = require('mongodb').ObjectID;
var assert = require('assert');
var antLat="";
var antLong="";
var antEm="";

var url = 'mongodb://10.131.137.224:27017/test';

/* GET home page.   mongodb://10.131.137.224:27017/test'   10.131.137.224:27017 */
router.get('/', function(req, res, next) {
  res.render('inicio');
});

router.post('/insert', function(req, res, next) {
  if(antEm == JSON.stringify(req.body.email)){
    console.log("Emails Iguales");
  } else {
    console.log("Emails diferentes");
  }
  
  if(antLat != JSON.stringify(req.body.Latitud) && antLong != JSON.stringify(req.body.Longitud)){
    antLat = JSON.stringify(req.body.Latitud);
    antLong = JSON.stringify(req.body.Longitud);
    antEm = JSON.stringify(req.body.email);

    console.log("MENSAJE MIO");
    console.log(antEm);
    var item = {
      latitud: req.body.Latitud,
      longitud: req.body.Longitud,
      email: req.body.email
    };


    mongo.connect(url, function(err, db) {
      assert.equal(null, err);
      db.collection('data').insertOne(item, function(err, result) {
      assert.equal(null, err);
      console.log('Item inserted');
      db.close();
    });
  });

  }else{
    console.log("No guardó");
  }
  res.redirect('/inicio');


});


module.exports = router;
