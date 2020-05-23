CREATE TABLE profile (
  id INTEGER PRIMARY KEY,
  name TEXT
)

CREATE TABLE messages (
  id INT PRIMARY KEY,
  message TEXT,
  profile_id INTEGER REFERENCES profile(id),
)