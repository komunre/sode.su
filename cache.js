const fs         = require("fs");
const handlebars = require("handlebars");

class Cache
{
    constructor() {
        this.load();
    }

    load()
    {
        this.page = handlebars.compile(fs.readFileSync("page.hbs").toString("utf-8"));
    }
}

module.exports = new Cache();
