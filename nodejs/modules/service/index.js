var path = require("path");
var fs = require('fs');

function generatesUrlArray() {
    return new Promise((resolve, reject) => {
        var arrayVideos;
        fs.readFile(path.join(__dirname, '../../../scripts/request'), "utf8", function (err, data) {
            if (err) reject(er)
            const regex = /watch\?v=(.*?)("|&)/g;
            while ((arrayVideos = regex.exec(data)) !== null) {
                if (arrayVideos.index === regex.lastIndex) regex.lastIndex++;
                arrayVideos.forEach((match, groupIndex) => {
                    if (groupIndex === 1) {
                        fs.appendFile(path.join(__dirname, '../../../scripts/response'), match + "\n", function (err) {
                        })
                    }
                });
            }
        });
        resolve("ok")
    })
}

module.exports = {
    generatesUrlArray
};