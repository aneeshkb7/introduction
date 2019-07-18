create table pat_docs.s3_patents(id serial primary key,
                        country_code char varying,
                        stripped_patnum char varying,
                        document_type char varying,
                        s3_hash char varying,
                        created_by char varying default current_user,
                        created_at timestamp without time zone default now(),
                        updated_by char varying default current_user,
                        updated_at timestamp without time zone default now()
                        );
                        
alter table pat_docs.s3_patents owner to pat_docs;  


create table pat_docs.patent_documents (id serial primary key, 
                           s3_patent_id int references pat_docs.s3_patents(id),
                           name text,
                           size char varying, 
                           s3_url char varying, 
                           created_by char varying default current_user, 
                           created_at timestamp default now(),
                           updated_by char varying default current_user, 
                           updated_at timestamp default now()
                           );
                           
alter table pat_docs.patent_documents owner to pat_docs; 


create or replace function pat_docs.patent_s3_hash_trig_fn() returns trigger as
$_$

begin

new.s3_hash=encode(concat(new.country_code,new.stripped_patnum)::bytea,'base64');
return new;
end;
$_$
LANGUAGE PLPGSQL;

alter function pat_docs.patent_s3_hash_trig_fn() owner to pat_docs; 

create trigger s3_hash_trigger before insert or update on pat_docs.s3_patents
for each row 
execute procedure pat_docs.patent_s3_hash_trig_fn();       
---------------------------------------------------------------
create schema pat_docs; 
create role pat_docs; 
grant usage on schema pat_docs to pat_docs; 
grant all on schema pat_docs to pat_docs; 

(grant usage on schema pat_docs to postgres;
 grant all on schema pat_docs to postgres; 
 grant pat_docs to postgres;)


