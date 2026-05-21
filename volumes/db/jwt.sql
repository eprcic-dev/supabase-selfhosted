-- JWT configuration for PostgREST / GoTrue

ALTER DATABASE postgres SET "app.settings.jwt_secret" TO :'JWT_SECRET';
ALTER DATABASE postgres SET "app.settings.jwt_exp" TO :'JWT_EXP';

-- pgjwt extension
CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;
