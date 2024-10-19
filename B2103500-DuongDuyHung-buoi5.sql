--1) Vẽ sơ đồ thông thương của các quan hệ
select * from khuvuc;
select * from phong;
select * from loai;
select * from may;
select * from phanmem;
select * from caidat;
--2) Loại của máy 'p8'
select idloai
from may
where idmay = 'p8';
--3) Tên của các phần mềm 'UNIX'
select tenpm
from phanmem
where idloai ='UNIX';
--4) Tên phòng, địa chỉ IP phòng, mã phòng của các máy loại 'UNIX' hoặc 'PCWS'
select p.tenphong , p.ip , p.mp
from may m join phong p on p.ip = m.ip
where idloai in ('UNIX', 'PXWS');
--5) Tên phòng, địa chỉ IP phòng, mã phòng của các máy loại 'UNIX' hoặc 'PCWS' ở
--khu vực '130.120.80', sắp xếp kết quả tăng dần theo mã phòng
select distinct p.tenphong , p.ip , p.mp
from may m join phong p on p.ip = m.ip
where idloai in ('UNIX', 'PXWS')
and p.ip = '130.120.80'
order by p.mp asc;
--6) Số các phần mềm được cài đặt trên máy 'p6'
select idmay ,count(idpm) So_phan_mem
from caidat where idmay = 'p6'
group by idmay;
--7) Số các máy đã cài phần mềm 'log1'
select idpm ,count(idmay) So_may_da_cai
from caidat where idpm = 'log1'
group by idpm;
--8) Tên và địa chỉ IP (ví dụ: 130.120.80.1) đầy đủ của các máy loại 'TX'
select tenmay , ip || '.' || ad
from may where idloai = 'TX';
--9) Tính số phần mềm đã cài đặt trên mỗi máy
select idmay, count(*) So_phan_mem
from caidat
group by idmay;
--10) Tính số máy mỗi phòng
select mp ,count(idmay)from may
group by mp order by mp ;

--11) Tính số cài lần cài đặt của mỗi phần mềm trên các máy khác nhau
select idpm, count(idmay) So_lan_cai 
from caidat group by idpm;
--12) Giá trung bình của các phần mềm UNIX
select idloai , avg(gia) Gia_trung_binh
from phanmem 
where idloai = 'UNIX'
group by idloai;
--13) Ngày mua phần mềm gần nhất
select max(ngaymua) Ngay_mua_gan_nhat
from phanmem;
--14) Số máy có ít nhất 2 phần mềm
select count(*)So_may_co_it_nhat_2PM
from (
select idmay, count(*) 
from caidat
group by idmay having count(*) >=2 )
;
--15) Tìm các loại không thuộc loại máy
select * from loai
where idloai not in (select idloai from may);

--16)Tìm các loại thuộc cả hai loại máy và loại phần mềm
select idloai from may
intersect
select idloai from phanmem;

--17)Tìm các loại máy không phải là loại phần mềm
select idloai from may
minus
select idloai from phanmem;
--18) Địa chỉ IP đầy đủ của các máy cài phần mềm 'log6'
select m.tenmay, m.ip || '.' || m.ad IP_DAY_DU
from may m join caidat cd on m.idmay = cd.idmay
where cd.idpm = 'log6';
--19) Địa chỉ IP đầy đủ của các máy cài phần mềm tên 'Oracle 8'
select m.tenmay, m.ip || '.' || m.ad IP_DAY_DU , pm.tenpm
from may m join caidat cd on m.idmay = cd.idmay join phanmem pm on pm.idpm = cd.idpm
where pm.tenpm = 'Oracle 8';
--20) Tên của các khu vực có chính xác 3 máy loại 'TX'
select kv.ip, kv.tenkhuvuc, count(*) So_may
from khuvuc kv, may m
where m.ip = kv.ip
and m.idloai = 'TX'
group by kv.ip , kv.tenkhuvuc
having count(*) = 3 ;

--21) Tên phòng có ít nhất một máy cài phần mềm tên 'Oracle 6'
select p.mp , p.tenphong
from caidat cd, phong p, phanmem pm , may m 
where pm.idpm = cd.idpm and m.idmay = cd.idmay and m.mp = p.mp
and pm.tenpm = 'Oracle 6'
group by p.mp, p.tenphong;
--22) Tên phần mềm được mua gần nhất
select tenpm from phanmem where ngaymua = (select max(ngaymua) from phanmem );

--23) Tên của phần mềm PCNT có giá lớn hơn bất kỳ giá của một phần mềm UNIX
--nào
select tenpm , gia
from phanmem
where idloai = 'PCNT'
and gia > ANY (select gia from phanmem where idloai = 'UNIX');
--24) Tên của phần mềm UNIX có giá lớn hơn tất cả các giá của các phần mềm PCNT
select tenpm , gia
from phanmem
where idloai = 'UNIX'
and gia > ALL (select gia from phanmem where idloai = 'PCNT');

--25) Tên của máy có ít nhất một phần mềm chung với máy 'p6'
select distinct m.tenmay
from caidat cd, may m 
where cd.idmay = m.idmay and cd.idpm in(select idpm from caidat where idmay = 'p6')
and cd.idmay <> 'p6';
--26) Tên của các máy có cùng phần mềm như máy 'p6' (có thể nhiều phần mềm hơn
--máy 'p6')
select cd.idmay
from caidat join( select idpm from caidat where idmay = 'p6') c1 on cd.idpm = c1.idpm
where idmay <> 'p6'
group by cd.idmay 
having coun(*) = (select count(idmay) from caidat where idmay = 'p6');

--27) Tên của các máy có chính xác các phần mềm như máy 'p2' 
select cd.idmay
from caidat join( select idpm from caidat where idmay = 'p2') c1 on cd.idpm = c1.idpm
where idmay <> 'p2'
group by cd.idmay 
having coun(*) = (select count(idmay) from caidat where idmay = 'p2');