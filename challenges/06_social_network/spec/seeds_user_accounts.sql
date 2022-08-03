TRUNCATE TABLE user_accounts RESTART IDENTITY; -- replace with your own table name.
INSERT INTO user_accounts (email_address, username) VALUES ('homer@simpsons.com', 'Homer Simpson');
INSERT INTO user_accounts (email_address, username) VALUES ('bart@simpsons.com', 'Bart Simpson');