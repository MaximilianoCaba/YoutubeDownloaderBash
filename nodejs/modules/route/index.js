const express = require('express');
const router = express.Router();

const services = require("../service");


router.post("/generate/url/youtube",(req, res) =>{
    services.generatesUrlArray()
        .then(response =>res.status(200).json(response))
        .catch(err => res.status(400).json(err));
});


module.exports = router;