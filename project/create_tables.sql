/*Users*/
CREATE TABLE public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    surname text COLLATE pg_catalog."default" NOT NULL,
    patronymic text COLLATE pg_catalog."default" NOT NULL,
    role text COLLATE pg_catalog."default" NOT NULL,
    level_access integer NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.users
    OWNER to tomilov;
/*Rooms*/
CREATE TABLE public.rooms
(
    id integer NOT NULL DEFAULT nextval('rooms_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    level_access integer NOT NULL,
    CONSTRAINT rooms_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.rooms
    OWNER to tomilov;
/*Access_requests*/
CREATE TABLE public.access_requests
(
    id integer NOT NULL DEFAULT nextval('access_requests_id_seq'::regclass),
    id_user integer NOT NULL,
    id_room integer NOT NULL,
    solved boolean NOT NULL DEFAULT false,
    CONSTRAINT access_requests_pkey PRIMARY KEY (id),
    CONSTRAINT access_requests_id_room_fkey FOREIGN KEY (id_room)
        REFERENCES public.rooms (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT access_requests_id_user_fkey FOREIGN KEY (id_user)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.access_requests
    OWNER to tomilov;
/*Visits*/
CREATE TABLE public.visits
(
    id integer NOT NULL DEFAULT nextval('visits_id_seq'::regclass),
    id_user integer NOT NULL,
    id_room integer NOT NULL,
    date_start date NOT NULL,
    date_finish date,
    CONSTRAINT visits_pkey PRIMARY KEY (id),
    CONSTRAINT visits_id_room_fkey FOREIGN KEY (id_room)
        REFERENCES public.rooms (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT visits_id_user_fkey FOREIGN KEY (id_user)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.visits
    OWNER to tomilov;
/*Incidents*/
CREATE TABLE public.incidents
(
    id integer NOT NULL DEFAULT nextval('incidents_id_seq'::regclass),
    id_visit integer NOT NULL,
    date date NOT NULL,
    solved boolean,
    message text COLLATE pg_catalog."default",
    CONSTRAINT incidents_pkey PRIMARY KEY (id),
    CONSTRAINT incidents_id_visit_fkey FOREIGN KEY (id_visit)
        REFERENCES public.visits (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.incidents
    OWNER to tomilov;