CREATE TABLE users 
    (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255) UNIQUE NOT NULL,
        created_at TIMESTAMP DEFAULT NOW()
    );
    
CREATE TABLE photos 
    (
        id INT AUTO_INCREMENT PRIMARY KEY,
        created_at TIMESTAMP DEFAULT NOW(),
        image_url VARCHAR(255) NOT NULL,
        user_id INT NOT NULL,
        FOREIGN KEY (user_id)
            REFERENCES users(id)
    );
    
CREATE TABLE comments 
    (
        id INT AUTO_INCREMENT PRIMARY KEY, 
        comment_text VARCHAR(255) NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        user_id INT NOT NULL,
            FOREIGN KEY(user_id)
                REFERENCES users(id),
        photo_id INT NOT NULL,
            FOREIGN KEY(photo_id)
                REFERENCES photos(id)
    );

CREATE TABLE likes 
    (
        user_id INT NOT NULL,
            FOREIGN KEY (user_id)
                REFERENCES users(id),
        photo_id INT NOT NULL,
            FOREIGN KEY (photo_id)
                REFERENCES photos(id),
        created_at TIMESTAMP DEFAULT NOW(),
        PRIMARY KEY(user_id, photo_id)
    );

CREATE TABLE followers
    (  
        follower_id INT NOT NULL,
            FOREIGN KEY(follower_id)
                REFERENCES users(id),
        followee_id INT NOT NULL,
            FOREIGN KEY(followee_id)
                REFERENCES users(id),
        created_at TIMESTAMP DEFAULT NOW(),
        PRIMARY KEY(follower_id, followee_id)
    );
    
CREATE TABLE tags 
    (  
        id INT AUTO_INCREMENT PRIMARY KEY,
        tag_name VARCHAR(255) UNIQUE,
        created_at TIMESTAMP DEFAULT NOW()
    );

CREATE TABLE photo_tags 
    (
        photo_id INT NOT NULL,
            FOREIGN KEY(photo_id)
                REFERENCES photos(id),
        tag_id INT NOT NULL,
            FOREIGN KEY(tag_id)
                REFERENCES tags(id),
        PRIMARY KEY(photo_id, tag_id)
    );





INSERT INTO users (username)
    VALUES
    ("BlueTheCat"),
    ("AldoTheApache"),
    ("LinuxTheBeef");
    
INSERT INTO photos (image_url, user_id)
    VALUES 
    ("/KLJSDFLJ", 1),
    ("/837skljfl", 2),
    ("/skjlelkjs", 2);
    
INSERT INTO comments (comment_text, user_id, photo_id)
    VALUES 
        ("This looks amazing!", 1, 2),
        ("This is a fun way to spend the day!", 1, 3),
        ("Hope you packed enough snacks", 1, 1),
        ("Look at you!", 2, 3),
        ("Wow such greatness", 2, 3),
        ("This is a bad comment, negative", 2, 1),
        ("All work and no play makes Jack a dull boy", 3, 1);

INSERT INTO likes (user_id, photo_id)
    VALUES 
        (1,1),
        (2,1),
        (1,2),
        (1,3),
        (3,3);

INSERT INTO followers (follower_id, followee_id)
    VALUES
        (1,2),
        (1,3),
        (2,1),
        (3,2);

    
    
    
    

















/* Simple Join

SELECT users.id, username, image_url, photos.created_at
FROM photos
INNER JOIN users
    ON users.id = photos.user_id;

*/

/* Harder Join - 3 tables 

SELECT username, comment_text, comments.created_at, image_url
FROM photos
JOIN users
    ON users.id = photos.user_id
JOIN comments
    ON users.id = comments.user_id;

*/

/* Harderer Join - 4 tables 

SELECT username, comment_text, comments.created_at, image_url, likes.user_id, likes.photo_id
FROM photos
JOIN users
    ON users.id = photos.user_id
JOIN comments
    ON users.id = comments.user_id
JOIN likes 
    ON users.id = likes.user_id;

*/

/* Hardererer Join - 5 tables 

SELECT username, comment_text, comments.created_at, image_url, likes.user_id, likes.photo_id, follower_id, followee_id
FROM photos
JOIN users
    ON users.id = photos.user_id
JOIN comments
    ON users.id = comments.user_id
JOIN likes 
    ON users.id = likes.user_id;
JOIN followers 
    ON users.id = followers.follower_id;

*/