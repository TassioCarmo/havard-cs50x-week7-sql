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

```

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
