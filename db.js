const crypto = require("crypto");
const pg     = require("pg");

entityTables = {
    "user": "users",
    "club": "clubs"
};

class DBHelper
{
    constructor()
    {
        this.pool = null;

        this.params = {
            host:     process.env.DBHOST || "localhost",
            user:     process.env.DBUSER,
            password: process.env.DBPASSWORD,
            database: process.env.DBDATABASE,
            port:     process.env.DBPORT || 5432,
            max:      1
        };

        this.tgSecretKey = crypto
            .createHash("sha256")
            .update(process.env.BOT_TOKEN)
            .digest();
    }

    async start()
    {
        this.pool = new pg.Pool(this.params);

        this.pool.on("error", async (err, client) => {
            console.error("PostgreSQL pool is down!", err);
            await this.pool.end();
            process.exit(-1);
        });
    }

    async stop()
    {
        await this.pool.end();
    }

    async restart()
    {
        await this.stop();
        await this.start();
    }

    async getImage(album_owner_type, album_owner_id, album_id, image_hash, image_type)
    {
        let album = await this.pool.query(`
                select a.id, a.commentable from albums a
                join entities e on e.id = a.owner_id
                join ${entityTables[album_owner_type]} u on u.entity_id = e.id
                where u.id = ${isNaN(album_owner_id)
                    ? "select user_id from user_profiles where username = $2"
                    : "$2"}
                and a.id = $3
            `, [
                album_owner_type, album_owner_id, album_id
        ]);
        album = album.rows[0];
        if (!album)
            return null;

        let image = await this.pool.query(`
                select i.id, e.id, c.text, i.last_comment_index, i.saved_dt
                from images i
                join entities e on e.id = i.owner_id
                join content c on c.id = i.descr_id
                where i.album_id = $1
                and i.hash = $2
                and i.type = $3
            `, [
                album["id"], image_hash, image_type
        ]);
        image = image.rows[0];
        if (!image)
            return null;
    }

    getPool() {
        return this.pool;
    }
}

module.exports = new DBHelper();
