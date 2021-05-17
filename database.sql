

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


ALTER TYPE public.access OWNER TO arelive;


CREATE TYPE public.audio_format AS ENUM (
    'mp3',
    'ogg',
    'wav'
);


ALTER TYPE public.audio_format OWNER TO arelive;


CREATE TYPE public.image_format AS ENUM (
    'jpeg',
    'png',
    'gif',
    'svg',
    'webp',
    'bmp'
);


ALTER TYPE public.image_format OWNER TO arelive;


CREATE TYPE public.user_role AS ENUM (
    'user',
    'moder',
    'admin'
);


ALTER TYPE public.user_role OWNER TO arelive;


CREATE TYPE public.video_format AS ENUM (
    'mp4',
    'webm',
    'avi',
    'mov',
    'mpeg'
);


ALTER TYPE public.video_format OWNER TO arelive;

SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE public.albums (
    id bigint NOT NULL,
    visibility public.access DEFAULT 'private'::public.access NOT NULL,
    name character varying(255) NOT NULL,
    descr_id bigint NOT NULL,
    owner_id bigint NOT NULL,
    poster_image_id bigint,
    commentable public.access DEFAULT 'public'::public.access NOT NULL,
    anon_comments_only boolean DEFAULT false
);


ALTER TABLE public.albums OWNER TO arelive;


CREATE SEQUENCE public.albums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO arelive;


ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;



CREATE TABLE public.content (
    id bigint NOT NULL,
    hash bigint NOT NULL,
    text text NOT NULL
);


ALTER TABLE public.content OWNER TO arelive;


CREATE SEQUENCE public.content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_id_seq OWNER TO arelive;


ALTER SEQUENCE public.content_id_seq OWNED BY public.content.id;



CREATE TABLE public.entities (
    id bigint NOT NULL
);


ALTER TABLE public.entities OWNER TO arelive;


CREATE SEQUENCE public.entities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entities_id_seq OWNER TO arelive;


ALTER SEQUENCE public.entities_id_seq OWNED BY public.entities.id;



CREATE TABLE public.images (
    id bigint NOT NULL,
    hash bigint NOT NULL,
    format public.image_format NOT NULL,
    uploader_id bigint NOT NULL,
    uploader_ip inet NOT NULL
);


ALTER TABLE public.images OWNER TO arelive;


CREATE SEQUENCE public.images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_id_seq OWNER TO arelive;


ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;



CREATE TABLE public.images_in_albums (
    id bigint NOT NULL,
    album_id bigint NOT NULL,
    image_id bigint NOT NULL,
    owner_id bigint NOT NULL,
    descr_id bigint NOT NULL,
    last_comment_index bigint DEFAULT 0 NOT NULL,
    saved_dt timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.images_in_albums OWNER TO arelive;


CREATE SEQUENCE public.images_in_albums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images_in_albums_id_seq OWNER TO arelive;


ALTER SEQUENCE public.images_in_albums_id_seq OWNED BY public.images_in_albums.id;



CREATE TABLE public.user_profiles (
    user_id bigint NOT NULL,
    username character varying(32) DEFAULT NULL::character varying,
    searchable boolean DEFAULT true NOT NULL,
    cover_image_id bigint,
    avatar_image_id bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    bio_id bigint NOT NULL,
    friendable public.access DEFAULT 'public'::public.access NOT NULL,
    invitable public.access DEFAULT 'protected'::public.access NOT NULL,
    commentable public.access DEFAULT 'public'::public.access NOT NULL,
    anon_comments_only boolean DEFAULT false NOT NULL,
    last_post_index bigint DEFAULT 0 NOT NULL,
    pinned_post_index bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_profiles OWNER TO arelive;


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


ALTER TABLE public.users OWNER TO arelive;


CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO arelive;


ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;



ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);



ALTER TABLE ONLY public.content ALTER COLUMN id SET DEFAULT nextval('public.content_id_seq'::regclass);



ALTER TABLE ONLY public.entities ALTER COLUMN id SET DEFAULT nextval('public.entities_id_seq'::regclass);



ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);



ALTER TABLE ONLY public.images_in_albums ALTER COLUMN id SET DEFAULT nextval('public.images_in_albums_id_seq'::regclass);



ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.images_in_albums
    ADD CONSTRAINT images_in_albums_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pk PRIMARY KEY (id);



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pk PRIMARY KEY (user_id);



ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);



CREATE INDEX albums_anon_comments_only_index ON public.albums USING btree (anon_comments_only);



CREATE INDEX albums_commentable_index ON public.albums USING btree (commentable);



CREATE INDEX albums_visibility_index ON public.albums USING btree (visibility);



CREATE UNIQUE INDEX content_hash_uindex ON public.content USING btree (hash);



CREATE INDEX images_format_index ON public.images USING btree (format);



CREATE UNIQUE INDEX images_hash_uindex ON public.images USING btree (hash);



CREATE INDEX images_in_albums_last_comment_index_index ON public.images_in_albums USING btree (last_comment_index);



CREATE INDEX images_in_albums_saved_dt_index ON public.images_in_albums USING btree (saved_dt);



CREATE INDEX images_uploader_ip_index ON public.images USING btree (uploader_ip);



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



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_content_id_fk FOREIGN KEY (descr_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_entities_id_fk FOREIGN KEY (owner_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_images_in_albums_id_fk FOREIGN KEY (poster_image_id) REFERENCES public.images_in_albums(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_entities_id_fk FOREIGN KEY (uploader_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images_in_albums
    ADD CONSTRAINT images_in_albums_albums_id_fk FOREIGN KEY (album_id) REFERENCES public.albums(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images_in_albums
    ADD CONSTRAINT images_in_albums_content_id_fk FOREIGN KEY (descr_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images_in_albums
    ADD CONSTRAINT images_in_albums_entities_id_fk FOREIGN KEY (owner_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.images_in_albums
    ADD CONSTRAINT images_in_albums_images_id_fk FOREIGN KEY (image_id) REFERENCES public.images(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_content_id_fk FOREIGN KEY (bio_id) REFERENCES public.content(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_images_in_albums_id_fk FOREIGN KEY (cover_image_id) REFERENCES public.images_in_albums(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_images_in_albums_id_fk_2 FOREIGN KEY (avatar_image_id) REFERENCES public.images_in_albums(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_entities_id_fk FOREIGN KEY (entity_id) REFERENCES public.entities(id) ON UPDATE CASCADE ON DELETE CASCADE;



