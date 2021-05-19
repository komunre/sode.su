module.exports = {
    "HOST":   "https://sode.su",
    "DOMAIN": "sode.su",
    "SOCKET": "wss://sode.su/ws",
    "URL": {
        "POST":  "p",
        "IMAGE": "i",
        "VIDEO": "v",
        "MUSIC": "m"
    },
    "SECTIONS": {
        "HOME":       "home",
        "FRIENDS":    "friends",
        "CHATS":      "c",
        "FEED":       "feed",
        "FEEDBACK":   "feedback",
        "CLUBS":      "clubs",
        "IMAGES":     "i",
        "VIDEOS":     "v",
        "MUSIC":      "m",
        "HELP":       "https://t.me/sodesu_blog",
        "PROFILE":    "profile",
        "THEMES":     "t",
        "ACCOUNT":    "account",
        "MODERATION": "moderation",
        "STYLE":      "t/style"
    },
    "PATHS": {
        "I18N":          "i18n/",
        "PAGES":         "html/",
        "LAYOUT":        "html/",
        "SCRIPTS":       "js/",
        "POSTS":         "p/",
        "IMAGES":        "i/",
        "AVATARS":       "i/@/",
        "PUBLIC_IMAGES": "i/+/",
        "VIDEOS":        "v/",
        "MUSIC":         "m/",
        "STYLES": {
            "PROFILE": "css/@/",
            "FRIENDS": "css/friends/"
        }
    },
    "FILES": {
        "STATS":   "stats.json",
        "PROFILE": "profile.json",
        "BIO":     "bio.smu",
        "THEMES":  "css/css.json",
        "WALL":    "wall.json"
    },
    "AFFIXES": {
        "ENTITIES": {
            "person": "@",
            "club":   "~"
        },
        "DICTIONARY_SUFFIX": ".json",
        "PAGE_SUFFIX":       ".html",
        "LAYOUT_SUFFIX":     ".html",
        "SCRIPT_SUFFIX":     ".js",
        "POST_SUFFIX":       ".json",
        "IMAGE_INFO_SUFFIX": ".json",
        "VIDEO_INFO_SUFFIX": ".json",
        "TRACK_INFO_SUFFIX": ".json",
        "STYLE_SUFFIX":      ".css",
        "FONT_SUFFIX":       ".otf",
        "STYLE_INFO_SUFFIX": ".css.json",
        "FONT_INFO_SUFFIX":  ".otf.json"
    },
    "ACTIONS": {
        "USERS":                     "api/users",
        "ME":                        "api/me",
        "LOG_IN":                    "api/log_in",
        "SIGN_UP":                   "api/sign_up",
        "EDIT_PROFILE":              "api/edit_profile",
        "FRIENDS":                   "api/friends",
        "INCOMING_FRIEND_REQUESTS":  "api/incoming_friend_requests",
        "OUTCOMING_FRIEND_REQUESTS": "api/outcoming_friend_requests",
        "FRIEND":                    "api/friend",
        "UNFRIEND":                  "api/unfriend",
        "NEW_MEDIA_COMMENT":         "api/new_media_comment",
        "NEW_POST_COMMENT":          "api/new_post_comment",
        "UNPIN_POST":                "api/unpin_post",
        "PIN_POST":                  "api/pin_post",
        "DELETE_POST":               "api/delete_post",
        "NEW_POST":                  "api/new_post"
    },
    "ERRORS": {
        "OK": 0,
        "NO_REQUIRED_PARAMETERS_IN_REQUEST": -1,
        "NO_REQUIRED_COOKIES":               -2,
        "USERID_NOT_FOUND":                  -3,
        "WRONG_PASSWORD":                    -4,
        "VERIFICATION_FAILED":               -5,
        "BANNED":                            -6,
        "HEADER_IS_EMPTY":                   -7,
        "HEADER_IS_TOO_LONG":                -8,
        "TEXT_IS_EMPTY":                     -9,
        "TEXT_IS_TOO_LONG":                  -10,
        "ACCESS_DENIED":                     -11,
        "OBJ_DOES_NOT_EXIST":                -12,
        "EMAIL_IS_OCCUPIED":                 -13,
        "OBJ_EXISTS":                        -14,
        "MOD_EMAIL_SENT_FAILED":             -15,
        "EMAIL_NOT_FOUND":                   -16,
        "VERIFICATION_ALREADY_CLOSED":       -17,
        "WRONG_VERIFICATION_CODE":           -18,
        "INACCESSIBLE_FRIEND":               -19,
        "ALREADY_FRIENDED":                  -20,
        "INVALID_DATA":                      -21,
        "FILE_NOT_UPLOADED":                 -22,
        "FILE_IS_TOO_LARGE":                 -23,
        "OVERFLOW":                          -24,
        "NAME_EXISTS":                       -25,
        "SESSION_IS_UNIDENTIFIED":           -26,
        "HACKER_ATTACK":                     -37,
        "MAINTENANCE":                       -38,
        "ERROR":                             -29
    },
    "LIMITS": {
        "COMMENT_LENGTH": 1500,
        "POST_LENGTH":    15000,
        "BIO_LENGTH":     15000
    },
    "LANGS": {
        "eng": "English",
        "rus": "Русский"
    },
    "LANG_2TO3": {
        "en": "eng",
        "ru": "rus",
        "ja": "nih"
    },
    "LANG_3TO2": {
        "eng": "en",
        "rus": "ru",
        "nih": "ja"
    },
    "ENTITIES": {
        "@": "person",
        "~": "club"
    },
    "FILE_FORMATS": {
        "THEMES": [ "css" ],
        "FONTS":  [ "ttf" ],
        "IMAGES": [ "svg", "png", "gif", "jpeg", "webp", "bmp" ],
        "VIDEOS": [ "webm", "mpeg", "mp4", "avi", "mov" ],
        "AUDIOS": [ "mp3", "wav", "ogg" ]
    },
    "DEFAULT": {
        "CSS": "default.css",
        "USER": {
            "type":   "person",
            "id":     0,
            "avatar": "person.png"
        }
    }
};
