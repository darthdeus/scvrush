--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: achievements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE achievements (
    id integer NOT NULL,
    name character varying(255),
    slug character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE achievements_id_seq OWNED BY achievements.id;


--
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE blog_posts (
    id integer NOT NULL,
    title character varying(255),
    url character varying(255),
    "order" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: blog_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blog_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blog_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blog_posts_id_seq OWNED BY blog_posts.id;


--
-- Name: coaches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE coaches (
    id integer NOT NULL,
    "order" integer,
    title character varying(255),
    post_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: coaches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE coaches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coaches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE coaches_id_seq OWNED BY coaches.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    content text,
    post_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    parent_id integer
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE games (
    id integer NOT NULL,
    winner integer NOT NULL,
    match_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE images (
    id integer NOT NULL,
    image character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE matches (
    id integer NOT NULL,
    player1_id integer,
    player2_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    round_id integer NOT NULL,
    completed boolean DEFAULT false,
    seed integer NOT NULL,
    score character varying(255)
);


--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE matches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE matches_id_seq OWNED BY matches.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    unread boolean DEFAULT true,
    text text NOT NULL,
    notifiable_id integer NOT NULL,
    notifiable_type character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content text
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE posts (
    id integer NOT NULL,
    title character varying(255),
    content text,
    featured_image character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 0,
    user_id integer,
    published_at timestamp without time zone,
    comments_enabled boolean DEFAULT true
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE relationships (
    id integer NOT NULL,
    requestor_id integer NOT NULL,
    requestor_type character varying(255) NOT NULL,
    requestee_id integer NOT NULL,
    requestee_type character varying(255) NOT NULL,
    restricted boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE relationships_id_seq OWNED BY relationships.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    resource_id integer,
    resource_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: rounds; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rounds (
    id integer NOT NULL,
    number integer NOT NULL,
    tournament_id integer NOT NULL,
    parent_id integer,
    text text,
    bo integer
);


--
-- Name: rounds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rounds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rounds_id_seq OWNED BY rounds.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: signups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE signups (
    id integer NOT NULL,
    tournament_id integer,
    user_id integer,
    placement integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status integer DEFAULT 0
);


--
-- Name: signups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE signups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: signups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE signups_id_seq OWNED BY signups.id;


--
-- Name: statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE statuses (
    id integer NOT NULL,
    text text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE statuses_id_seq OWNED BY statuses.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_id integer,
    taggable_type character varying(255),
    tagger_id integer,
    tagger_type character varying(255),
    context character varying(255),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: tournaments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tournaments (
    id integer NOT NULL,
    name character varying(255),
    starts_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    post_id integer,
    winner_id integer,
    seeded boolean DEFAULT false,
    tournament_type character varying(255),
    description text,
    rules text,
    map_info text,
    bo_preset character varying(255),
    map_preset text,
    user_id integer,
    visible boolean,
    channel character varying(255),
    logo character varying(255),
    max_players integer
);


--
-- Name: tournaments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tournaments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tournaments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tournaments_id_seq OWNED BY tournaments.id;


--
-- Name: user_achievements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_achievements (
    id integer NOT NULL,
    user_id integer,
    achievement_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_achievements_id_seq OWNED BY user_achievements.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    password_hash character varying(255),
    password_salt character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    auth_token character varying(255),
    password_reset_token character varying(255),
    password_reset_sent_at timestamp without time zone,
    bnet_username character varying(255),
    bnet_code character varying(255),
    avatar character varying(255),
    race character varying(255),
    league character varying(255),
    server character varying(255),
    favorite_player character varying(255),
    skype character varying(255),
    msn character varying(255),
    display_email boolean DEFAULT false,
    display_skype boolean DEFAULT false,
    display_msn boolean DEFAULT false,
    about text,
    practice boolean,
    twitter character varying(255),
    time_zone character varying(255),
    api_key character varying(255),
    expires_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users_roles (
    user_id integer,
    role_id integer
);


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE votes (
    id integer NOT NULL,
    voteable_id integer NOT NULL,
    voteable_type character varying(255) NOT NULL,
    user_id integer NOT NULL,
    value integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE votes_id_seq OWNED BY votes.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY achievements ALTER COLUMN id SET DEFAULT nextval('achievements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blog_posts ALTER COLUMN id SET DEFAULT nextval('blog_posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY coaches ALTER COLUMN id SET DEFAULT nextval('coaches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY matches ALTER COLUMN id SET DEFAULT nextval('matches_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships ALTER COLUMN id SET DEFAULT nextval('relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rounds ALTER COLUMN id SET DEFAULT nextval('rounds_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY signups ALTER COLUMN id SET DEFAULT nextval('signups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY statuses ALTER COLUMN id SET DEFAULT nextval('statuses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tournaments ALTER COLUMN id SET DEFAULT nextval('tournaments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_achievements ALTER COLUMN id SET DEFAULT nextval('user_achievements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes ALTER COLUMN id SET DEFAULT nextval('votes_id_seq'::regclass);


--
-- Name: achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- Name: coaches_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY coaches
    ADD CONSTRAINT coaches_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: rounds_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rounds
    ADD CONSTRAINT rounds_pkey PRIMARY KEY (id);


--
-- Name: signups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY signups
    ADD CONSTRAINT signups_pkey PRIMARY KEY (id);


--
-- Name: statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY statuses
    ADD CONSTRAINT statuses_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tournaments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tournaments
    ADD CONSTRAINT tournaments_pkey PRIMARY KEY (id);


--
-- Name: user_achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_achievements
    ADD CONSTRAINT user_achievements_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: index_coaches_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_coaches_on_post_id ON coaches USING btree (post_id);


--
-- Name: index_comments_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_post_id ON comments USING btree (post_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_games_on_match_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_games_on_match_id ON games USING btree (match_id);


--
-- Name: index_notifications_on_notifiable_id_and_notifiable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notifications_on_notifiable_id_and_notifiable_type ON notifications USING btree (notifiable_id, notifiable_type);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_notifications_on_user_id ON notifications USING btree (user_id);


--
-- Name: index_posts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_posts_on_user_id ON posts USING btree (user_id);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name ON roles USING btree (name);


--
-- Name: index_roles_on_name_and_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_roles_on_name_and_resource_type_and_resource_id ON roles USING btree (name, resource_type, resource_id);


--
-- Name: index_rounds_on_tournament_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rounds_on_tournament_id ON rounds USING btree (tournament_id);


--
-- Name: index_signups_on_tournament_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_signups_on_tournament_id ON signups USING btree (tournament_id);


--
-- Name: index_signups_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_signups_on_user_id ON signups USING btree (user_id);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_taggings_on_tagger_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_taggings_on_tagger_id ON taggings USING btree (tagger_id);


--
-- Name: index_tournaments_on_post_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tournaments_on_post_id ON tournaments USING btree (post_id);


--
-- Name: index_tournaments_on_winner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tournaments_on_winner_id ON tournaments USING btree (winner_id);


--
-- Name: index_user_achievements_on_achievement_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_achievements_on_achievement_id ON user_achievements USING btree (achievement_id);


--
-- Name: index_user_achievements_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_achievements_on_user_id ON user_achievements USING btree (user_id);


--
-- Name: index_user_achievements_on_user_id_and_achievement_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_achievements_on_user_id_and_achievement_id ON user_achievements USING btree (user_id, achievement_id);


--
-- Name: index_users_on_expires_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_expires_at ON users USING btree (expires_at);


--
-- Name: index_users_roles_on_user_id_and_role_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_roles_on_user_id_and_role_id ON users_roles USING btree (user_id, role_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20111028235258');

INSERT INTO schema_migrations (version) VALUES ('20111116164602');

INSERT INTO schema_migrations (version) VALUES ('20111117233745');

INSERT INTO schema_migrations (version) VALUES ('20111118020239');

INSERT INTO schema_migrations (version) VALUES ('20111118030113');

INSERT INTO schema_migrations (version) VALUES ('20111118152842');

INSERT INTO schema_migrations (version) VALUES ('20111118155016');

INSERT INTO schema_migrations (version) VALUES ('20111118155017');

INSERT INTO schema_migrations (version) VALUES ('20111118203638');

INSERT INTO schema_migrations (version) VALUES ('20111118203734');

INSERT INTO schema_migrations (version) VALUES ('20111118203823');

INSERT INTO schema_migrations (version) VALUES ('20111118210351');

INSERT INTO schema_migrations (version) VALUES ('20111119145216');

INSERT INTO schema_migrations (version) VALUES ('20111120155831');

INSERT INTO schema_migrations (version) VALUES ('20111121002741');

INSERT INTO schema_migrations (version) VALUES ('20111121003016');

INSERT INTO schema_migrations (version) VALUES ('20111123081404');

INSERT INTO schema_migrations (version) VALUES ('20111123124015');

INSERT INTO schema_migrations (version) VALUES ('20111123154640');

INSERT INTO schema_migrations (version) VALUES ('20111126225543');

INSERT INTO schema_migrations (version) VALUES ('20111127111921');

INSERT INTO schema_migrations (version) VALUES ('20111204130435');

INSERT INTO schema_migrations (version) VALUES ('20111204150943');

INSERT INTO schema_migrations (version) VALUES ('20111204170358');

INSERT INTO schema_migrations (version) VALUES ('20111208014429');

INSERT INTO schema_migrations (version) VALUES ('20111208020758');

INSERT INTO schema_migrations (version) VALUES ('20111220095842');

INSERT INTO schema_migrations (version) VALUES ('20111225202106');

INSERT INTO schema_migrations (version) VALUES ('20111230121530');

INSERT INTO schema_migrations (version) VALUES ('20111231150547');

INSERT INTO schema_migrations (version) VALUES ('20111231161817');

INSERT INTO schema_migrations (version) VALUES ('20111231201842');

INSERT INTO schema_migrations (version) VALUES ('20120122125117');

INSERT INTO schema_migrations (version) VALUES ('20120122211221');

INSERT INTO schema_migrations (version) VALUES ('20120122212248');

INSERT INTO schema_migrations (version) VALUES ('20120220130605');

INSERT INTO schema_migrations (version) VALUES ('20120220152535');

INSERT INTO schema_migrations (version) VALUES ('20120221155633');

INSERT INTO schema_migrations (version) VALUES ('20120222090010');

INSERT INTO schema_migrations (version) VALUES ('20120222155952');

INSERT INTO schema_migrations (version) VALUES ('20120222190650');

INSERT INTO schema_migrations (version) VALUES ('20120331115604');

INSERT INTO schema_migrations (version) VALUES ('20120418084710');

INSERT INTO schema_migrations (version) VALUES ('20120622085136');

INSERT INTO schema_migrations (version) VALUES ('20120627142949');

INSERT INTO schema_migrations (version) VALUES ('20120627143213');

INSERT INTO schema_migrations (version) VALUES ('20120629202920');

INSERT INTO schema_migrations (version) VALUES ('20120706095538');

INSERT INTO schema_migrations (version) VALUES ('20120706123520');

INSERT INTO schema_migrations (version) VALUES ('20120706210154');

INSERT INTO schema_migrations (version) VALUES ('20120706215846');

INSERT INTO schema_migrations (version) VALUES ('20120706221450');

INSERT INTO schema_migrations (version) VALUES ('20120707080003');

INSERT INTO schema_migrations (version) VALUES ('20120707151346');

INSERT INTO schema_migrations (version) VALUES ('20120716095012');

INSERT INTO schema_migrations (version) VALUES ('20120719095307');

INSERT INTO schema_migrations (version) VALUES ('20120722200314');

INSERT INTO schema_migrations (version) VALUES ('20120723144729');

INSERT INTO schema_migrations (version) VALUES ('20120723162340');

INSERT INTO schema_migrations (version) VALUES ('20120724161218');

INSERT INTO schema_migrations (version) VALUES ('20120726215227');

INSERT INTO schema_migrations (version) VALUES ('20120727202059');

INSERT INTO schema_migrations (version) VALUES ('20120728095307');

INSERT INTO schema_migrations (version) VALUES ('20120728095308');

INSERT INTO schema_migrations (version) VALUES ('20120728095309');

INSERT INTO schema_migrations (version) VALUES ('20120728095310');

INSERT INTO schema_migrations (version) VALUES ('20120730175954');

INSERT INTO schema_migrations (version) VALUES ('20120730180817');

INSERT INTO schema_migrations (version) VALUES ('20120730185238');

INSERT INTO schema_migrations (version) VALUES ('20120808110725');

INSERT INTO schema_migrations (version) VALUES ('20120813091050');

INSERT INTO schema_migrations (version) VALUES ('20120813171103');

INSERT INTO schema_migrations (version) VALUES ('20120926220208');

INSERT INTO schema_migrations (version) VALUES ('20121019093659');

INSERT INTO schema_migrations (version) VALUES ('20121221040640');

INSERT INTO schema_migrations (version) VALUES ('20121221040650');

INSERT INTO schema_migrations (version) VALUES ('20121222231918');

INSERT INTO schema_migrations (version) VALUES ('20121225145106');

INSERT INTO schema_migrations (version) VALUES ('20130105141444');

INSERT INTO schema_migrations (version) VALUES ('20130129101117');

INSERT INTO schema_migrations (version) VALUES ('20130214143256');

INSERT INTO schema_migrations (version) VALUES ('20130214155519');

INSERT INTO schema_migrations (version) VALUES ('20130214155826');