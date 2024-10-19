--Câu 1
create table KHOAHOC(
    MAKH char(10) primary key,
    TENKH varchar(20) not null,
    NGAYBD date not null,
    NGAYKT date not null,
    constraint dk_date check(NGAYBD < NGAYKT)
);

create table CHUONGTRINH(
    MACT char(10) primary key,
    TENCT varchar(20) not null
);

create table LOAILOP(
    MALOAI char(10) primary key,
    MACT char(10) references CHUONGTRINH(MACT),
    TENLOAI varchar(20) not null
);

create table LOP(
    MALOP char(10) primary key,
    MALOAI char(10) references LOAILOP(MALOAI),
    TENLOP varchar(20) not null,
    SISO smallint not null check(SISO>12),
    MAKH char(10) references KHOAHOC(MAKH)
);

create table HOCVIEN(
    MAHV char(10) primary key,
    TENHV varchar(20) not null,
    GIOITINH char(1) check(GIOITINH in ('0','1')),
    NGAYSINH date not null,
    SDT varchar(15) not null,
    DIACHI varchar(30) not null
);

create table PHIEUTHU(
    SOPT char(10) primary key,
    MAHV char(10) references HOCVIEN(MAHV),
    MALOP char(10) references LOP(MALOP),
    NGAYLAPPHIEU date not null,
    THANHTIEN int check(THANHTIEN>0)
);

create table MONHOC(
    MAMH char(10) primary key,
    TENMH varchar(20) not null
);

create table DIEM(
    MAMH char(10) not null references MONHOC(MAMH),
    MAHV char(10) not null references HOCVIEN(MAHV),
    MALOP char(10) not null references LOP(MALOP),
    DIEM int check(DIEM>=0 and DIEM<=10),
    primary key(MAMH,MAHV,MALOP)
);


--Câu 2

--*Bảng KHOAHOC:
begin
    insert into KHOAHOC 
        values('K001','Khóa 1',TO_DATE('2020-01-10', 'yyyy-mm-dd'),TO_DATE('2020-03-20', 'yyyy-mm-dd'));
    insert into KHOAHOC 
        values('K002','Khóa 2',TO_DATE('2020-02-28', 'yyyy-mm-dd'),TO_DATE('2020-05-28', 'yyyy-mm-dd'));
    insert into KHOAHOC 
        values('K003','Khóa 3',TO_DATE('2020-04-10', 'yyyy-mm-dd'),TO_DATE('2020-07-20', 'yyyy-mm-dd'));
    insert into KHOAHOC 
        values('K004','Khóa 4',TO_DATE('2020-06-15', 'yyyy-mm-dd'),TO_DATE('2020-09-20', 'yyyy-mm-dd'));
end

--*Bảng CHUONGTRINH:
alter table CHUONGTRINH modify TENCT varchar(70);

begin
    insert into CHUONGTRINH 
        values('CT007','Chứng Chỉ Thi Tiếng Anh 6 Bậc(A1,B1,B2,C1)');
    insert into CHUONGTRINH 
        values('CT006','Chương Trình CamBridge');
    insert into CHUONGTRINH 
        values('CT005','Tiếng Anh IELTS');
    insert into CHUONGTRINH 
        values('CT004','Chương Trình TOEIC');
    insert into CHUONGTRINH 
        values('CT003','Tiếng Anh Luyện Kỹ Năng');
    insert into CHUONGTRINH 
        values('CT002','Tiếng Anh Trẻ Em');
    insert into CHUONGTRINH 
        values('CT001','Tiếng Anh Tổng Quát');
end

--*Bảng LOAILOP:
alter table LOAILOP modify TENLOAI varchar(50);

begin
    insert into LOAILOP 
        values('LL001','CT001','Tiếng Anh căn bản');
    insert into LOAILOP 
        values('LL002','CT001','Tiếng Anh A1');
    insert into LOAILOP 
        values('LL003','CT001','Tiếng Anh A2');
    insert into LOAILOP 
        values('LL004','CT001','Tiếng Anh B1');
    insert into LOAILOP 
        values('LL005','CT001','Tiếng Anh B2');
    insert into LOAILOP 
        values('LL006','CT001','Tiếng Anh C1');
end

--*Bảng LOP:
begin
    insert into LOP 
        values('L001','LL001','Lớp 1',30,'K001');
    insert into LOP 
        values('L002','LL001','Lớp 2',30,'K001');
    insert into LOP 
        values('L003','LL002','Lớp 1',25,'K001');
end

--*Bảng HOCVIEN:
begin
    insert into HOCVIEN 
        values('HV0001','Đỗ Bình An','1',to_date('2000-11-02','yyyy-mm-dd'),'917217036','Cờ Đỏ - Cần Thơ');
    insert into HOCVIEN 
        values('HV0002','Đỗ Gia Bảo','1',to_date('2001-12-02','yyyy-mm-dd'),'917217036','Ô Môn - Cần Thơ');
    insert into HOCVIEN 
        values('HV0003','Đỗ Phúc Vinh','1',to_date('2002-11-02','yyyy-mm-dd'),'917217036','Cù Lao Dung - Sóc Trăng');
    insert into HOCVIEN 
        values('HV0004','Thạch Chí Tâm','1',to_date('2000-01-02','yyyy-mm-dd'),'917217036','Châu Thành - An Giang');
    insert into HOCVIEN 
        values('HV0005','Lê Cẩm Giao','0',to_date('2000-11-05','yyyy-mm-dd'),'917217036','Phong Điền - Cần Thơ');
    insert into HOCVIEN 
        values('HV0006','Huỳnh Gia Bảo','1',to_date('2000-11-02','yyyy-mm-dd'),'917217036','Phong Điền - Cần Thơ');
end

--*Bảng PHIEUTHU:
begin
    insert into PHIEUTHU
        values('PT000002','HV0002','L001',to_date('2021-06-01','yyyy-mm-dd'),1350000);
    insert into PHIEUTHU
        values('PT000003','HV0003','L001',to_date('2021-06-01','yyyy-mm-dd'),1350000);
    insert into PHIEUTHU
        values('PT000004','HV0004','L001',to_date('2021-06-01','yyyy-mm-dd'),1350000);
    insert into PHIEUTHU
        values('PT000005','HV0005','L001',to_date('2021-06-01','yyyy-mm-dd'),1350000);
    insert into PHIEUTHU
        values('PT000006','HV0006','L001',to_date('2021-06-01','yyyy-mm-dd'),1350000);
    insert into PHIEUTHU
        values('PT000007','HV0001','L001',to_date('2021-06-01','yyyy-mm-dd'),1350000);
end

--Câu 3
--insert into PHIEUTHU
   --values('PT000008','HV0012','L001',to_date('2021-06-01','yyyy-mm-dd'),1350000);

--===>Không thêm được, vì giá trị khóa ngoại(HV0012) không có giá trị khóa chính phù hợp.

--Câu 4
--insert into LOP
  --  values('L004','LL002','Lớp 4',10,'K001');

--Không thêm được, vì sỉ số Lớp 4 chỉ có 10, không thỏa SISO>12.

--Câu 5
--delete from KHOAHOC where MAKH='K001';

--==>Không xóa được, vì khóa học K001 trong bảng cha (được tham chiếu bởi khóa ngoại), đang được sử dụng trong bảng con.

--Câu 6
--delete from KHOAHOC where MAKH='K002';

--==>Xóa được, vì khóa học K002 trong bảng cha không được sử dụng trong bảng con nào khác.

--Câu 7
UPDATE PHIEUTHU
SET THANHTIEN= 1350000-((10* 1350000)/100) 
WHERE SOPT = 'PT000001'

--Câu 8
--a)
UPDATE LOP
SET hocphi = 1350000
WHERE MALOAI = 'LL001';

--b)
UPDATE LOP
SET hocphi = 1650000
WHERE MALOAI = 'LL002';

--Câu 9
--*Bảng HOCVIEN_NAM:
create table hocvien_nam(
    mahv char(10) not null references hocvien(mahv),
    tenhv varchar(20) not null,
    sdt varchar(15) not null,
    ngaysinh date not null,
    diachi varchar(30) not null,
    primary key(mahv)
);

--Câu 10
insert into hocvien_nam(mahv,tenhv,sdt,ngaysinh,diachi)
select mahv,tenhv,sdt,ngaysinh,diachi
from HOCVIEN
where gioitinh = '1'

--Câu 11
drop table khoahoc

--==>Không xóa được, vì khóa chính trong bảng được tham chiếu bởi khóa ngoại.

--Câu 12
drop table hocvien_nam

--==>Xóa được, vì bảng không có khóa được tham chiếu.

--Câu 13
alter table monhoc modify tenmh varchar(100)