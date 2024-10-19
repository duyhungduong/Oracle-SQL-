--CÂU 1: XEM NỘI DUNG CỦA TẤT CẢ CÁC BẢNG DỮ LIỆU BẰNG LỆNH SELECT

SELECT *FROM KHOAHOC;
SELECT *FROM CHUONGTRINH;
SELECT *FROM LOAILOP;
SELECT *FROM LOP;
SELECT *FROM HOCVIEN;
SELECT *FROM PHIEUTHU;
SELECT *FROM MONHOC;
SELECT *FROM DIEM;

--CÂU 2: TÌM THÔNG VỀ CÁC HỌC VIÊN NAM

SELECT *FROM HOCVIEN WHERE GIOITINH = 1;

--CÂU 3: TÌM THÔNG TIN VỀ CÁC HỌC VIÊN CÓ ĐỊA CHỈ Ở CẦN THƠ

SELECT *FROM HOCVIEN WHERE diachi like '%Cần Thơ%';

--CÂU 4: TÌM THÔNG TIN VỀ CÁC LỚP HỌC CỦA KHÓA 1

SELECT L.* FROM LOP L, KHOAHOC KH, LOAILOP LL
WHERE L.MALOAI = LL.MALOAI
AND L.MAKH = KH.MAKH
AND KH.TENKH in 'Khóa 1';

--CÂU 5: TÌM MÃ VÀ HỌ TÊN HỌC VIÊN CÓ HỌC KHÓA 1

SELECT HV.MAHV, HV.TENHV FROM HOCVIEN HV, PHIEUTHU PT, LOP L, KHOAHOC KH
WHERE HV.MAHV = PT.MAHV 
AND PT.MALOP = L.MALOP
AND L.MAKH =KH.MAKH 
AND TENKH IN ('Khóa 1');

--CÂU 6: TÌM HỌ TÊN CÁC HỌC VIÊN CÓ BAO GỒM CHỮ 'ĐỖ'

SELECT TENHV FROM HOCVIEN WHERE TENHV LIKE '%Đỗ%';

--CÂU 7: TÌM THÔNG TIN CÁC HỌC VIÊN SINH NĂM 2000

SELECT * FROM HOCVIEN WHERE NGAYSINH LIKE '%2000%';

--CÂU 8: TÌM THÔNG TIN CỦA CÁC HỌC VIÊN SINH THÁNG 12 NĂM 2001

select * from hocvien
 where  ngaysinh between '2001-12-01' and '2001-12-31' ;

--CÂU 9: TÌM THÔNG TIN CÁC HỌC VIÊN SINH TỪ NĂM 1998 ĐẾN 2000

select * from hocvien
 where  ngaysinh between '1998-01-01' and '2000-12-31' ;

--CÂU 10: TÌM THÔNG TIN CÁC PHIẾU THU ĐƯỢC THỰC HIỆN TỪ NGÀY 5 ĐẾN NGÀY 10 THÁNG 6 NĂM 2021


select * from phieuthu
 where  ngaylapphieu between '2021-06-05' and '2021-06-10' ;

--CÂU 11: IN DANH SÁCH HỌC VIÊN LỚP 1 TIẾNG ANH CĂN BẢN

select hv.* from lop l,phieuthu pt,hocvien hv,loailop ll
where ll.maloai = l.maloai
and pt.mahv = hv.mahv
and pt.malop = l.malop
and l.tenlop ='Lớp 1'
and ll.tenloai in 'Tiếng Anh căn bản';

--CÂU 12: IN DANH SÁCH CÁC LỚP THUỘC CHƯƠNG TRÌNH TIẾNG ANH TỔNG QUÁT

select l.* from lop l,loailop ll
where ll.maloai = l.maloai
and ll.tenloai like '% Tiếng Anh tổng quát';

--CÂU 13: LIỆT KÊ THÔNG TIN TẤT CẢ CÁC PHIẾU THU CỦA LỚP 1 TIẾNG ANH A1

select pt.* from lop l,phieuthu pt,hocvien hv,loailop ll
where ll.maloai = l.maloai
and pt.mahv = hv.mahv
and pt.malop = l.malop
and l.tenlop ='Lớp 1'
and ll.tenloai in 'Tiếng Anh A1';


--CÂU 14: TÌM HỌ TÊN HỌC VIÊN, TÊN MÔN VÀ ĐIỂM THI CÁC MÔN CỦA CÁC HỌC VIÊN HỌC KHÓA 1

SELECT HV.TENHV, MH.TENMH,D.DIEM FROM HOCVIEN HV, MONHOC MH, DIEM D, KHOAHOC KH, LOP L
WHERE HV.MAHV =D.MAHV
AND MH.MAMH = D.MAMH
AND D.MALOP = L.MALOP
AND L.MAKH = KH.MAKH
AND KH.TENKH in ('Khóa 1');

--CÂU 15: CÓ TẤT CẢ BAO NHIÊU HỌC VIÊN.

SELECT COUNT(*) FROM HOCVIEN

--CÂU 16: LỚP 1 TIẾNG ANH CĂN BẢN CÓ BAO NHIÊU HỌC VIÊN

select count(hv.mahv) 
from lop l,phieuthu pt,loailop ll, hocvien hv
where ll.maloai = l.maloai
and hv.mahv = pt.mahv
and pt.malop = l.malop
and l.tenlop ='Lớp 1'
and ll.tenloai in 'Tiếng Anh căn bản';

--CÂU 17: TÍNH TỔNG SỐ TIỀN ĐÃ THU ĐƯỢC CỦA LỚP 2 TIẾNG ANH CĂN BẢN


select sum(pt.thanhtien) 
from lop l,phieuthu pt,loailop ll
where ll.maloai = l.maloai
and pt.malop = l.malop
and l.tenlop ='Lớp 2'
and ll.tenloai in 'Tiếng Anh căn bản';

--CÂU 18: TÍNH TỔNG SỐ TIỀN ĐÃ THU ĐƯỢC CỦA KHÓA 1

SELECT SUM(PT.THANHTIEN) FROM PHIEUTHU PT, KHOAHOC KH, LOP L
WHERE PT.MALOP = L.MALOP
AND L.MAKH = KH.MAKH
AND KH.TENKH = 'Khóa 1';


--CÂU 19: TÍNH ĐIỂM TRUNG BÌNH CỦA HỌC VIÊN 'ĐỖ GIA BẢO', SINH NGÀY 02/12/2001 HỌC LỚP 1, TIẾNG ANH CĂN BẢN

select avg(d.diem)
from diem d,hocvien hv,lop l
where d.mahv =hv.mahv
and   l.malop = d.malop
and   hv.tenhv in 'Ŀỗ Gia Bảo'
and   hv.ngaysinh in '2001-12-02'
and   l.tenlop= 'Lớp 1';

--CÂU 20: TÌM ĐIỂM LỚN NHẤT:
select max(diem)
from diem ;


