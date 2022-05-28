CREATE TABLE public.students
(
    n_z integer NOT NULL DEFAULT nextval('students_id_seq'::regclass),
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    surname character(255) COLLATE pg_catalog."default" NOT NULL,
    "group" integer NOT NULL,
    score numeric(2,0) NOT NULL,
    address character(255) COLLATE pg_catalog."default",
    date_birth date,
    CONSTRAINT students_pkey PRIMARY KEY (n_z)
)

TABLESPACE pg_default;

ALTER TABLE public.students
    OWNER to tomilov;