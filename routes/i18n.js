const path    = require("path");
const express = require("express");
const router  = express.Router();

router.use((req, res, next) => {
    res.set("Cache-Control", "public, max-age=3600");
    next();
});

router.get("/*.json", (req, res) => {
    return res
        .type("json")
        .sendFile(path.resolve(`public/i18n/${req.params[0]}.json`));
});

module.exports = router;
