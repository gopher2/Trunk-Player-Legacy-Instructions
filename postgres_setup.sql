CREATE USER trunk_player_user WITH PASSWORD '__DB_PASS__';
CREATE DATABASE trunk_player OWNER trunk_player_user;
GRANT ALL PRIVILEGES ON DATABASE trunk_player TO trunk_player_user;
ALTER ROLE trunk_player_user SET client_encoding TO 'utf8';
ALTER ROLE trunk_player_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE trunk_player_user SET timezone TO 'UTC';
\c trunk_player
GRANT USAGE ON SCHEMA public TO trunk_player_user;
GRANT CREATE ON SCHEMA public TO trunk_player_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO trunk_player_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO trunk_player_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO trunk_player_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO trunk_player_user;
