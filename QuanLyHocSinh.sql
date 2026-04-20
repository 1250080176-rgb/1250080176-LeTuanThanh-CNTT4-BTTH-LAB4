-----------------------------------------------------
-- 1. CREATE TABLE THEO LUOC DO QUAN HE
--------------------------------------------------------------------------------

CREATE TABLE course (
    courseno        NUMBER(8,0)       CONSTRAINT pk_course PRIMARY KEY,
    description     VARCHAR2(50),
    cost            NUMBER(9,2),
    prerequisite    NUMBER(8,0),
    createdby       VARCHAR2(30)      NOT NULL,
    createddate     DATE              NOT NULL,
    modifiedby      VARCHAR2(30)      NOT NULL,
    modifieddate    DATE              NOT NULL,
    CONSTRAINT fk_course_prerequisite
        FOREIGN KEY (prerequisite) REFERENCES course(courseno)
);

CREATE TABLE instructor (
    instructorid    NUMBER(8,0)       CONSTRAINT pk_instructor PRIMARY KEY,
    salutation      VARCHAR2(5),
    firstname       VARCHAR2(25),
    lastname        VARCHAR2(25),
    address         VARCHAR2(50),
    phone           VARCHAR2(15),
    createdby       VARCHAR2(30)      NOT NULL,
    createddate     DATE              NOT NULL,
    modifiedby      VARCHAR2(30)      NOT NULL,
    modifieddate    DATE              NOT NULL
);

CREATE TABLE student (
    studentid       NUMBER(8,0)       CONSTRAINT pk_student PRIMARY KEY,
    salutation      VARCHAR2(5),
    firstname       VARCHAR2(25),
    lastname        VARCHAR2(25)      NOT NULL,
    address         VARCHAR2(50),
    phone           VARCHAR2(15),
    employer        VARCHAR2(50),
    registrationdate DATE             NOT NULL,
    createdby       VARCHAR2(30)      NOT NULL,
    createddate     DATE              NOT NULL,
    modifiedby      VARCHAR2(30)      NOT NULL,
    modifieddate    DATE              NOT NULL
);

CREATE TABLE class (
    classid         NUMBER(8,0)       CONSTRAINT pk_class PRIMARY KEY,
    courseno        NUMBER(8,0)       NOT NULL,
    classno         NUMBER(3,0)       NOT NULL,
    startdatetime   DATE,
    location        VARCHAR2(50),
    instructorid    NUMBER(8,0)       NOT NULL,
    capacity        NUMBER(3,0),
    createdby       VARCHAR2(30)      NOT NULL,
    createddate     DATE              NOT NULL,
    modifiedby      VARCHAR2(30)      NOT NULL,
    modifieddate    DATE              NOT NULL,
    CONSTRAINT fk_class_course
        FOREIGN KEY (courseno) REFERENCES course(courseno),
    CONSTRAINT fk_class_instructor
        FOREIGN KEY (instructorid) REFERENCES instructor(instructorid)
);

CREATE TABLE enrollment (
    studentid       NUMBER(8,0)       NOT NULL,
    classid         NUMBER(8,0)       NOT NULL,
    enrolldate      DATE              NOT NULL,
    finalgrade      NUMBER(3,0),
    createdby       VARCHAR2(30)      NOT NULL,
    createddate     DATE              NOT NULL,
    modifiedby      VARCHAR2(30)      NOT NULL,
    modifieddate    DATE              NOT NULL,
    CONSTRAINT pk_enrollment PRIMARY KEY (studentid, classid),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (studentid) REFERENCES student(studentid),
    CONSTRAINT fk_enrollment_class
        FOREIGN KEY (classid) REFERENCES class(classid)
);

CREATE TABLE grade (
    studentid       NUMBER(8,0)       NOT NULL,
    classid         NUMBER(8,0)       NOT NULL,
    grade           NUMBER(3,0),
    comments        VARCHAR2(200),
    createdby       VARCHAR2(30)      NOT NULL,
    createddate     DATE              NOT NULL,
    modifiedby      VARCHAR2(30)      NOT NULL,
    modifieddate    DATE              NOT NULL,
    CONSTRAINT pk_grade PRIMARY KEY (studentid, classid),
    CONSTRAINT fk_grade_student FOREIGN KEY (studentid) REFERENCES student(studentid),
    CONSTRAINT fk_grade_class FOREIGN KEY (classid) REFERENCES class(classid)
);

--------------------------------------------------------------------------------
-- DU LIEU MAU DE CAC BAI CHAY DUOC
--------------------------------------------------------------------------------

INSERT INTO course VALUES (10, 'DP Overview',           1000, NULL, USER, SYSDATE, USER, SYSDATE);
INSERT INTO course VALUES (20, 'Intro to Computers',   1200, NULL, USER, SYSDATE, USER, SYSDATE);
INSERT INTO course VALUES (30, 'Database Fundamentals',1500, 20,   USER, SYSDATE, USER, SYSDATE);
INSERT INTO course VALUES (40, 'PLSQL Programming',    1800, 30,   USER, SYSDATE, USER, SYSDATE);

INSERT INTO instructor VALUES (1, 'Mr.', 'An',   'Nguyen', 'Ha Noi', '0900000001', USER, SYSDATE, USER, SYSDATE);
INSERT INTO instructor VALUES (2, 'Ms.', 'Binh', 'Tran',   'Ha Noi', '0900000002', USER, SYSDATE, USER, SYSDATE);
INSERT INTO instructor VALUES (3, 'Mr.', 'Cuong','Le',     'Ha Noi', '0900000003', USER, SYSDATE, USER, SYSDATE);

INSERT INTO student VALUES (101, 'Mr.', 'Nam',  'Pham',  'Ha Noi', '0911111111', 'ABC', SYSDATE, USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (102, 'Ms.', 'Lan',  'Do',    'Ha Noi', '0922222222', 'XYZ', SYSDATE, USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (103, 'Mr.', 'Minh', 'Vo',    'Ha Noi', '0933333333', 'KLM', SYSDATE, USER, SYSDATE, USER, SYSDATE);
INSERT INTO student VALUES (104, 'Ms.', 'Hoa',  'Nguyen','Ha Noi', '0944444444', 'DEF', SYSDATE, USER, SYSDATE, USER, SYSDATE);

INSERT INTO class VALUES (1001, 10, 1, TO_DATE('01/03/2026 08:00','DD/MM/YYYY HH24:MI'), 'P101', 1, 30, USER, SYSDATE, USER, SYSDATE);
INSERT INTO class VALUES (1002, 20, 2, TO_DATE('02/03/2026 08:00','DD/MM/YYYY HH24:MI'), 'P102', 1, 30, USER, SYSDATE, USER, SYSDATE);
INSERT INTO class VALUES (1003, 20, 4, TO_DATE('03/03/2026 08:00','DD/MM/YYYY HH24:MI'), 'P103', 2, 30, USER, SYSDATE, USER, SYSDATE);
INSERT INTO class VALUES (1004, 30, 1, TO_DATE('04/03/2026 08:00','DD/MM/YYYY HH24:MI'), 'P104', 2, 30, USER, SYSDATE, USER, SYSDATE);
INSERT INTO class VALUES (1005, 40, 1, TO_DATE('05/03/2026 08:00','DD/MM/YYYY HH24:MI'), 'P105', 3, 30, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (101, 1001, SYSDATE, 85, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (101, 1002, SYSDATE, 92, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (101, 1004, SYSDATE, 76, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (102, 1002, SYSDATE, 65, USER, SYSDATE, USER, SYSDATE);
INSERT INTO enrollment VALUES (102, 1003, SYSDATE, 88, USER, SYSDATE, USER, SYSDATE);

INSERT INTO enrollment VALUES (103, 1002, SYSDATE, 45, USER, SYSDATE, USER, SYSDATE);

INSERT INTO grade VALUES (101, 1001, 85, 'Good', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (101, 1002, 92, 'Excellent', USER, SYSDATE, USER, SYSDATE);
INSERT INTO grade VALUES (102, 1002, 65, 'Average', USER, SYSDATE, USER, SYSDATE);

COMMIT;

--------------------------------------------------------------------------------
-- BAI 1: KHOI LENH PL/SQL CO BAN
--------------------------------------------------------------------------------

-- a. Tao bang Cau1 voi 2 cot ID va NAME
CREATE TABLE cau1 (
    id      NUMBER,
    name    VARCHAR2(20)
);

-- b. Tao sequence Cau1Seq buoc tang 5
CREATE SEQUENCE cau1seq
    START WITH 1
    INCREMENT BY 5
    NOCACHE
    NOCYCLE;

-- c, d, e, f, g, h, i, j: Lam trong mot khoi PL/SQL
DECLARE
    v_name          VARCHAR2(20);
    v_id            NUMBER;
    v_teacher_name  VARCHAR2(20);
BEGIN
    DBMS_OUTPUT.PUT_LINE('================ BAI 1 ================');

    -- d. Them sinh vien dang ky nhieu mon hoc nhat
    SELECT s.lastname
    INTO v_name
    FROM student s
    JOIN (
        SELECT e.studentid, COUNT(*) cnt
        FROM enrollment e
        GROUP BY e.studentid
        ORDER BY cnt DESC, e.studentid
    ) x
      ON s.studentid = x.studentid
    WHERE ROWNUM = 1;

    v_id := cau1seq.NEXTVAL;
    INSERT INTO cau1(id, name) VALUES (v_id, v_name);
    SAVEPOINT A;
    DBMS_OUTPUT.PUT_LINE('d) Da them SV dang ky nhieu nhat: ID=' || v_id || ', NAME=' || v_name);

    -- e. Them sinh vien dang ky it mon hoc nhat
    SELECT s.lastname
    INTO v_name
    FROM student s
    JOIN (
        SELECT e.studentid, COUNT(*) cnt
        FROM enrollment e
        GROUP BY e.studentid
        ORDER BY cnt ASC, e.studentid
    ) x
      ON s.studentid = x.studentid
    WHERE ROWNUM = 1;

    v_id := cau1seq.NEXTVAL;
    INSERT INTO cau1(id, name) VALUES (v_id, v_name);
    SAVEPOINT B;
    DBMS_OUTPUT.PUT_LINE('e) Da them SV dang ky it nhat: ID=' || v_id || ', NAME=' || v_name);

    -- f. Them giao vien day nhieu mon hoc nhat
    SELECT i.lastname
    INTO v_teacher_name
    FROM instructor i
    JOIN (
        SELECT c.instructorid, COUNT(*) cnt
        FROM class c
        GROUP BY c.instructorid
        ORDER BY cnt DESC, c.instructorid
    ) x
      ON i.instructorid = x.instructorid
    WHERE ROWNUM = 1;

    v_id := cau1seq.NEXTVAL;
    INSERT INTO cau1(id, name) VALUES (v_id, v_teacher_name);
    SAVEPOINT C;
    DBMS_OUTPUT.PUT_LINE('f) Da them GV day nhieu nhat: ID=' || v_id || ', NAME=' || v_teacher_name);

    -- g. SELECT INTO chua ID cua giao vien vua them vao bien v_id
    SELECT id INTO v_id
    FROM cau1
    WHERE name = v_teacher_name
      AND ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE('g) SELECT INTO lay duoc ID cua GV "' || v_teacher_name || '" la: ' || v_id);

    -- h. Undo giao vien duoc them vao (rollback ve Savepoint B)
    ROLLBACK TO B;
    DBMS_OUTPUT.PUT_LINE('h) Da rollback giao vien vua them (quay ve savepoint B)');

    -- i. Them giao vien day it mon hoc nhat, khong lay ID tu sequence
    --    ma lay lai ID cua giao vien vua rollback truoc do
    SELECT i.lastname
    INTO v_teacher_name
    FROM instructor i
    JOIN (
        SELECT c.instructorid, COUNT(*) cnt
        FROM class c
        GROUP BY c.instructorid
        ORDER BY cnt ASC, c.instructorid
    ) x
      ON i.instructorid = x.instructorid
    WHERE ROWNUM = 1;

    INSERT INTO cau1(id, name) VALUES (v_id, v_teacher_name);
    DBMS_OUTPUT.PUT_LINE('i) Da them GV day it nhat voi ID cu=' || v_id || ', NAME=' || v_teacher_name);

    -- j. Lam lai cau f voi ID lay tu sequence
    SELECT i.lastname
    INTO v_teacher_name
    FROM instructor i
    JOIN (
        SELECT c.instructorid, COUNT(*) cnt
        FROM class c
        GROUP BY c.instructorid
        ORDER BY cnt DESC, c.instructorid
    ) x
      ON i.instructorid = x.instructorid
    WHERE ROWNUM = 1;

    v_id := cau1seq.NEXTVAL;
    INSERT INTO cau1(id, name) VALUES (v_id, v_teacher_name);
    DBMS_OUTPUT.PUT_LINE('j) Lam lai cau f voi ID tu sequence: ID=' || v_id || ', NAME=' || v_teacher_name);

    COMMIT;
END;
/
-- Xem ket qua Bai 1
SELECT * FROM cau1 ORDER BY id;

--------------------------------------------------------------------------------
-- BAI 1 - CAU 2
-- Nguoi dung nhap ma sinh vien. Neu ton tai thi hien thi ho ten va so lop dang hoc.
-- Nguoc lai yeu cau them moi sinh vien voi ma da nhap.
--
-- Co the test bang cach sua gia tri v_input_id, v_new_first, v_new_last, v_new_addr.
--------------------------------------------------------------------------------
DECLARE
    v_input_id      NUMBER := 105;  -- DOI GIA TRI DE TEST
    v_new_first     VARCHAR2(25) := 'Tuan';
    v_new_last      VARCHAR2(25) := 'Le';
    v_new_addr      VARCHAR2(50) := 'Tuyen Quang';
    v_count         NUMBER;
    v_fullname      VARCHAR2(60);
    v_class_count   NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('========== BAI 1 - CAU 2 ==========');

    SELECT COUNT(*) INTO v_count
    FROM student
    WHERE studentid = v_input_id;

    IF v_count > 0 THEN
        SELECT NVL(firstname,'') || ' ' || lastname,
               (
                   SELECT COUNT(*)
                   FROM enrollment e
                   WHERE e.studentid = s.studentid
               )
        INTO v_fullname, v_class_count
        FROM student s
        WHERE s.studentid = v_input_id;

        DBMS_OUTPUT.PUT_LINE('Sinh vien ton tai.');
        DBMS_OUTPUT.PUT_LINE('Ho ten: ' || TRIM(v_fullname));
        DBMS_OUTPUT.PUT_LINE('So lop dang hoc: ' || v_class_count);
    ELSE
        INSERT INTO student (
            studentid, salutation, firstname, lastname, address, phone, employer,
            registrationdate, createdby, createddate, modifiedby, modifieddate
        ) VALUES (
            v_input_id, NULL, v_new_first, v_new_last, v_new_addr, NULL, NULL,
            SYSDATE, USER, SYSDATE, USER, SYSDATE
        );

        DBMS_OUTPUT.PUT_LINE('Khong tim thay sinh vien. Da them moi sinh vien co ma = ' || v_input_id);
        COMMIT;
    END IF;
END;
/

--------------------------------------------------------------------------------
-- BAI 2: CAC CAU TRUC DIEU KHIEN
--------------------------------------------------------------------------------

-- 1. Nhap ma giao vien, xac dinh so luong lop dang day
DECLARE
    v_instructor_id NUMBER := 1; -- DOI GIA TRI DE TEST
    v_count         NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('========== BAI 2 - CAU 1 ==========');

    SELECT COUNT(*)
    INTO v_count
    FROM class
    WHERE instructorid = v_instructor_id;

    IF v_count >= 5 THEN
        DBMS_OUTPUT.PUT_LINE('Giao vien nay nen nghi ngoi!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('So lop giao vien nay dang day: ' || v_count);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Khong tim thay giao vien.');
END;
/

-- 2. Dung CASE: Nhap ma sinh vien va ma lop, in diem chu
DECLARE
    v_student_id    NUMBER := 101;  -- DOI GIA TRI DE TEST
    v_class_id      NUMBER := 1002; -- DOI GIA TRI DE TEST
    v_exists        NUMBER;
    v_grade         NUMBER;
    v_letter        VARCHAR2(2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('========== BAI 2 - CAU 2 ==========');

    SELECT COUNT(*) INTO v_exists FROM student WHERE studentid = v_student_id;
    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Ma sinh vien khong ton tai.');
        RETURN;
    END IF;

    SELECT COUNT(*) INTO v_exists FROM class WHERE classid = v_class_id;
    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Ma lop khong ton tai.');
        RETURN;
    END IF;

    SELECT COUNT(*)
    INTO v_exists
    FROM enrollment
    WHERE studentid = v_student_id
      AND classid = v_class_id;

    IF v_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Sinh vien khong hoc lop nay.');
        RETURN;
    END IF;

    SELECT NVL(finalgrade, -1)
    INTO v_grade
    FROM enrollment
    WHERE studentid = v_student_id
      AND classid = v_class_id;

    CASE
        WHEN v_grade BETWEEN 90 AND 100 THEN v_letter := 'A';
        WHEN v_grade >= 80 AND v_grade < 90 THEN v_letter := 'B';
        WHEN v_grade >= 70 AND v_grade < 80 THEN v_letter := 'C';
        WHEN v_grade >= 50 AND v_grade < 70 THEN v_letter := 'D';
        WHEN v_grade >= 0  AND v_grade < 50 THEN v_letter := 'F';
        ELSE v_letter := 'N/A';
    END CASE;

    DBMS_OUTPUT.PUT_LINE('Diem so: ' || v_grade || ' --> Diem chu: ' || v_letter);
END;
/

--------------------------------------------------------------------------------
-- BAI 3: CURSOR
--------------------------------------------------------------------------------
DECLARE
    CURSOR c_course IS
        SELECT courseno, description
        FROM course
        ORDER BY courseno;

    CURSOR c_class(p_courseno NUMBER) IS
        SELECT c.classid,
               c.classno,
               (SELECT COUNT(*) FROM enrollment e WHERE e.classid = c.classid) AS student_count
        FROM class c
        WHERE c.courseno = p_courseno
        ORDER BY c.classno;

BEGIN
    DBMS_OUTPUT.PUT_LINE('========== BAI 3: CURSOR ==========');

    FOR r_course IN c_course LOOP
        DBMS_OUTPUT.PUT_LINE(r_course.courseno || ' ' || r_course.description);

        FOR r_class IN c_class(r_course.courseno) LOOP
            DBMS_OUTPUT.PUT_LINE('   Lop: ' || r_class.classno ||
                                 ' co so luong sinh vien dang ki: ' || r_class.student_count);
        END LOOP;
    END LOOP;
END;
/

--------------------------------------------------------------------------------
-- BAI 4: CAC THU TUC VA HAM
--------------------------------------------------------------------------------

-- 1a. Thu tuc find_sname
CREATE OR REPLACE PROCEDURE find_sname (
    i_student_id     IN  student.studentid%TYPE,
    o_first_name     OUT student.firstname%TYPE,
    o_last_name      OUT student.lastname%TYPE
)
AS
BEGIN
    SELECT firstname, lastname
    INTO o_first_name, o_last_name
    FROM student
    WHERE studentid = i_student_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        o_first_name := NULL;
        o_last_name  := NULL;
END;
/
SHOW ERRORS;

-- 1b. Thu tuc print_student_name
CREATE OR REPLACE PROCEDURE print_student_name (
    p_student_id IN student.studentid%TYPE
)
AS
    v_first student.firstname%TYPE;
    v_last  student.lastname%TYPE;
BEGIN
    find_sname(p_student_id, v_first, v_last);

    IF v_last IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Khong tim thay sinh vien co ma: ' || p_student_id);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ten sinh vien: ' || NVL(v_first,'') || ' ' || v_last);
    END IF;
END;
/
SHOW ERRORS;

-- 2. Thu tuc Discount: giam 5% cho cac mon hoc co so SV dang ky > 15
CREATE OR REPLACE PROCEDURE discount
AS
BEGIN
    FOR r IN (
        SELECT c.courseno, c.description
        FROM course c
        WHERE c.courseno IN (
            SELECT cl.courseno
            FROM class cl
            JOIN enrollment e ON e.classid = cl.classid
            GROUP BY cl.courseno
            HAVING COUNT(*) > 15
        )
    ) LOOP
        UPDATE course
        SET cost = cost * 0.95
        WHERE courseno = r.courseno;

        DBMS_OUTPUT.PUT_LINE('Da giam 5% hoc phi cho mon: ' || r.description);
    END LOOP;
END;
/
SHOW ERRORS;

-- 3. Ham total_cost_for_student
CREATE OR REPLACE FUNCTION total_cost_for_student (
    p_student_id IN student.studentid%TYPE
)
RETURN NUMBER
AS
    v_exists NUMBER;
    v_total  NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_exists
    FROM student
    WHERE studentid = p_student_id;

    IF v_exists = 0 THEN
        RETURN NULL;
    END IF;

    SELECT NVL(SUM(c.cost), 0)
    INTO v_total
    FROM enrollment e
    JOIN class cl ON e.classid = cl.classid
    JOIN course c ON cl.courseno = c.courseno
    WHERE e.studentid = p_student_id;

    RETURN v_total;
END;
/
SHOW ERRORS;

-- Chay thu Bai 4
DECLARE
    v_first VARCHAR2(25);
    v_last  VARCHAR2(25);
    v_total NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('========== BAI 4 ==========');

    find_sname(101, v_first, v_last);
    DBMS_OUTPUT.PUT_LINE('find_sname(101): ' || NVL(v_first,'') || ' ' || NVL(v_last,'NULL'));

    print_student_name(102);

    v_total := total_cost_for_student(101);
    DBMS_OUTPUT.PUT_LINE('Tong hoc phi SV 101 phai tra: ' || NVL(TO_CHAR(v_total), 'NULL'));
END;
/

--------------------------------------------------------------------------------
-- BAI 5: TRIGGER
--------------------------------------------------------------------------------

-- 1. Trigger audit cho tat ca bang:
--    insert/update tu dong gan created_by, created_date, modified_by, modified_date

CREATE OR REPLACE TRIGGER trg_course_audit
BEFORE INSERT OR UPDATE ON course
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.createdby   := USER;
        :NEW.createddate := SYSDATE;
    END IF;
    :NEW.modifiedby   := USER;
    :NEW.modifieddate := SYSDATE;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_class_audit
BEFORE INSERT OR UPDATE ON class
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.createdby   := USER;
        :NEW.createddate := SYSDATE;
    END IF;
    :NEW.modifiedby   := USER;
    :NEW.modifieddate := SYSDATE;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_student_audit
BEFORE INSERT OR UPDATE ON student
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.createdby   := USER;
        :NEW.createddate := SYSDATE;
    END IF;
    :NEW.modifiedby   := USER;
    :NEW.modifieddate := SYSDATE;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_enrollment_audit
BEFORE INSERT OR UPDATE ON enrollment
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.createdby   := USER;
        :NEW.createddate := SYSDATE;
    END IF;
    :NEW.modifiedby   := USER;
    :NEW.modifieddate := SYSDATE;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_instructor_audit
BEFORE INSERT OR UPDATE ON instructor
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.createdby   := USER;
        :NEW.createddate := SYSDATE;
    END IF;
    :NEW.modifiedby   := USER;
    :NEW.modifieddate := SYSDATE;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trg_grade_audit
BEFORE INSERT OR UPDATE ON grade
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.createdby   := USER;
        :NEW.createddate := SYSDATE;
    END IF;
    :NEW.modifiedby   := USER;
    :NEW.modifieddate := SYSDATE;
END;
/
SHOW ERRORS;

-- 2. Trigger moi sinh vien khong duoc qua 3 mon hoc
CREATE OR REPLACE TRIGGER trg_enrollment_max3courses
BEFORE INSERT OR UPDATE ON enrollment
FOR EACH ROW
DECLARE
    v_new_courseno   class.courseno%TYPE;
    v_count_distinct NUMBER;
BEGIN
    SELECT courseno
    INTO v_new_courseno
    FROM class
    WHERE classid = :NEW.classid;

    SELECT COUNT(DISTINCT cl.courseno)
    INTO v_count_distinct
    FROM enrollment e
    JOIN class cl ON e.classid = cl.classid
    WHERE e.studentid = :NEW.studentid
      AND NOT (e.studentid = NVL(:OLD.studentid, -1) AND e.classid = NVL(:OLD.classid, -1));

    SELECT COUNT(*)
    INTO v_count_distinct
    FROM (
        SELECT DISTINCT cl.courseno
        FROM enrollment e
        JOIN class cl ON e.classid = cl.classid
        WHERE e.studentid = :NEW.studentid
          AND NOT (e.studentid = NVL(:OLD.studentid, -1) AND e.classid = NVL(:OLD.classid, -1))
        UNION
        SELECT v_new_courseno FROM dual
    );

    IF v_count_distinct > 3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Moi sinh vien khong duoc dang ky qua 3 mon hoc.');
    END IF;
END;
/
SHOW ERRORS;

--------------------------------------------------------------------------------
-- CHAY THU TRIGGER GIOI HAN 3 MON
--------------------------------------------------------------------------------
BEGIN
    DBMS_OUTPUT.PUT_LINE('========== TEST TRIGGER MAX 3 COURSES ==========');

    BEGIN
        -- SV 101 da hoc 3 mon khac nhau: 10, 20, 30
        -- Thu them mon 40 -> phai loi
        INSERT INTO enrollment(studentid, classid, enrolldate, finalgrade, createdby, createddate, modifiedby, modifieddate)
        VALUES (101, 1005, SYSDATE, NULL, USER, SYSDATE, USER, SYSDATE);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Trigger bao loi dung yeu cau: ' || SQLERRM);
            ROLLBACK;
    END;
END;
/

--------------------------------------------------------------------------------
-- CAC LENH KIEM TRA KET QUA
--------------------------------------------------------------------------------
PROMPT ===== DANH SACH BANG CAU1 =====
SELECT * FROM cau1 ORDER BY id;

PROMPT ===== DANH SACH SINH VIEN =====
SELECT studentid, firstname, lastname, address
FROM student
ORDER BY studentid;

PROMPT ===== TONG CHI PHI SINH VIEN 101 =====
SELECT total_cost_for_student(101) AS total_cost
FROM dual;

PROMPT ===== THONG TIN COURSE =====
SELECT courseno, description, cost, createdby, createddate, modifiedby, modifieddate
FROM course
ORDER BY courseno;