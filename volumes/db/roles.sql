-- Supabase required roles

-- Authenticator role (used by PostgREST)
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'authenticator') THEN
    CREATE ROLE authenticator NOINHERIT LOGIN PASSWORD current_setting('app.settings.jwt_secret', true);
  END IF;
END
$$;

-- Anonymous role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'anon') THEN
    CREATE ROLE anon NOLOGIN NOINHERIT;
  END IF;
END
$$;

-- Authenticated role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'authenticated') THEN
    CREATE ROLE authenticated NOLOGIN NOINHERIT;
  END IF;
END
$$;

-- Service role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'service_role') THEN
    CREATE ROLE service_role NOLOGIN NOINHERIT BYPASSRLS;
  END IF;
END
$$;

-- Dashboard user
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'supabase_admin') THEN
    CREATE ROLE supabase_admin LOGIN CREATEROLE CREATEDB REPLICATION BYPASSRLS;
  END IF;
END
$$;

-- Auth admin
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'supabase_auth_admin') THEN
    CREATE ROLE supabase_auth_admin NOINHERIT CREATEROLE LOGIN;
  END IF;
END
$$;

-- Storage admin
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'supabase_storage_admin') THEN
    CREATE ROLE supabase_storage_admin NOINHERIT CREATEROLE LOGIN;
  END IF;
END
$$;

-- Replication admin (for realtime)
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'supabase_replication_admin') THEN
    CREATE ROLE supabase_replication_admin LOGIN REPLICATION;
  END IF;
END
$$;

-- Read-only role
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'supabase_read_only_user') THEN
    CREATE ROLE supabase_read_only_user NOINHERIT LOGIN;
  END IF;
END
$$;

-- Grant role memberships
GRANT anon TO authenticator;
GRANT authenticated TO authenticator;
GRANT service_role TO authenticator;
GRANT supabase_admin TO authenticator;

-- Set passwords from env
ALTER ROLE authenticator WITH PASSWORD :'POSTGRES_PASSWORD';
ALTER ROLE supabase_admin WITH PASSWORD :'POSTGRES_PASSWORD';
ALTER ROLE supabase_auth_admin WITH PASSWORD :'POSTGRES_PASSWORD';
ALTER ROLE supabase_storage_admin WITH PASSWORD :'POSTGRES_PASSWORD';
ALTER ROLE supabase_replication_admin WITH PASSWORD :'POSTGRES_PASSWORD';
ALTER ROLE supabase_read_only_user WITH PASSWORD :'POSTGRES_PASSWORD';

-- Grant schema permissions
GRANT ALL PRIVILEGES ON SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON SCHEMA public TO anon;
GRANT ALL PRIVILEGES ON SCHEMA public TO authenticated;
GRANT ALL PRIVILEGES ON SCHEMA public TO service_role;
