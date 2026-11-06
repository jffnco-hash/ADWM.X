PRAGMA foreign_keys = ON;
CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,phone TEXT NOT NULL UNIQUE,name TEXT NOT NULL,pass_hash TEXT NOT NULL,pass_salt TEXT NOT NULL,token TEXT UNIQUE,role TEXT NOT NULL DEFAULT 'user' CHECK(role IN ('user','admin','developer')),points INTEGER NOT NULL DEFAULT 0,vip INTEGER NOT NULL DEFAULT 0,vip_plan TEXT NOT NULL DEFAULT '',banned INTEGER NOT NULL DEFAULT 0,created_at INTEGER NOT NULL,last_seen INTEGER);
CREATE TABLE messages(id INTEGER PRIMARY KEY AUTOINCREMENT,message_id TEXT NOT NULL UNIQUE,sender_id INTEGER NOT NULL REFERENCES users(id),recipient_id INTEGER NOT NULL REFERENCES users(id),body TEXT NOT NULL,kind TEXT NOT NULL DEFAULT 'text',delivered INTEGER NOT NULL DEFAULT 0,created_at INTEGER NOT NULL);
CREATE INDEX idx_messages_inbox ON messages(recipient_id,delivered,id);
CREATE TABLE groups_chat(group_id TEXT PRIMARY KEY,name TEXT NOT NULL,owner_id INTEGER NOT NULL REFERENCES users(id),created_at INTEGER NOT NULL);
CREATE TABLE group_members(group_id TEXT NOT NULL REFERENCES groups_chat(group_id) ON DELETE CASCADE,user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,joined_at INTEGER NOT NULL,PRIMARY KEY(group_id,user_id));
CREATE TABLE group_messages(id INTEGER PRIMARY KEY AUTOINCREMENT,message_id TEXT NOT NULL UNIQUE,group_id TEXT NOT NULL REFERENCES groups_chat(group_id) ON DELETE CASCADE,sender_id INTEGER NOT NULL REFERENCES users(id),body TEXT NOT NULL,created_at INTEGER NOT NULL);
CREATE INDEX idx_group_messages ON group_messages(group_id,id);
