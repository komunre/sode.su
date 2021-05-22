class Auth {
	constructor() {

	}

	checkKey(req, res, db) {
		let key = db.getPool().query(`select key from public.sessions where user_id=$1`, [req.cookies.user]);
		if (key.rows == undefined) {
			res.locals.authorized = false;
		}
		key = key.rows[0].key;
		if (req.cookies.key == key) {
			res.locals.authorized = true;
		}
		else {
			res.locals.authorized = false;
		}
	}
}

module.exports = new Auth();