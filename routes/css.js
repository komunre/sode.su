const path    = require("path");
const express = require("express");
const router  = express.Router();

router.use((req, res, next) => {
    res.set("Cache-Control", "public, max-age=3600");
    next();
});

router.get("/*.css", async (req, res, next) => {
    res
        .type(".css")
        .sendFile(path.resolve(`public/css${req.path}`), err => {
            if (err) {
                next(404);
            }
        });
});

router.get("/fonts/*.ttf", async (req, res, next) => {
    res
        .type(".ttf")
        .sendFile(path.resolve(`public/css${req.path}`), err => {
            if (err) {
                next(404);
            }
        });
});

module.exports = router;
