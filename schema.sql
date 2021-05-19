

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE TYPE public.access AS ENUM (
    'private',
    'protected',
    'public'
);


ALTER TYPE public.access OWNER TO sodesu;


CREATE TYPE public.artifact_type AS ENUM (
    'hashtag',
    'mention',
    'shashtag',
    'cashtag',
    'phone',
    'email',
    'link'
);


ALTER TYPE public.artifact_type OWNER TO sodesu;


CREATE TYPE public.audio_format AS ENUM (
    'mp3',
    'ogg',
    'wav'
);


ALTER TYPE public.audio_format OWNER TO sodesu;


CREATE TYPE public.entity_type AS ENUM (
    'user',
    'club'
);


ALTER TYPE public.entity_type OWNER TO sodesu;


CREATE TYPE public.file_format AS ENUM (
    'css',
    'jpeg',
    'png',
    'gif',
    'svg',
    'webp',
    'bmp',
    'mp4',
    'webm',
    'avi',
    'mov',
    'mpeg',
    'mp3',
    'ogg',
    'wav'
);


ALTER TYPE public.file_format OWNER TO sodesu;


CREATE TYPE public.image_format AS ENUM (
    'jpeg',
    'png',
    'gif',
    'svg',
    'webp',
    'bmp'
);


ALTER TYPE public.image_format OWNER TO sodesu;


CREATE TYPE public.user_role AS ENUM (
    'user',
    'moder',
    'admin'
);


ALTER TYPE public.user_role OWNER TO sodesu;


CREATE TYPE public.video_format AS ENUM (
    'mp4',
    'webm',
    'avi',
    'mov',
    'mpeg'
);


ALTER TYPE public.video_format OWNER TO sodesu;

SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE public.albums (
    id bigint NOT NULL,
    visibility public.access DEFAULT 'private'::public.access NOT NULL,
    name character varying(255) NOT NULL,
    descr_id bigint DEFAULT 1 NOT NULL,
    owner_id bigint NOT NULL,
    poster_image_id bigint,
    commentable public.access DEFAULT 'public'::public.access NOT NULL,
    anon_comments_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.albums OWNER TO sodesu;


CREATE SEQUENCE public.albums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;



CREATE TABLE public.artifacts (
    id bigint NOT NULL,
    type public.artifact_type NOT NULL,
    string character varying(1024) NOT NULL
);


ALTER TABLE public.artifacts OWNER TO sodesu;


CREATE SEQUENCE public.artifacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artifacts_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.artifacts_id_seq OWNED BY public.artifacts.id;



CREATE TABLE public.artifacts_in_content (
    id bigint NOT NULL,
    content_id bigint NOT NULL,
    artifact_id bigint NOT NULL,
    "position" integer NOT NULL,
    length integer NOT NULL
);


ALTER TABLE public.artifacts_in_content OWNER TO sodesu;


CREATE SEQUENCE public.artifacts_in_content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artifacts_in_content_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.artifacts_in_content_id_seq OWNED BY public.artifacts_in_content.id;



CREATE TABLE public.bans (
    id bigint NOT NULL,
    entity_id bigint NOT NULL,
    until_dt timestamp without time zone NOT NULL,
    reason_id bigint NOT NULL,
    banned_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.bans OWNER TO sodesu;


CREATE SEQUENCE public.bans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bans_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.bans_id_seq OWNED BY public.bans.id;



CREATE TABLE public.blacklist (
    id bigint NOT NULL,
    issuer_id bigint NOT NULL,
    banned_id bigint NOT NULL,
    issued_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.blacklist OWNER TO sodesu;


CREATE SEQUENCE public.blacklist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blacklist_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.blacklist_id_seq OWNED BY public.blacklist.id;



CREATE TABLE public.content (
    id bigint NOT NULL,
    hash bigint NOT NULL,
    text text NOT NULL
);


ALTER TABLE public.content OWNER TO sodesu;


CREATE SEQUENCE public.content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.content_id_seq OWNED BY public.content.id;



CREATE TABLE public.emoji (
    id bigint NOT NULL,
    string character varying(32) NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.emoji OWNER TO sodesu;


CREATE SEQUENCE public.emoji_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emoji_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.emoji_id_seq OWNED BY public.emoji.id;



CREATE TABLE public.entities (
    id bigint NOT NULL
);


ALTER TABLE public.entities OWNER TO sodesu;


CREATE SEQUENCE public.entities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entities_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.entities_id_seq OWNED BY public.entities.id;



CREATE TABLE public.friends (
    id bigint NOT NULL,
    offerer_id bigint NOT NULL,
    acceptor_id bigint NOT NULL,
    since_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.friends OWNER TO sodesu;


CREATE SEQUENCE public.friends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friends_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.friends_id_seq OWNED BY public.friends.id;



CREATE TABLE public.images (
    id bigint NOT NULL,
    album_id bigint NOT NULL,
    media_id bigint NOT NULL,
    owner_id bigint NOT NULL,
    descr_id bigint DEFAULT 1 NOT NULL,
    last_comment_index bigint DEFAULT 0 NOT NULL,
    saved_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.images OWNER TO sodesu;


CREATE SEQUENCE public.images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;



CREATE TABLE public.langs (
    id bigint NOT NULL,
    code character(3) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.langs OWNER TO sodesu;


CREATE SEQUENCE public.langs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.langs_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.langs_id_seq OWNED BY public.langs.id;



CREATE TABLE public.media (
    id bigint NOT NULL,
    hash bigint NOT NULL,
    format public.file_format NOT NULL,
    uploader_id bigint NOT NULL
);


ALTER TABLE public.media OWNER TO sodesu;


CREATE SEQUENCE public.media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.media_id_seq OWNED BY public.media.id;



CREATE TABLE public.music (
    id bigint NOT NULL,
    playlist_id bigint NOT NULL,
    media_id bigint NOT NULL,
    title character varying(1024) NOT NULL,
    artist character varying(1024) DEFAULT ''::character varying NOT NULL,
    poster_image_id bigint NOT NULL,
    saved_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    lyrics_id bigint DEFAULT 1 NOT NULL
);


ALTER TABLE public.music OWNER TO sodesu;


CREATE SEQUENCE public.music_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.music_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.music_id_seq OWNED BY public.music.id;



CREATE TABLE public.music_tags (
    id bigint NOT NULL,
    music_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.music_tags OWNER TO sodesu;


CREATE SEQUENCE public.music_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.music_tags_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.music_tags_id_seq OWNED BY public.music_tags.id;



CREATE TABLE public.playlists (
    id bigint NOT NULL,
    visibility public.access DEFAULT 'private'::public.access NOT NULL,
    name character varying(255) NOT NULL,
    descr_id bigint DEFAULT 1 NOT NULL,
    owner_id bigint NOT NULL,
    poster_image_id bigint,
    commentable public.access DEFAULT 'public'::public.access NOT NULL,
    anon_comments_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.playlists OWNER TO sodesu;


CREATE SEQUENCE public.playlists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlists_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.playlists_id_seq OWNED BY public.playlists.id;



CREATE TABLE public.poll_answers (
    id bigint NOT NULL,
    index smallint NOT NULL,
    poll_id bigint NOT NULL,
    text_id bigint NOT NULL
);


ALTER TABLE public.poll_answers OWNER TO sodesu;


CREATE SEQUENCE public.poll_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poll_answers_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.poll_answers_id_seq OWNED BY public.poll_answers.id;



CREATE TABLE public.poll_votes (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    answer_id bigint NOT NULL
);


ALTER TABLE public.poll_votes OWNER TO sodesu;


CREATE SEQUENCE public.poll_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poll_votes_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.poll_votes_id_seq OWNED BY public.poll_votes.id;



CREATE TABLE public.polls (
    id bigint NOT NULL,
    multiple_answers boolean DEFAULT false NOT NULL,
    quiz boolean DEFAULT false NOT NULL,
    voting_visibility public.access DEFAULT 'private'::public.access NOT NULL,
    closing_dt timestamp without time zone,
    corrent_answer_id bigint,
    hint_id bigint
);


ALTER TABLE public.polls OWNER TO sodesu;


CREATE SEQUENCE public.polls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polls_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.polls_id_seq OWNED BY public.polls.id;



CREATE TABLE public.profile_links (
    id bigint NOT NULL,
    entity_id bigint NOT NULL,
    label character varying(32) DEFAULT ''::character varying NOT NULL,
    artifact_id bigint NOT NULL
);


ALTER TABLE public.profile_links OWNER TO sodesu;


CREATE SEQUENCE public.profile_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_links_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.profile_links_id_seq OWNED BY public.profile_links.id;



CREATE TABLE public.prohibited_media (
    id bigint NOT NULL,
    type public.file_format NOT NULL,
    hash bigint NOT NULL,
    reason text NOT NULL
);


ALTER TABLE public.prohibited_media OWNER TO sodesu;


CREATE SEQUENCE public.prohibited_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prohibited_media_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.prohibited_media_id_seq OWNED BY public.prohibited_media.id;



CREATE TABLE public.sessions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    key character(36) NOT NULL,
    ip inet NOT NULL,
    auth_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    useragent character varying(255) NOT NULL
);


ALTER TABLE public.sessions OWNER TO sodesu;


CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;



CREATE TABLE public.user_profiles (
    user_id bigint NOT NULL,
    username character varying(32) DEFAULT NULL::character varying,
    searchable boolean DEFAULT true NOT NULL,
    cover_image_id bigint,
    avatar_image_id bigint,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    bio_id bigint NOT NULL,
    friendable public.access DEFAULT 'public'::public.access NOT NULL,
    invitable public.access DEFAULT 'protected'::public.access NOT NULL,
    commentable public.access DEFAULT 'public'::public.access NOT NULL,
    anon_comments_only boolean DEFAULT false NOT NULL,
    last_post_index bigint DEFAULT 0 NOT NULL,
    pinned_post_index bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_profiles OWNER TO sodesu;


CREATE TABLE public.users (
    id bigint NOT NULL,
    entity_id bigint NOT NULL,
    tg_id bigint NOT NULL,
    tg_username character varying(32) DEFAULT NULL::character varying,
    auth_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role public.user_role DEFAULT 'user'::public.user_role NOT NULL,
    registered_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    salt character(32) NOT NULL
);


ALTER TABLE public.users OWNER TO sodesu;


CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;



CREATE TABLE public.videolibs (
    id bigint NOT NULL,
    visibility public.access DEFAULT 'private'::public.access NOT NULL,
    name character varying(255) NOT NULL,
    descr_id bigint DEFAULT 1 NOT NULL,
    owner_id bigint NOT NULL,
    poster_image_id bigint,
    commentable public.access DEFAULT 'public'::public.access NOT NULL,
    anon_comments_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.videolibs OWNER TO sodesu;


CREATE SEQUENCE public.videolibs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videolibs_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.videolibs_id_seq OWNED BY public.videolibs.id;



CREATE TABLE public.videos (
    id bigint NOT NULL,
    videolib_id bigint NOT NULL,
    media_id bigint NOT NULL,
    owner_id bigint NOT NULL,
    title character varying(1024) NOT NULL,
    descr_id bigint DEFAULT 1 NOT NULL,
    poster_image_id bigint,
    content_rating smallint DEFAULT 0 NOT NULL,
    "360" boolean DEFAULT false NOT NULL,
    saved_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    last_comment_index bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.videos OWNER TO sodesu;


CREATE SEQUENCE public.videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_id_seq OWNER TO sodesu;


ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;



ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);



ALTER TABLE ONLY public.artifacts ALTER COLUMN id SET DEFAULT nextval('public.artifacts_id_seq'::regclass);



ALTER TABLE ONLY public.artifacts_in_content ALTER COLUMN id SET DEFAULT nextval('public.artifacts_in_content_id_seq'::regclass);



ALTER TABLE ONLY public.bans ALTER COLUMN id SET DEFAULT nextval('public.bans_id_seq'::regclass);



ALTER TABLE ONLY public.blacklist ALTER COLUMN id SET DEFAULT nextval('public.blacklist_id_seq'::regclass);



ALTER TABLE ONLY public.content ALTER COLUMN id SET DEFAULT nextval('public.content_id_seq'::regclass);



ALTER TABLE ONLY public.emoji ALTER COLUMN id SET DEFAULT nextval('public.emoji_id_seq'::regclass);



ALTER TABLE ONLY public.entities ALTER COLUMN id SET DEFAULT nextval('public.entities_id_seq'::regclass);



ALTER TABLE ONLY public.friends ALTER COLUMN id SET DEFAULT nextval('public.friends_id_seq'::regclass);



ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);



ALTER TABLE ONLY public.langs ALTER COLUMN id SET DEFAULT nextval('public.langs_id_seq'::regclass);



ALTER TABLE ONLY public.media ALTER COLUMN id SET DEFAULT nextval('public.media_id_seq'::regclass);



ALTER TABLE ONLY public.music ALTER COLUMN id SET DEFAULT nextval('public.music_id_seq'::regclass);



ALTER TABLE ONLY public.music_tags ALTER COLUMN id SET DEFAULT nextval('public.music_tags_id_seq'::regclass);



ALTER TABLE ONLY public.playlists ALTER COLUMN id SET DEFAULT nextval('public.playlists_id_seq'::regclass);



ALTER TABLE ONLY public.poll_answers ALTER COLUMN id SET DEFAULT nextval('public.poll_answers_id_seq'::regclass);



ALTER TABLE ONLY public.poll_votes ALTER COLUMN id SET DEFAULT nextval('public.poll_votes_id_seq'::regclass);



ALTER TABLE ONLY public.polls ALTER COLUMN id SET DEFAULT nextval('public.polls_id_seq'::regclass);



ALTER TABLE ONLY public.profile_links ALTER COLUMN id SET DEFAULT nextval('public.profile_links_id_seq'::regclass);



ALTER TABLE ONLY public.prohibited_media ALTER COLUMN id SET DEFAULT nextval('public.prohibited_media_id_seq'::regclass);



ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);



ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);



ALTER TABLE ONLY public.videolibs ALTER COLUMN id SET DEFAULT nextval('public.videolibs_id_seq'::regclass);



ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.artifacts_in_content
    ADD CONSTRAINT artifacts_in_content_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.artifacts
    ADD CONSTRAINT artifacts_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.bans
    ADD CONSTRAINT bans_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.blacklist
    ADD CONSTRAINT blacklist_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.emoji
    ADD CONSTRAINT emoji_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_in_albums_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.langs
    ADD CONSTRAINT langs_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.music
    ADD CONSTRAINT music_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.music_tags
    ADD CONSTRAINT music_tags_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT poll_answers_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT poll_votes_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.profile_links
    ADD CONSTRAINT profile_links_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.prohibited_media
    ADD CONSTRAINT prohibited_content_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pk PRIMARY KEY (user_id);



ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.videolibs
    ADD CONSTRAINT videolibs_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pk PRIMARY KEY (id);



CREATE INDEX albums_anon_comments_only_index ON public.albums USING btree (anon_comments_only);



CREATE INDEX albums_commentable_index ON public.albums USING btree (commentable);



CREATE INDEX albums_visibility_index ON public.albums USING btree (visibility);



CREATE INDEX artifacts_in_content_length_index ON public.artifacts_in_content USING btree (length);



CREATE INDEX artifacts_in_content_position_index ON public.artifacts_in_content USING btree ("position");



CREATE INDEX artifacts_string_index ON public.artifacts USING btree (string);



CREATE INDEX artifacts_type_index ON public.artifacts USING btree (type);



CREATE INDEX bans_banned_dt_index ON public.bans USING btree (banned_dt);



CREATE INDEX bans_until_dt_index ON public.bans USING btree (until_dt);



CREATE INDEX blacklist_issued_dt_index ON public.blacklist USING btree (issued_dt);



CREATE UNIQUE INDEX content_hash_uindex ON public.content USING btree (hash);



CREATE UNIQUE INDEX emoji_string_uindex ON public.emoji USING btree (string);



CREATE INDEX friends_since_dt_index ON public.friends USING btree (since_dt);



CREATE INDEX images_in_albums_last_comment_index_index ON public.images USING btree (last_comment_index);



CREATE INDEX images_in_albums_saved_dt_index ON public.images USING btree (saved_dt);



CREATE UNIQUE INDEX langs_code_uindex ON public.langs USING btree (code);



CREATE UNIQUE INDEX langs_name_uindex ON public.langs USING btree (name);



CREATE INDEX media_format_index ON public.media USING btree (format);



CREATE UNIQUE INDEX media_hash_uindex ON public.media USING btree (hash);



CREATE INDEX music_artist_index ON public.music USING btree (artist);



CREATE INDEX music_id_saved_dt_index ON public.music USING btree (id, saved_dt);



CREATE INDEX music_title_index ON public.music USING btree (title);



CREATE INDEX playlists_anon_comments_only_index ON public.playlists USING btree (anon_comments_only);



CREATE INDEX playlists_commentable_index ON public.playlists USING btree (commentable);



CREATE INDEX playlists_name_index ON public.playlists USING btree (name);



CREATE INDEX playlists_visibility_index ON public.playlists USING btree (visibility);



CREATE INDEX poll_answers_index_index ON public.poll_answers USING btree (index);



CREATE INDEX polls_closing_dt_index ON public.polls USING btree (closing_dt);



CREATE INDEX polls_multiple_answers_index ON public.polls USING btree (multiple_answers);



CREATE INDEX polls_quiz_index ON public.polls USING btree (quiz);



CREATE INDEX polls_voting_visibility_index ON public.polls USING btree (voting_visibility);



CREATE INDEX profile_links_label_index ON public.profile_links USING btree (label);



CREATE UNIQUE INDEX prohibited_content_hash_uindex ON public.prohibited_media USING btree (hash);



CREATE UNIQUE INDEX prohibited_content_id_uindex ON public.prohibited_media USING btree (id);



CREATE INDEX prohibited_content_type_index ON public.prohibited_media USING btree (type);



CREATE INDEX sessions_auth_dt_index ON public.sessions USING btree (auth_dt);



CREATE INDEX sessions_ip_index ON public.sessions USING btree (ip);



CREATE INDEX sessions_key_index ON public.sessions USING btree (key);



CREATE INDEX sessions_useragent_index ON public.sessions USING btree (useragent);



CREATE INDEX user_profiles_anon_comments_only_index ON public.user_profiles USING btree (anon_comments_only);



CREATE INDEX user_profiles_commentable_index ON public.user_profiles USING btree (commentable);



CREATE INDEX user_profiles_friendable_index ON public.user_profiles USING btree (friendable);



CREATE INDEX user_profiles_invitable_index ON public.user_profiles USING btree (invitable);



CREATE INDEX user_profiles_last_post_index_index ON public.user_profiles USING btree (last_post_index);



CREATE INDEX user_profiles_name_index ON public.user_profiles USING btree (name);



CREATE INDEX user_profiles_pinned_post_index_index ON public.user_profiles USING btree (pinned_post_index);



CREATE INDEX user_profiles_searchable_user_id_index ON public.user_profiles USING btree (searchable, user_id);



CREATE UNIQUE INDEX user_profiles_username_uindex ON public.user_profiles USING btree (username);



CREATE INDEX users_auth_dt_index ON public.users USING btree (auth_dt);



CREATE UNIQUE INDEX users_entity_id_uindex ON public.users USING btree (entity_id);



CREATE INDEX users_registered_dt_index ON public.users USING btree (registered_dt);



CREATE INDEX users_role_index ON public.users USING btree (role);



CREATE UNIQUE INDEX users_tg_id_uindex ON public.users USING btree (tg_id);



CREATE UNIQUE INDEX users_tg_username_uindex ON public.users USING btree (tg_username);



CREATE INDEX videolibs_anon_comments_only_index ON public.videolibs USING btree (anon_comments_only);



CREATE INDEX videolibs_commentable_index ON public.videolibs USING btree (commentable);



CREATE INDEX videolibs_name_index ON public.videolibs USING btree (name);



CREATE INDEX videolibs_visibility_index ON public.videolibs USING btree (visibility);



CREATE INDEX videos_360_index ON public.videos USING btree ("360");



CREATE INDEX videos_content_rating_index ON public.videos USING btree (content_rating);



CREATE INDEX videos_last_comment_index_index ON public.videos USING btree (last_comment_index);



CREATE INDEX videos_saved_dt_index ON public.videos USING btree (saved_dt);



CREATE INDEX videos_title_index ON public.videos USING btree (title);



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_content_id_fk FOREIGN KEY (descr_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_entities_id_fk FOREIGN KEY (owner_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_images_in_albums_id_fk FOREIGN KEY (poster_image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.artifacts_in_content
    ADD CONSTRAINT artifacts_in_content_artifacts_id_fk FOREIGN KEY (artifact_id) REFERENCES public.artifacts(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.artifacts_in_content
    ADD CONSTRAINT artifacts_in_content_content_id_fk FOREIGN KEY (content_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.bans
    ADD CONSTRAINT bans_content_id_fk FOREIGN KEY (reason_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.bans
    ADD CONSTRAINT bans_entities_id_fk FOREIGN KEY (entity_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.blacklist
    ADD CONSTRAINT blacklist_entities_id_fk FOREIGN KEY (issuer_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.blacklist
    ADD CONSTRAINT blacklist_entities_id_fk_2 FOREIGN KEY (issuer_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_users_id_fk FOREIGN KEY (offerer_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_users_id_fk_2 FOREIGN KEY (acceptor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_in_albums_albums_id_fk FOREIGN KEY (album_id) REFERENCES public.albums(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_in_albums_content_id_fk FOREIGN KEY (descr_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_in_albums_entities_id_fk FOREIGN KEY (owner_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_users_id_fk FOREIGN KEY (uploader_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.music
    ADD CONSTRAINT music_content_id_fk FOREIGN KEY (lyrics_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.music
    ADD CONSTRAINT music_images_id_fk FOREIGN KEY (poster_image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.music
    ADD CONSTRAINT music_media_id_fk FOREIGN KEY (media_id) REFERENCES public.media(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.music
    ADD CONSTRAINT music_playlists_id_fk FOREIGN KEY (playlist_id) REFERENCES public.playlists(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.music_tags
    ADD CONSTRAINT music_tags_artifacts_id_fk FOREIGN KEY (tag_id) REFERENCES public.artifacts(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.music_tags
    ADD CONSTRAINT music_tags_music_id_fk FOREIGN KEY (music_id) REFERENCES public.music(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_content_id_fk FOREIGN KEY (descr_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_entities_id_fk FOREIGN KEY (owner_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_images_id_fk FOREIGN KEY (poster_image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT poll_answers_content_id_fk FOREIGN KEY (text_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.poll_answers
    ADD CONSTRAINT poll_answers_polls_id_fk FOREIGN KEY (poll_id) REFERENCES public.polls(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT poll_votes_poll_answers_id_fk FOREIGN KEY (answer_id) REFERENCES public.poll_answers(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT poll_votes_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_content_id_fk FOREIGN KEY (hint_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_poll_answers_id_fk FOREIGN KEY (corrent_answer_id) REFERENCES public.poll_answers(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.profile_links
    ADD CONSTRAINT profile_links_artifacts_id_fk FOREIGN KEY (artifact_id) REFERENCES public.artifacts(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.profile_links
    ADD CONSTRAINT profile_links_entities_id_fk FOREIGN KEY (entity_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_content_id_fk FOREIGN KEY (bio_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_images_in_albums_id_fk FOREIGN KEY (cover_image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_images_in_albums_id_fk_2 FOREIGN KEY (avatar_image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_entities_id_fk FOREIGN KEY (entity_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videolibs
    ADD CONSTRAINT videolibs_content_id_fk FOREIGN KEY (descr_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videolibs
    ADD CONSTRAINT videolibs_entities_id_fk FOREIGN KEY (owner_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videolibs
    ADD CONSTRAINT videolibs_images_id_fk FOREIGN KEY (poster_image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_content_id_fk FOREIGN KEY (descr_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_entities_id_fk FOREIGN KEY (owner_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_images_id_fk FOREIGN KEY (poster_image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_media_id_fk FOREIGN KEY (media_id) REFERENCES public.media(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_videolibs_id_fk FOREIGN KEY (videolib_id) REFERENCES public.videolibs(id) ON UPDATE CASCADE ON DELETE CASCADE;



