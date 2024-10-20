creata table khoahoc(
	makh char(6) primary key,
	tenkh varchar(20) not null,
	ngaybd date not null,
	ngay kt date not null,
	constraint kt check(ngaybd < ngaykt),
);
create table chuongtrinh(
	mact char(6) primary key,
	tenct varchar(20) not null,
);

alter table chuongtrinh modify tenct varchar(50) not null;

create table loailop(
    maloai char(6) primary key,
    mact char(6) references chuongtrinh(mact),
    tenloat varchar(20) not null 
);
alter table loailop modify tenloat varchar(50);
create table lop(
    malop char(6) primary key,
    maloai char(6) not  null,
    siso smallint not null check (siso>12),
    makh char(6) references khoahoc(makh),
    constraint lopKN foreign key (maloai) references loailop(maloai)
);
alter table lop add tenlop varchar(20) not null;
create table hocvien(
    mahv char(6) primary key,
    tenhv varchar(20) not null,
    gioitinh char(1) check (gioitinh in ('0', '1')),
    ngaysinh date not null, 
    sdt char(10),
    diachi varchar(50)
);
create table phieuthu(
    sopt char(8) primary key, 
    mahv char(6) references hocvien(mahv),
    malop char(6) references lop(malop),
    ngaylapphieu date not null,
    thanhvien int check (thanhvien > 0) 
);
create table monhoc(
    mamh char(6) primary key, 
    tenmh varchar(20) not null
) ;

create table diem(
    mamh char(6) not null references monhoc(mamh),
    mahv char(6) not null references hocvien(mahv),
    malop char(6) not null references lop(malop),
    diem numeric(4,2) check(diem between 0 and 10 ),
    primary key(mamh, mahv, malop)
);
--C�u 2
--b?ng Kh�a H?c
INSERT INTO khoahoc (makh, tenkh , ngaybd, ngaykt )  VALUES ('K001', 'Kh�a 1' , '01/10/2020' , '03/20/2020' );
INSERT INTO khoahoc (makh, tenkh , ngaybd, ngaykt )  
VALUES ('K002', 'Kh�a 2' , '02/28/2020' , '05/28/2020' );
INSERT INTO khoahoc (makh, tenkh , ngaybd, ngaykt )  
VALUES ('K003', 'Kh�a 3' , '04/10/2020' , '07/20/2020' );
INSERT INTO khoahoc (makh, tenkh , ngaybd, ngaykt )  
VALUES ('K004', 'Kh�a 4' , '06/15/2020' , '09/20/2020' );
--Chuong tr�nh
INSERT INTO chuongtrinh (mact, tenct)
VALUES ('CT007', 'Ch?ng ch? Ti?ng Anh 6 B?c (A1,B1,B2,C1)');
INSERT INTO chuongtrinh (mact, tenct)
VALUES ('CT006', 'Chuong tr�nh CamBridge');
INSERT INTO chuongtrinh (mact, tenct)
VALUES ('CT005', 'Ti?ng Anh IELTS');
INSERT INTO chuongtrinh (mact, tenct)
VALUES ('CT004', 'Chuong tr�nh TOEIC');
INSERT INTO chuongtrinh (mact, tenct)
VALUES ('CT003', 'Ti?ng Anh Luy?n K? Nang');
INSERT INTO chuongtrinh (mact, tenct)
VALUES ('CT002', 'Ti?ng Anh Tr? Em');
INSERT INTO chuongtrinh (mact, tenct)
VALUES ('CT001', 'Ti?ng Anh T?ng Qu�t');
--lo?i l?p
INSERT INTO loailop (maloai, mact, tenloat)
VALUES ('LL001','CT001', 'Ti?ng Anh can b?n');
INSERT INTO loailop (maloai, mact, tenloat)
VALUES ('LL002','CT001', 'Ti?ng Anh A1');
INSERT INTO loailop (maloai, mact, tenloat)
VALUES ('LL003','CT001', 'Ti?ng Anh A2');
INSERT INTO loailop (maloai, mact, tenloat)
VALUES ('LL004','CT001', 'Ti?ng Anh B1');
INSERT INTO loailop (maloai, mact, tenloat)
VALUES ('LL005','CT001', 'Ti?ng Anh B2');
INSERT INTO loailop (maloai, mact, tenloat)
VALUES ('LL006','CT001', 'Ti?ng Anh C1');
--Lop
INSERT INTO lop (malop ,maloai, tenlop, siso, makh)
VALUES ('L001', 'LL001', 'L?p 1', 30, 'K001');
INSERT INTO lop (malop ,maloai, tenlop, siso, makh)
VALUES ('L002', 'LL001', 'L?p 2', 30, 'K001');
INSERT INTO lop (malop ,maloai, tenlop, siso, makh)
VALUES ('L003', 'LL002', 'L?p 1', 25, 'K001');
--HocVien
INSERT INTO hocvien(mahv, tenhv , gioitinh, ngaysinh, sdt , diachi)
VALUES ('HV0001','�? B�nh An', '1', '11/02/2000','917217036','C? �? - C?n Tho');
INSERT INTO hocvien(mahv, tenhv , gioitinh, ngaysinh, sdt , diachi)
VALUES ('HV0002','�? Gia B?o', '1', '12/02/2000','917217036','� M�n - C?n Tho');
INSERT INTO hocvien(mahv, tenhv , gioitinh, ngaysinh, sdt , diachi)
VALUES ('HV0003','�? Ph�c Vinh', '1', '11/02/2000','917217036','C� Lao Dung - S�c Trang');
INSERT INTO hocvien(mahv, tenhv , gioitinh, ngaysinh, sdt , diachi)
VALUES ('HV0004','Th?ch Ch� T�m', '1', '01/02/2000','917217036','Ch�u Th�nh - An Giang');
INSERT INTO hocvien(mahv, tenhv , gioitinh, ngaysinh, sdt , diachi)
VALUES ('HV0005','L� C?m Giao', '0', '11/05/2000','917217036','Phong �i?n - C?n Tho');
INSERT INTO hocvien(mahv, tenhv , gioitinh, ngaysinh, sdt , diachi)
VALUES ('HV0006','Hu?nh Gia B?o', '1', '11/02/2000','917217036','Phong �i?n - C?n Tho');
--phieuthu
INSERT INTO phieuthu(sopt, mahv, malop, ngaylapphieu, thanhvien)
VALUES ('PT000002', 'HV0002', 'L001', '06/01/2021', 1350000);
INSERT INTO phieuthu(sopt, mahv, malop, ngaylapphieu, thanhvien)
VALUES ('PT000003', 'HV0003', 'L001', '06/01/2021', 1350000);
INSERT INTO phieuthu(sopt, mahv, malop, ngaylapphieu, thanhvien)
VALUES ('PT000004', 'HV0004', 'L001', '06/01/2021', 1350000);
INSERT INTO phieuthu(sopt, mahv, malop, ngaylapphieu, thanhvien)
VALUES ('PT000005', 'HV0005', 'L001', '06/01/2021', 1350000);
INSERT INTO phieuthu(sopt, mahv, malop, ngaylapphieu, thanhvien)
VALUES ('PT000006', 'HV0006', 'L001', '06/01/2021', 1350000);