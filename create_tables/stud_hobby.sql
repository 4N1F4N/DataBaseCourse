CREATE TABLE public.stud_hobby
(
    id integer NOT NULL DEFAULT nextval('stud_hobby_id_seq'::regclass),
    id_stud integer NOT NULL,
    id_hobby integer NOT NULL,
    date_start date,
    date_finish date,
    CONSTRAINT stud_hobbys_pkey PRIMARY KEY (id),
    CONSTRAINT stud_hobby_id_hobby_fkey FOREIGN KEY (id_hobby)
        REFERENCES public.hobby (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT stud_hobby_id_stud_fkey FOREIGN KEY (id_stud)
        REFERENCES public.students (n_z) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.stud_hobby
    OWNER to tomilov;