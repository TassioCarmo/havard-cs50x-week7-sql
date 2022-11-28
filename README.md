# Introduction to SQL/Structured Query Language (sequal)

## What did i learn?

## Data Processing

```
import csv

#Open, the name of the file that I want to open in read mode. Quote, unquote, "r" means to read it,and as file to open this file, and essentially store some kind of reference to it in that variable called file. 

with open("favorites.csv", "r") as file:
# reader, and I can say csv.reader, passing in that file as input. It deals with the process of opening it, reading it, and giving you back something that you can just iterate over, like with a for loop 
    reader = csv.reader(file)
    #ignore the first row
    next(reader)
    for row in reader:
        print(row[1])
```
- We’ll open the file with a reference called file, using the with keyword in Python that will close our file for us.
- The csv library has a reader function that will create a reader variable we can use to read in the file as a CSV.
- We’ll call next to skip the first row, since that’s the header row.
- Then, we’ll use a loop to print the second column in each row, which is the title.

Now, if we run our program, we’ll see a list of show titles: 
-----------------------
## Dict object

what's coming back now is a dict object, that is, a dictionary which has keys and values. The keys of which are the column headings. 
```
import csv

with open("favorites.csv", "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        print(row["title"])
```
 Since the first row in our CSV has the names of the columns, it can be used to label each column in our data as well. Now our program will still work, even if the order of the columns are changed.
 
 dictionary reader is arguably just better design because it's more robust against changes and potential errors
 
 change the current title to all uppercase, and remove whitespace around it, before we add it to our list:
```
import csv

titles = []

with open("favorites.csv", "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        title = row["title"].strip().upper()
        if not title in titles:
            titles.append(title)

for title in titles:
    print(title)
```

To sort the titles, we can just change our loop to for title in sorted(titles), which will sort our set before we iterate over it: 

```
#list
test = []

Dictionary 

text = {}

```
--------------------------------
## Counting

We’ll have to add each title to our dictionary first, and set the initial value to 1:
```
import csv

titles = {}

with open("favorites.csv", "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        title = row["title"].strip().upper()
        if title in titles:
            titles[title] += 1
        else:
            titles[title] = 1

for title in sorted(titles):
    print(title, titles[title])
```
We’ll add the values, or counts, to our loop that prints every show name.

We can also set the initial value to 0, and then increment it by 1 no matter what:
```
import csv

titles = {}

with open("favorites.csv", "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        title = row["title"].strip().upper()
        if not title in titles:
            titles[title] = 0
        titles[title] += 1

for title in sorted(titles):
    print(title, titles[title])

```

We can sort by the values in the dictionary by changing our loop to:
```
...
def get_value(title):
    return titles[title]

for title in sorted(titles, key=get_value, reverse=True):
    print(title, titles[title])
```

 We define a function, f, which just returns the value of a title in the dictionary with titles[title]. The sorted function, in turn, will take in that function as the key to sort the dictionary. And we’ll also pass in reverse=True to sort from largest to smallest, instead of smallest to largest.

you can actually pass whole functions around so that they can be called for you later on by someone else. 

So what this means is that the sorted function written by Python, they didn't know what you're going to want to sort by today. But if you provide them with a function called get value, or anything else, now their sorted function will use that function to determine, OK, if you don't want to sort by the key of the dictionary, what do you want to sort by
```
for title in sorted(titles, key=lambda title: titles[title], reverse=True):
    print(title, titles[title])
```
  We can write and pass in a lambda, or anonymous function, which has no name but takes in some argument or arguments, and returns a value immediately.
  
It throws away the word get value. It throws away the parentheses, and it throws away the return keyword just to tighten things up. And it's well suited for a problem like this where I just want to pass in a tiny little function that does something useful. But it's not something I'm going to reuse. It doesn't need multiple lines to take up space. It's just a nice, elegant one liner. 

## Regular expression

. for any character
.* for 0 or more characters
.+ for 1 or more characters
? for an optional character
^ for start of input
$ for end of input

-------------------------------------------
## Relational databases

 Relational databases are programs that store data, ultimately in files, but with additional data structures and interfaces that allow us to search and store data more efficiently.
When working with data, we generally need four types of basic operations with the acronym CRUD:
- CREATE , inset
- READ
- UPDATE
- DELETE, drop


Syntax in SQL might look like:

CREATE TABLE table (column type, ...);

 With a command in the format SELECT columns FROM table;, we can read data from one or more columns. For example, we can write SELECT title, genre FROM favorites; to select both the title and genre.

SQL supports many functions that we can use to count and summarize data:

    AVG
    COUNT
    DISTINCT
    LOWER
    MAX
    MIN
    UPPER
    


    WHERE, adding a Boolean expression to filter our data
    LIKE, filtering responses more loosely (aproximations
    ORDER BY
    LIMIT
    GROUP BY
    …
    


So when you have a table like genres, which is somehow cross referencing the original shows table, if shows have a primary key called ID, and those same numbers appear in the genres table under the column called show ID, by definition, show ID is a foreign key

```
import our CSV file into a database:

$ sqlite3 favorites.db
SQLite version 3.36.0 2021-06-18 18:36:39
Enter ".help" for usage hints.
sqlite> .mode csv
sqlite> .import favorites.csv favorites
```

open our database file again, and check the schema, or design, of our new table with .schema:
```
$ sqlite3 favorites.db
SQLite version 3.36.0 2021-06-18 18:36:39
Enter ".help" for usage hints.
sqlite> .schema
CREATE TABLE IF NOT EXISTS "favorites"(
  "Timestamp" TEXT,
  "title" TEXT,
  "genres" TEXT
);
```

<code>.import</code> used the <code>CREATE TABLE</code> ... command to create a table called <code>favorites</code>, with column names automatically copied from the CSV’s header row, and types for each of them assumed to be text.

With a command in the format <code>SELECT columns FROM table;</code>, we can read data from one or more columns. For example, we can write SELECT title, genre FROM favorites; to select both the title and genre.

SQL supports many functions that we can use to count and summarize data:

    AVG
    COUNT
    DISTINCT
    LOWER
    MAX
    MIN
    UPPER
    
### clean up our titles as before, converting them to uppercase and printing only the unique values:

<code> sqlite > SELECT DISTINCT(UPPER(title)) FROM shows;</code>

### Get a count of how many responses there are:

<code>sqlite> SELECT COUNT(title) FROM favorites;</code>


### Add more phrases to our command:

    WHERE, adding a Boolean expression to filter our data
    LIKE, filtering responses more loosely
    ORDER BY
    LIMIT
    GROUP BY
    …

### Limit the number of results:

<code>sqlite> SELECT title FROM favorites LIMIT 10;</code>

### Look for titles matching a string:

% character is a placeholder for zero or more other characters

<code>sqlite> SELECT title FROM favorites WHERE title LIKE "%office%";</code>

### select just the count in our command:

<code>sqlite> SELECT COUNT(title) FROM favorites WHERE title LIKE "%office%";</code>

### Delete:

```
sqlite> SELECT COUNT(title) FROM favorites WHERE title LIKE "%friends%";

sqlite> DELETE FROM favorites WHERE title LIKE "%friends%";
sqlite> SELECT COUNT(title) FROM favorites WHERE title LIKE "%friends%";

```

### Update a specific row of data:

```
sqlite> SELECT title FROM favorites WHERE title = "Thevoffice";

sqlite> UPDATE favorites SET title = "The Office" WHERE title = "Thevoffice";
sqlite> SELECT title FROM favorites WHERE title = "Thevoffice"; 
```

### change the values in multiple rows, too:

    sqlite> SELECT genres FROM favorites WHERE title = "Game of Thrones";

    +--------------------------------------------------------------------------------------------------------------+
    sqlite> UPDATE favorites SET genres = "Action, Adventure, Drama, Fantasy, Thriller, War" WHERE title = "Game of Thrones";
    sqlite> SELECT genres FROM favorites WHERE title = "Game of Thrones";

- With DELETE and DROP, we can remove rows and even entire tables as well.
- And notice that in our commands, we’ve written SQL keywords in all caps, so they stand out more.
- There also isn’t a built-in way to undo commands, so if we make a mistake we might have to build our database again!

-------------------------------------

## SQL with Python

 asks the user for a show title and then prints its popularity:
```
import csv

from cs50 import SQL

db = SQL("sqlite:///favorites.db")

title = input("Title: ").strip()

rows = db.execute("SELECT COUNT(*) AS counter FROM favorites WHERE title LIKE ?", title)

row = rows[0]

print(row["counter"])
```


### import our CSV data into two tables:

```  
Imports titles and genres from CSV into a SQLite database

import cs50
import csv
  
# Create database
open("favorites8.db", "w").close()
db = cs50.SQL("sqlite:///favorites8.db")
  
# Create tables
db.execute("CREATE TABLE shows (id INTEGER, title TEXT NOT NULL, PRIMARY KEY(id))")
db.execute("CREATE TABLE genres (show_id INTEGER, genre TEXT NOT NULL, FOREIGN KEY(show_id) REFERENCES shows(id))")
  
# Open CSV file
with open("favorites.csv", "r") as file:
  
    # Create DictReader
    reader = csv.DictReader(file)
  
    # Iterate over CSV file
    for row in reader:
  
        # Canoncalize title
        title = row["title"].strip().upper()
  
        # Insert title
        show_id = db.execute("INSERT INTO shows (title) VALUES(?)", title)
  
        # Insert genres
        for genre in row["genres"].split(", "):

            db.execute("INSERT INTO genres (show_id, genre) VALUES(?, ?)", show_id, genre)



```

--------------------------------------------------------------
## Problems

One problem in SQL is called a SQL injection attack, where an someone can inject, or place, their own commands into inputs that we then run on our database.
```
Do this
rows = db.execute("SELECT * FROM users WHERE username = ? AND password = ?", username, password)

if len(rows) == 1:
    # Log user in
```
By using the ? symbols as placeholders, our SQL library will escape the input, or prevent dangerous characters from being interpreted as part of the command.

In contrast, we might have a SQL query that’s a formatted string, such as:
```
NEVER DO THIS
rows = db.execute(f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'")

if len(rows) == 1:
    # Log user in
```
-------------------------------------------------------------
## other

IN SQL 

- char is not only a single character but a fixed lenght string

- Varchar variable lenght string

### primary key.
- Primary keys enable rows of a table to be uniquely and quickly identified.
- Choosing your primary key appropriately can make subsequent operations on the table much easier.
- It is also possible to establish a joint primary key –a combination of two columns that is always guaranteed to be unique.


### INSERT
- Add information to a table.
```
INSERT INTO
<table>
    (<columns>)
VALUES
    (<values>)SELECT

NSERT INTO
    users
(username, password, fullname)
    VALUES
(‘newman’, ‘USMAIL’, ‘Newman’)  
    
```    
### SELECT
- Extract information from a table.
```
SELECT
    <columns>
FROM
    <table>
WHERE
    <condition>
ORDER BY
    <column>
    
    
SELECT
    password
FROM
    users
WHERE
    idnum< 12 
    
```

### SELECT (JOIN)
•Extract information from multiple tables.
```
SELECT
    <columns>
FROM
    <table1>
JOIN
    <table2>
ON
    <predicate>

SELECT
    users.fullname, moms.mother
FROM
    users
JOIN
    moms
ON
    users.username= moms.username

```

## UPDATE
- Modify information in a table.
```
UPDATE
    users
SET
    password =‘yadayada’
WHERE
    idnum= 10
```

## DELETE
- Remove information from a table.
```
DELETE FROM
    users
WHERE
    username = ‘newman’
```
