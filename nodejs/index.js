const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const express = require('express');
const morgan = require('morgan');

const app = express();

const routes = require("./modules/route");

function initMiddlewares() {
    app.use(bodyParser.urlencoded({extended: true}));
    app.use(bodyParser.json());
    app.use(morgan('combined'));
    app.use(cookieParser());
    app.use("/public", express.static("public"));
}

function initRoutes() {
    app.use('/api', routes);
}

function initServer() {

    app.listen(5000, () => {
        console.log("Started application");
        console.log("URL: http://localhost:5000");
        console.log("URL API: http://localhost:5000");

    });
}

initMiddlewares();
initRoutes();
initServer();