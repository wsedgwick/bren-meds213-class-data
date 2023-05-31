DROP Table Bird_eggs;
DROP TABLE Bird_nests;

PRAGMA foreign_keys = OFF;

CREATE TABLE Bird_nests (
    Book_page TEXT,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1950 AND 2015),
    Site TEXT NOT NULL,
    Nest_ID TEXT PRIMARY KEY,
    Species TEXT NOT NULL,
    Observer TEXT,
    Date_found TEXT NOT NULL
        CHECK (Date_found BETWEEN Year||'-01-01' AND Year||'-12-31'),
    how_found_temp TEXT,
    Clutch_max_temp TEXT,
    floatAge_temp TEXT,
    ageMethod_temp TEXT,
    padding TEXT,
    FOREIGN KEY (Site) REFERENCES Site (Code),
    FOREIGN KEY (Species) REFERENCES Species (Code),
    FOREIGN KEY (Observer) REFERENCES Personnel (Abbreviation)
);

.import --csv db/ASDN_Bird_nests_mongo.csv Bird_nests

UPDATE Bird_nests SET Observer = NULL WHERE Observer = '';

-- Sadly, the following will not go back and check that foreign key
-- references are valid.

PRAGMA foreign_keys = ON;

UPDATE Bird_nests SET Book_page = NULL WHERE Book_page = '';

-- To add proper constraints on columns that come in with empty values
-- that only later get replaced with NULLs, must do the rigamarole
-- below.

UPDATE Bird_nests SET how_found_temp = NULL WHERE how_found_temp = '';
ALTER TABLE Bird_nests ADD COLUMN how_found TEXT DEFAULT NULL
    CHECK (how_found IN ('searcher', 'rope', 'bander'));
UPDATE Bird_nests SET how_found = how_found_temp;
ALTER TABLE Bird_nests DROP COLUMN how_found_temp;

UPDATE Bird_nests SET Clutch_max_temp = NULL WHERE Clutch_max_temp = '';
ALTER TABLE Bird_nests ADD COLUMN Clutch_max INTEGER DEFAULT NULL
    CHECK (Clutch_max BETWEEN 0 AND 20);
UPDATE Bird_nests SET Clutch_max = CAST(Clutch_max_temp AS INTEGER);
ALTER TABLE Bird_nests DROP COLUMN Clutch_max_temp;

UPDATE Bird_nests SET floatAge_temp = NULL WHERE floatAge_temp = '';
ALTER TABLE Bird_nests ADD COLUMN floatAge REAL DEFAULT NULL
    CHECK (floatAge BETWEEN 0 AND 30);
UPDATE Bird_nests SET floatAge = CAST(floatAge_temp AS REAL);
ALTER TABLE Bird_nests DROP COLUMN floatAge_temp;

UPDATE Bird_nests SET ageMethod_temp = NULL
    WHERE ageMethod_temp = '' OR ageMethod_temp = 'none';
ALTER TABLE Bird_nests ADD COLUMN ageMethod TEXT DEFAULT NULL
    CHECK (ageMethod IN ('float', 'lay', 'hatch'));
UPDATE Bird_nests SET ageMethod = ageMethod_temp;
ALTER TABLE Bird_nests DROP COLUMN ageMethod_temp;
