const path    = require("path");
const express = require("express");
const router  = express.Router();

router.use((req, res, next) => {
    res.set("Cache-Control", "public, max-age=3600");
    next();
});

router.get("/*", async (req, res, next) => {
    const ext = req.params[0].substring(
        req.params[0].lastIndexOf('.') + 1
    );

    if (["ico", "svg", "png", "jpeg", "gif", "webp"].indexOf(ext) == -1)
        return next(404);

    res
        .type(`.${ext}`)
        .sendFile(path.resolve(`public/img${req.path}`), err => {
            if (err) {
                next(404);
            }
        });
});

module.exports = router;
