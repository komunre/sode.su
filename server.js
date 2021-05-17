const fs               = require("fs");
const path             = require("path");
const https            = require("https");
const express          = require("express");
const cookieParser     = require("cookie-parser");
const expressUseragent = require("express-useragent");
const bodyParser       = require("body-parser");
const helmet           = require("helmet");

const { compress, decompress } = require("express-compress");

const indexRouter = require("./routes");
const i18nRouter  = require("./routes/i18n");
const imgRouter   = require("./routes/img");



class Server
{
    constructor(port)
    {
        this.server = null;
        this.port   = port;

        this.app = express();

        this.app.use(cookieParser());
        this.app.use(expressUseragent.express());
        this.app.use(compress());
        this.app.use(decompress());
        this.app.use(bodyParser.json());
        this.app.use(helmet());

        this.app.use((req, res, next) => {
            res.set("Server", "Desu");
            next();
        });

        this.app.use("/",     indexRouter);
        this.app.use("/i18n", i18nRouter);
        this.app.use("/img",  imgRouter);

        this.app.use((err, req, res, next) => {
            res
                .status(err)
                .type(".html")
                .set("Cache-Control", "public, max-age: 0")
                .sendFile(path.resolve(`html/errors/${err}.html`));
        });

        if (this.port == 443) {
            this.server = https.createServer({
                    key:  fs.readFileSync(process.env.CERT_KEY),
                    cert: fs.readFileSync(process.env.CERT_CHAIN)
                },
                this.app
            );
        }
    }

    start()
    {
        const server = this.server ? this.server : this.app;

        server.listen(this.port, () => {
            console.log(`Server running at localhost on port ${this.port}`);
        });

        server.on("connection", socket => {
            socket.keepAlive(true);
        })
    }

    stop()
    {
        console.log("Stop the server...");
        process.exit(0);
    }

    reload()
    {
        console.log("Reload the server...");

        console.log("Server reloaded.");
    }
}




module.exports = Server;
