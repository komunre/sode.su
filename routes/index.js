const path    = require("path");
const express = require("express");
const router  = express.Router();

const api = require("../api");

router.use((req, res, next) => {
    res.set("Cache-Control", "public, max-age=3600");
    next();
});

router.get("/robots.txt", async (req, res) => {
    return res
        .type("text")
        .sendFile(path.resolve("public/robots.txt"));
});

router.get("/api.json", async (req, res) => {
    return res
        .type(".json")
        .json(api);
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

router.get("/favicon.ico", async(req, res) => {
    return res
        .type(".ico")
        .sendFile(path.resolve("public/img/favicon.ico"));
});

module.exports = router;
