const path    = require("path");
const express = require("express");
const router  = express.Router();

router.use((req, res, next) => {
    res.set("Cache-Control", "public, max-age=3600");
    next();
})

router.get("/robots.txt", async (req, res) => {
    return res
        .type("text")
        .sendFile(path.resolve("public/robots.txt"));
});

router.get("/api.json", async (req, res) => {
    return res
        .type(".json")
        .sendFile(path.resolve("public/api.json"));
});

router.get("/emoji.json", async (req, res) => {
    return res
        .type(".json")
        .sendFile(path.resolve("public/emoji.json"));
});

router.get("/manifest.json", async (req, res) => {
    return res
        .type(".json")
        .sendFile(path.resolve("public/manifest.json"));
});

router.get("/sitemap.xml", async (req, res) => {
    return res
        .type(".xml")
        .sendFile(path.resolve("public/sitemap.xml"));
});

module.exports = router;
