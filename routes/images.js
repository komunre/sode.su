const path    = require("path");
const express = require("express");
const router  = express.Router();

const db  = require("../db");
const api = require("../api");

router.use((req, res, next) => {
    res.set("Cache-Control", "public, max-age=3600");
    next();
});

router.get(/^\/(@|~)([^\/]*)\/i\/([^\/]*)\/([^\/]*)\.(jpeg|png|gif|bmp|webp|svg)$/, async (req, res, next) => {
    try {
        const image = await db.getImage(
            api.entities[req.params[0]], req.params[1], req.params[2], req.params[3], req.params[4]
        );
        if (!image)
            return next(404);

        res
            .type(`.${req.params[4]}`)
            .sendFile(path.resolve(`images/${req.params[4]}/${req.params[3]}.${req.params[4]}`), err => {
                if (err) {
                    next(500);
                }
            });
    }
    catch (err) {
        next(500);
    }
});

module.exports = router;
