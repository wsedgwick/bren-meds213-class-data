CREATE TRIGGER update_species
AFTER INSERT ON new_species
FOR EACH ROW
BEGIN
   UPDATE new_species
   SET Scientific_name = NULL
   WHERE Code = new.Code AND Scientific_name = '';
END;
