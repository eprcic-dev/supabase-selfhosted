-- Realtime schema and publication

CREATE SCHEMA IF NOT EXISTS _realtime;
ALTER SCHEMA _realtime OWNER TO postgres;

CREATE PUBLICATION supabase_realtime;

GRANT USAGE ON SCHEMA _realtime TO postgres;
GRANT ALL ON ALL TABLES IN SCHEMA _realtime TO postgres;
GRANT ALL ON ALL SEQUENCES IN SCHEMA _realtime TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA _realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA _realtime GRANT ALL ON SEQUENCES TO postgres;
