INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('taro-yamada', '太郎', '山田', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('aaaa', 'Aaa', 'Aaa', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('bbbb', 'Bbb', 'Bbb', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('cccc', 'Ccc', 'Ccc', 'ADMIN', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
--
INSERT INTO meeting_room (room_name) VALUES ('新木場')/;
INSERT INTO meeting_room (room_name) VALUES ('辰巳')/;
INSERT INTO meeting_room (room_name) VALUES ('豊洲')/;
INSERT INTO meeting_room (room_name) VALUES ('月島')/;
INSERT INTO meeting_room (room_name) VALUES ('新富町')/;
INSERT INTO meeting_room (room_name) VALUES ('銀座一丁目')/;
INSERT INTO meeting_room (room_name) VALUES ('有楽町')/;
-- Stored Procedure
DROP FUNCTION IF EXISTS REGISTER_RESERVABLE_ROOMS()/;
CREATE OR REPLACE FUNCTION REGISTER_RESERVABLE_ROOMS()
  RETURNS
    INT AS $$
DECLARE
  total INT;
  i INT4;
  id INT4;
BEGIN
  total := 0;
  FOR id IN SELECT room_id
            FROM meeting_room LOOP
    i := 0;
    FOR i IN 0..77 LOOP
      INSERT INTO reservable_room (reserved_date, room_id)
      VALUES (CURRENT_DATE + i - 7, id);
    END LOOP;
    total := total + i;
  END LOOP;
  RETURN total;
END;
$$ LANGUAGE plpgsql
/;
SELECT REGISTER_RESERVABLE_ROOMS() /;
COMMIT /;