CREATE TABLE public.hobby
(
    id integer NOT NULL DEFAULT nextval('hobby_id_seq'::regclass),
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    risk numeric(5,2) NOT NULL,
    CONSTRAINT hobbys_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE public.hobby
    OWNER to tomilov;