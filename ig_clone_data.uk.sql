# week2_mandatory project for sql

# database:>ig_clone
# it contains total 6 tables 
use ig_clone;

-- 1)Create an ER diagram or draw a schema for the given database.
## i send it as pdf through mail(success@odinschool.com)


-- 2)We want to reward the user who has been around the longest, Find the 5 oldest users.

SELECT * 
FROM users
ORDER BY created_at 
LIMIT 5;       # only five records will be display            

-- 3)To understand when to run the ad campaign, figure out the day of the week most users register on?
 select * from users;
 # select * from users;
SELECT 
     DAYNAME(created_at) AS day,  # dayname will give the day name
     count(*) as total  
FROM users
GROUP BY day              # it will provide the data based on day 
ORDER BY total DESC        # descinding order
LIMIT 2;                    # only two records will be display

-- 4)To target inactive users in an email ad campaign, find the users who have never posted a photo.

SELECT username                     # selecting the user name
FROM users
LEFT JOIN photos                 # all the records from the users table and matching records from photos
	ON users.id=photos.user_id   # here we are combining the table based on the column
WHERE photos.id IS NULL;         # if there is no recods from the cell only that records will be display

-- 5)Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?

-- WHO WON??!!
SELECT 
    username,
	photos.id,
    photos.image_url, 
    count(likes.user_id) AS total
FROM photos
INNER JOIN likes                    # joining photos table and likes table 
    ON likes.photo_id=photos.id
INNER JOIN users                    # joining photos table and users table
    ON photos.user_id = users.id
GROUP BY photos.id                  # based on this photos id column  
ORDER BY total DESC                 # total will be display as big to small
LIMIT 1;                           # this line will display winner


-- 6)The investors want to know how many times does the average user post.
SELECT AVG(post) as times  
FROM ( 
    SELECT username, COUNT(photos.id) as post FROM users
    LEFT JOIN photos ON users.id=photos.user_id   # combining users ,photos tables by using joins 
    GROUP BY users.username 
) as times;    # every divided table must have their own alias name so
  
-- 7)A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags


SELECT tags.tag_name,COUNT(*) AS total FROM photo_tags
inner JOIN tags ON photo_tags.tag_id= tags.id  # combine the data from photo_tags and tags by using inner join
GROUP BY tags.id   #  based on this column data will be grouped
ORDER BY total DESC # total column recors will be displayed in descinding order
LIMIT 5;            # only 5 records will be display


-- 8)To find out if there are bots, find users who have liked every single photo on the site

select users.id,username, COUNT(users.id) As total_likes_by_user FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos); # this will will display whoever liked every single photo

-- 9)To know who the celebrities are, find users who have never commented on a photo.

SELECT username,comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id  # combining users and comments tables
GROUP BY users.id                                  # based on this id data will be grouped
HAVING comment_text IS NULL;  # if there is no data that records will be display


-- 10)Now it's time to find both of them together, 
-- find the users who have never commented on any photo or have commented on every photo
SELECT username,comment_text,count(users.id) as total_likes_by_user
FROM users
LEFT JOIN comments ON users.id = comments.user_id  # combine users and comments tables
GROUP BY users.id                                  # based on this id records will be grouped
HAVING comment_text IS NULL   # never commented
or total_likes_by_user = (SELECT COUNT(*) FROM photos);  # commented on every single photo
  
  select * from users where weekday(created_at)='wednesday';
