SELECT Nest_ID
    FROM Bird_nests
    WHERE Site = 'nome' AND
          Species = 'ruff' AND
          Year = 1983 AND
          Observer = 'bharrington' AND
          ageMethod = 'float';
