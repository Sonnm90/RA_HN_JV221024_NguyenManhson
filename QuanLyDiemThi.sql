-- Bai 1: Tao CSDL
create database quanlydiemthi;
use quanlydiemthi;

--  Tao bang student
create table student (
studentId varchar(4) primary key,
studentName varchar(100) not null,
birthday date not null,
gender bit(1) not null,
address text not null,
phoneNumber varchar(45) unique
);

--  Tao bang Subject
create table subject (
subjectId varchar(4) primary key,
subjectName varchar(45) not null,
priority int(11) not null
);

--  Tao bang Mark
create table Mark (
subjectId varchar(4) not null,
studentId varchar(4) not null,
point float not null,
primary key(subjectId,studentId),
constraint fk_subject
foreign key(subjectId) references subject(subjectId),
constraint fk_student
foreign key(studentId) references student(studentId)
); 

alter table mark modify point float;
-- Bai 2: Them , sua, xoa du lieu

-- Them du lieu vao bang student
 insert into student(studentID,studentName,birthday,gender,address,phoneNumber) values
 ('S001','Nguyễn Thế Anh','1999/1/11',1,'Hà Nội','984678082'),
 ('S002','Đặng Bảo Trâm','1998/12/22',0,'Lào Cai','904982654'),
 ('S003','Trần Hà Phương','2000/5/5',0,'Nghệ An','947645363'),
 ('S004','Đỗ Tiến Mạnh','1999/3/26',1,'Hà Nội','983665353'),
 ('S005','Phạm Duy Nhất','1998/10/4',1,'Tuyên Quang','987242678'),
 ('S006','Mai Văn Thái','2002/6/22',1,'Nam Định','982654268'),
 ('S007','Giang Gia Hân','1996/11/10',0,'Phú Thọ','982364753'),
 ('S008','Nguyễn Ngọc Bảo My','1999/1/22',0,'Hà Nam','927867453'),
 ('S009','Nguyễn Tiến Đạt','1998/8/7',1,'Tuyên Quang','989274673'),
 ('S010','Nguyễn Thiều Quang','2000/9/18',1,'Hà Nội','984378291');
 
-- Them du lieu vao abng Subject 
insert into Subject(subjectId,subjectName,priority) values
('MH01','Toán',2),
('MH02','Vật Lý',2),
('MH03','Hóa Học',1),
('MH04','Ngữ Văn',1),
('MH05','Tiếng Anh',2);

-- Them du lieu vao abng Mark
insert into Mark (studentId, subjectId, point) values
('S001','MH01',8.5),('S001','MH02',7),('S001','MH03',9),('S001','MH04',9),('S001','MH05',5),
('S002','MH01',9),('S002','MH02',8),('S002','MH03',6.5),('S002','MH04',8),('S002','MH05',6),
('S003','MH01',7.5),('S003','MH02',6.5),('S003','MH03',8),('S003','MH04',7),('S003','MH05',7),
('S004','MH01',6),('S004','MH02',7),('S004','MH03',5),('S004','MH04',6.5),('S004','MH05',8),
('S005','MH01',5.5),('S005','MH02',8),('S005','MH03',7.5),('S005','MH04',8.5),('S005','MH05',9),
('S006','MH01',8),('S006','MH02',10),('S006','MH03',9),('S006','MH04',7.5),('S006','MH05',6.5),
('S007','MH01',9.5),('S007','MH02',9),('S007','MH03',6),('S007','MH04',9),('S007','MH05',4),
('S008','MH01',10),('S008','MH02',8.5),('S008','MH03',8.5),('S008','MH04',6),('S008','MH05',9.5),
('S009','MH01',7.5),('S009','MH02',7),('S009','MH03',9),('S009','MH04',5),('S009','MH05',10),
('S010','MH01',6.5),('S010','MH02',8),('S010','MH03',5.5),('S010','MH04',4),('S010','MH05',7);

-- Bai 2:  Cap nhat du lieu
-- Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh” 
update student set studentName = 'Đỗ Đức Mạnh' where studentId = 'S004';

-- Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.
update subject set subjectName = 'Ngoại Ngữ', priority = 1 where subjectId = 'MH05';

-- Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6,MH05 : 9)
update mark set point = 8.5 where studentId = 'S009' and subjectId = 'MH01';
update mark set point = 7 where studentId = 'S009' and subjectId = 'MH02';
update mark set point = 5.5 where studentId = 'S009' and subjectId = 'MH03';
update mark set point = 6 where studentId = 'S009' and subjectId = 'MH04';
update mark set point = 9 where studentId = 'S009' and subjectId = 'MH05';

-- Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT.
delete from mark where studentId ='S010';
delete from student where studentId ='S010';

-- Bai 3: Truy vấn lấy dữ liệu

-- Lấy ra tất cả thông tin sinh viên trong bảng Student
select * from student; 

-- Hiển thị tên và mã môn học của những môn có hệ số bằng 1
select subjectName, subjectId from subject where priority = 1;

-- Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ
-- năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh
SELECT studentId as 'Mã HS', studentName as 'Tên HS', YEAR(curdate())-YEAR(birthday) as 'Tuổi',
CASE Gender WHEN 0 THEN 'Nữ' WHEN 1 THEN 'Nam' ELSE 'Unknown' END AS 'Giới tính',
address as 'Quê quán' FROM student;

-- Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn
-- Toán và sắp xếp theo điểm giảm dần
select s.studentName as 'Tên HS', subjectName as 'Tên MH', point as 'Điểm' from student s
join mark on s.studentId = mark.studentId
join subject on subject.subjectId = mark.subjectId
where subjectName = 'Toán'
order by point desc;

-- Thống kê số lượng học sinh theo giới tính ở trong bảng
select CASE Gender WHEN 0 THEN 'Nữ' WHEN 1 THEN 'Nam' ELSE 'Unknown' END AS 'Giới tính',
count(gender) as 'Số lượng' from student
group by gender;

-- Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
-- để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình
select s.studentId as 'Mã HS', s.studentName as 'Tên HS', sum(point) as 'Tổng điểm', sum(point)/5 as 'Điểm TB'
from student s  
join mark on s.studentId= mark.studentId
group by s.studentId;

-- Bai 4 Tạo View, Index, Procedure 



-- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả
-- thông tin học sinh đó.
delimiter //
CREATE PROCEDURE PROC_INSERTSTUDENT(studentId varchar(4), studentName varchar(100), birthday date, gender bit(1),
 address text,phoneNumber varchar(45))
 AS
 BEGIN
 IF EXISTS(SELECT * FROM student WHERE studentId=student.studentId)
 BEGIN
 PRINT 
	'Sinh viên này đã có, nhập mã khác'
	RETURN -1
 END
INSERT INTO student
VALUES (studentId, studentName, birthday, gender,address, phoneNumber)
END
delimiter ;

-- Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
delimiter //
CREATE PROCEDURE PROC_UPDATESUBJECTT(subjectId varchar(4), updateSubjectName varchar(45))
 AS
 BEGIN
 IF EXISTS(SELECT * FROM subject WHERE subjectId<>subject.subjectId)
 BEGIN
 PRINT 
	'Môn học này không tồn tại'
	RETURN -1
 END
update subject set subjectName =  updateSubjectName where subject.subjectId = subjectId;
END
delimiter ;

-- Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh
delimiter //
CREATE PROCEDURE PROC_DELETEMARK(studentId varchar(4))
 AS
 BEGIN
 IF EXISTS(SELECT * FROM student WHERE studentId <> student.studentId)
 BEGIN
 PRINT 
	'Học sinh này không tồn tại'
	RETURN -1
 END
delete from mark where mark.studentId = studentId;
END
delimiter ;
