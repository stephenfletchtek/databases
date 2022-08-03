TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;
INSERT INTO user_accounts (email_address, username) VALUES ('homer@simpsons.com', 'Homer Simpson');
INSERT INTO user_accounts (email_address, username) VALUES ('bart@simpsons.com', 'Bart Simpson');