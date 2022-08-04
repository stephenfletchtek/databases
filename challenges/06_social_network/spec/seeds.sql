TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;
INSERT INTO user_accounts (email_address, username) VALUES ('homer@simpsons.com', 'Homer Simpson');
INSERT INTO user_accounts (email_address, username) VALUES ('bart@simpsons.com', 'Bart Simpson');
INSERT INTO posts (title, content, num_views, user_account_id)
VALUES ('Plutonium in Springfield', 'Today, I will explain howe to mine plutonium from underneath Springfield lake!', '5', '1');
INSERT INTO posts (title, content, num_views, user_account_id)
VALUES ('Prank my sister', 'I have thought of the best way to prank my baby sister.', '10', '2');
