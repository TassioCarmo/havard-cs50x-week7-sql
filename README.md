# Introduction to SQL

## What did i learn


CSV is very portable. 

"" in CSV Google has done, what Microsoft does, what Apple does is, they quote any strings of text that themselves have commas so that these are now English grammatical commas, not CSV specific commas. 

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

Dict object

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

