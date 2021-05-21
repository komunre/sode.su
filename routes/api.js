const path    = require("path");
const express = require("express");
const router  = express.Router();

router.use((req, res, next) => {
    res.set("Cache-Control", "public, max-age=0");
    next();
});

router.post("/auth", async (req, res, next) => {
    console.info(req.body.user);
    res.json({
        status: 0
    });
});

module.exports = router;
