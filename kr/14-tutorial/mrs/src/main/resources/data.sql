-- 회의실
INSERT INTO meeting_room (room_name) VALUES ('진부령');
INSERT INTO meeting_room (room_name) VALUES ('미시령');
INSERT INTO meeting_room (room_name) VALUES ('대관련');
INSERT INTO meeting_room (room_name) VALUES ('죽령');
INSERT INTO meeting_room (room_name) VALUES ('조령');
INSERT INTO meeting_room (room_name) VALUES ('이화령');
INSERT INTO meeting_room (room_name) VALUES ('추풍령');
INSERT INTO meeting_room (room_name) VALUES ('육십령');
INSERT INTO meeting_room (room_name) VALUES ('팔량치');
INSERT INTO meeting_room (room_name) VALUES ('차령');
INSERT INTO meeting_room (room_name) VALUES ('노령');

-- 사용자 (비밀번호: demo)
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Go Damdeok', '담덕', '고', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK');
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Kim Yusin', '유신', '김', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK');
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Heukchi Sangji', '상지', '흑치', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK');
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Cheok Junkyung', '준경', '척', 'ADMIN', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK');
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Lee soonsin', '순신', '이', 'ADMIN', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK');
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Kim Jwajin', '좌진', '김', 'ADMIN', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK');


-- 회의실 예약 가능일(room_id 1, 7만 등록함)
-- room_id = 1의 예약 가능 날짜
INSERT INTO reservable_room (reserved_date, room_id) VALUES (CURRENT_DATE, 1);
INSERT INTO reservable_room (reserved_date, room_id) VALUES (CURRENT_DATE + 1, 1);
INSERT INTO reservable_room (reserved_date, room_id) VALUES (CURRENT_DATE - 1, 1);

-- room_id = 1의 예약 가능 날짜
INSERT INTO reservable_room (reserved_date, room_id) VALUES (CURRENT_DATE, 7);
INSERT INTO reservable_room (reserved_date, room_id) VALUES (CURRENT_DATE + 1, 7);
INSERT INTO reservable_room (reserved_date, room_id) VALUES (CURRENT_DATE - 1, 7);


/*

-- 회의실
INSERT INTO meeting_room (room_name) VALUES ('진부령')/;
INSERT INTO meeting_room (room_name) VALUES ('미시령')/;
INSERT INTO meeting_room (room_name) VALUES ('대관련')/;
INSERT INTO meeting_room (room_name) VALUES ('죽령')/;
INSERT INTO meeting_room (room_name) VALUES ('조령')/;
INSERT INTO meeting_room (room_name) VALUES ('이화령')/;
INSERT INTO meeting_room (room_name) VALUES ('추풍령')/;
INSERT INTO meeting_room (room_name) VALUES ('육십령')/;
INSERT INTO meeting_room (room_name) VALUES ('팔량치')/;
INSERT INTO meeting_room (room_name) VALUES ('차령')/;
INSERT INTO meeting_room (room_name) VALUES ('노령')/;

-- 사용자 (비밀번호: demo)
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Go Damdeok', '담덕', '고', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Kim Yusin', '유신', '김', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Heukchi Sangji', '상지', '흑치', 'USER', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Cheok Junkyung', '준경', '척', 'ADMIN', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Lee soonsin', '순신', '이', 'ADMIN', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;
INSERT INTO usr (user_id, first_name, last_name, role_name, password)
VALUES ('Kim Jwajin', '좌진', '김', 'ADMIN', '$2a$10$oxSJl.keBwxmsMLkcT9lPeAIxfNTPNQxpeywMrF7A3kVszwUTqfTK')/;


-- 회의실 예약 가능일 (Stored Procedure)
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
*/