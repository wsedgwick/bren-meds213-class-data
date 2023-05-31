import csv
from random import randrange, choice
import sqlite3
import sys
num_rows = int(sys.argv[1])
conn = sqlite3.connect("db/database.db")
c = conn.cursor()
sites = [t[0] for t in c.execute("SELECT Code FROM Site")]
species_list = [t[0] for t in c.execute("SELECT Code FROM Species")]
observers = [t[0] for t in c.execute("SELECT Abbreviation FROM Personnel")]
w = csv.writer(open("db/ASDN_Bird_nests_mongo.csv", "w"))
for n in range(num_rows):
    book_page = f"b{randrange(1, 100)}.{randrange(1, 100)}"
    year = str(randrange(1950, 2016))
    site = choice(sites)
    nest_id = f"gen{n}"
    species = choice(species_list)
    observer = choice(observers)
    date_found = f"{year}-{randrange(1, 13):02}-{randrange(1, 29):02}"
    how_found = choice(["searcher", "rope", "bander"])
    clutch_max = randrange(21)
    float_age = ""
    age_method = choice(["", "float", "lay", "hatch"])
    if age_method != "":
        float_age = randrange(31)
    padding = "".join(choice("qwertyuiopasdfghjklzxcvbnm") for _ in range(3000))
    w.writerow([book_page, year, site, nest_id, species, observer, date_found, how_found,
        clutch_max, float_age, age_method, padding])
