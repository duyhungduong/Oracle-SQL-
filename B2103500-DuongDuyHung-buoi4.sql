--1. Tìm sự thông thương giữa các bảng trong CSDL
--2. Mở các bảng dữ liệu để xem kiểu dữ liệu của từng trường và quan sát dữ liệu của
--từng bảng
select * from cgtrinh;
select * from chunhan;
select * from chuthau;
select * from congnhan;
select * from ktrucsu;
select * from thamgia;
select * from thietke;

--3. Hãy cho biết thông tin về các kiến trúc sư có họ là Lê và sinh năm 1956
select *
from ktrucsu kts
where kts.hoten_kts like 'le_%'
and kts.nams_kts = 1956;
--4. Hãy cho biết tên các công trình bắt đầu trong khoảng 1/9/1994 đến 20/10/1994
select ten_ctr
from cgtrinh ct
where ct.ngay_bd between 'SEP-01-1994' and 'OCT-20-1994';
--5. Hãy cho biết tên và địa chỉ các công trình do chủ thầu ‘công ty xây dựng số 6’ thi
--công (chú ý: xem dữ liệu để lấy đúng tên công ty xây dựng số 6)
select ten_ctr , diachi_ctr
from cgtrinh
where ten_thau = 'cty xd so 6';

--6. Tìm tên và địa chỉ liên lạc của các chủ thầu thi công công trình ở Cần Thơ do kiến
--trúc sư Lê Kim Dung thiết kế
select distinct th.ten_thau, th.dchi_thau
from chuthau th join cgtrinh ctr on ctr.ten_thau = th.ten_thau
where tinh_thanh='can tho';

--7. Hãy cho biết nơi tốt nghiệp của các kiến trúc sư đã thiết kế công trình Khách sạn
--quốc tế ở Cần Thơ
select distinct tk.hoten_kts , kts.noi_tn
from cgtrinh ctr , ktrucsu kts, thietke tk
where ctr.stt_ctr = tk.stt_ctr
and kts.hoten_kts = tk.hoten_kts
and ctr.tinh_thanh = 'can tho';
--8. Cho biết họ tên, năm sinh và năm vào nghề của các công nhân có chuyên môn hàn
--hoặc điện đã tham gia các công trình mà chủ thầu Lê Văn Sơn đã trúng thầu
select cn.hoten_cn , cn.nams_cn , cn.nam_vao_n
from thamgia tg join congnhan cn on cn.hoten_cn = tg.hoten_cn join cgtrinh ctr on tg.stt_ctr = ctr.stt_ctr
where cn.ch_mon in ('han','dien')
and ctr.ten_thau ='le van son';
--9. Những công nhân nào đã bắt đầu tham gia sông trình Khách sạn Quốc tế ở Cần Thơ
--trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994
select th.hoten_cn, th.ngay_tgia, ctr.ten_ctr, ctr.tinh_thanh
from thamgia th , cgtrinh ctr 
where th.stt_ctr = ctr.stt_ctr 
and th.ngay_tgia between 'dec-15-1994' and 'dec-31-1994'
and ctr.ten_ctr = 'khach san quoc te' and ctr.tinh_thanh ='can tho';
--10. Cho biết họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP HCM và đã thiết
--kế ít nhất một công trình có kinh phí đầu tư trên 400 triệu đồng
select kts.hoten_kts , kts.nams_kts , kts.noi_tn
from cgtrinh ctr , thietke tk , ktrucsu kts
where ctr.stt_ctr = tk.stt_ctr
and kts.hoten_kts = tk.hoten_kts
and ctr.kinh_phi > 400
and kts.noi_tn ='tp hcm';
--11. Tìm họ tên và chuyên môn của các công nhân tham gia các công trình do kiến trúc
--sư Lê Thanh Tùng thiết kế
select cn.hoten_cn ,cn.ch_mon
from congnhan cn , thamgia tg, cgtrinh ctr, thietke tk
where tg.stt_ctr = ctr.stt_ctr
and cn.hoten_cn = tg.hoten_cn
and tk.stt_ctr = ctr.stt_ctr
and tk.hoten_kts = 'le thanh tung';
--12. Cho biết tên công trình có kinh phí cao nhất
select ten_ctr
from cgtrinh
where kinh_phi =(select max(kinh_phi) from cgtrinh) ;
--13. Cho biết họ tên kiến trúc sư trẻ tuổi nhất
select hoten_kts
from ktrucsu
where nams_kts = (select max(nams_kts)from ktrucsu);
--14. Tìm tổng kinh phí của các công trình theo từng chủ thầu
select ten_thau, sum(kinh_phi) tong_kinh_phi
from cgtrinh
group by ten_thau ;
--15. Tìm tên và địa chỉ những chủ thầu đã trúng thầu công trình có kinh phí thấp nhất
select ct.ten_thau , ct.dchi_thau
from cgtrinh ctr join chuthau ct on ct.ten_thau = ctr.ten_thau
where ctr.kinh_phi = (select min(kinh_phi) from cgtrinh);
--16. Cho biết họ tên các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25
--triệu
select tk.hoten_kts , sum(tk.thu_lao)
from cgtrinh ctr , thietke tk 
where ctr.stt_ctr = tk.stt_ctr
group by tk.hoten_kts
having sum(tk.thu_lao)> 25;
--17. Cho biết số lượng các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25
--triệu
select count(*) So_luong_kts_co_thu_lao_tren_25
from(
select tk.hoten_kts , sum(tk.thu_lao)
from cgtrinh ctr , thietke tk 
where ctr.stt_ctr = tk.stt_ctr
group by tk.hoten_kts
having sum(tk.thu_lao)> 25);
--18. Tính số công trình mà mỗi kiến trúc sư đã thiết kế
select tk.hoten_kts ,count(tk.stt_ctr) So_cong_trinh
from cgtrinh ctr, thietke tk 
where ctr.stt_ctr = tk.stt_ctr 
group by tk.hoten_kts;
--19. Tính tổng số công nhân đã tham gia mỗi công trình
select ctr.ten_ctr ,count(ctr.ten_ctr)
from cgtrinh ctr join thamgia tk on tk.stt_ctr = ctr.stt_ctr
group by  ctr.ten_ctr;
--20. Tìm tên và địa chỉ công trình có tổng số công nhân tham gia nhiều nhất
select ctr.stt_ctr ,ctr.ten_ctr
from cgtrinh ctr join thamgia tg on ctr.stt_ctr = tg.stt_ctr
group by ctr.stt_ctr ,ctr.ten_ctr having count(ctr.ten_ctr) = (
select max(count(ctr.ten_ctr))
from cgtrinh ctr join thamgia tk  on tk.stt_ctr = ctr.stt_ctr
group by  ctr.ten_ctr
);
--21. Cho biết tên các thành phố và kinh phí trung bình của các công trình của từng thành
--phố tương ứng
select ctr.tinh_thanh , avg(ctr.kinh_phi) Kinh_phi_TB
from cgtrinh ctr 
group by ctr.tinh_thanh;
--22. Cho biết tên và địa chỉ của các công trình mà công nhân Nguyễn Hồng Vân đang
--tham gia vào ngày 18/12/1994
select ctr.ten_ctr , ctr.diachi_ctr
from thamgia tg join cgtrinh ctr on tg.stt_ctr = ctr.stt_ctr
where 'dec-18-1994' BETWEEN tg.ngay_tgia and tg.ngay_tgia + tg.so_ngay
and tg.hoten_cn = 'nguyen hong van';
--23. Cho biết họ tên kiến trúc sư vừa thiết kế các công trình do Phòng dịch vụ Sở Xây
--dựng thi công, vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công
select DISTINCT tk.hoten_kts
from thietke tk , cgtrinh ctr 
where tk.stt_ctr = ctr.stt_ctr
and ctr.ten_thau = 'phong dich vu so xd'
intersect 
select DISTINCT tk.hoten_kts
from thietke tk , cgtrinh ctr 
where tk.stt_ctr = ctr.stt_ctr
and ctr.ten_thau = 'le van son';
--24. Cho biết họ tên các công nhân có tham gia các công trình ở Cần Thơ nhưng không
--tham gia công trình ở Vĩnh Long
select DISTINCT th.hoten_cn
from thamgia th join cgtrinh ctr on th.stt_ctr = ctr.stt_ctr
where ctr.tinh_thanh = 'can tho'
minus
select DISTINCT th.hoten_cn
from thamgia th join cgtrinh ctr on th.stt_ctr = ctr.stt_ctr
where ctr.tinh_thanh = 'vinh long';
--25. Cho biết tên của các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả
--các công trình do chủ thầu Phòng dịch vụ sở xây dựng thi công
select DISTINCT ten_thau
from cgtrinh 
where kinh_phi > ALL (select kinh_phi from cgtrinh where ten_thau = 'phong dich vu so xd');
--26. Cho biết họ tên các kiến trúc sư có thù lao thiết kế cho một công trình nào đó dưới
--giá trị trung bình thù lao thiết kế của các KTS.
select hoten_kts , thu_lao
from thietke
where thu_lao < (
select avg(thu_lao)
from thietke);
--27. Cho biết họ tên các công nhân có tổng số ngày tham gia vào các công trình lớn hơn
--tổng số ngày tham gia của công nhân Nguyễn Hồng Vân 
select hoten_cn ,sum(so_ngay) Tong_so_ngay
from thamgia
group by hoten_cn
having sum(so_ngay) > (select sum(so_ngay) from thamgia where hoten_cn = 'nguyen hong van');
--28. Cho biết họ tên công nhân có tham gia tất cả các công trình
select hoten_cn, count(DISTINCT stt_ctr) So_CTRinh_ThamGia
from thamgia
group by hoten_cn 
having count(DISTINCT stt_ctr) = (select count(*) from cgtrinh);
--29. Tìm các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
select DISTINCT ctr1.ten_thau ChuThau1, ctr2.ten_thau ChuThau2 , ctr1.tinh_thanh
from cgtrinh ctr1 join cgtrinh ctr2 on ctr1.tinh_thanh = ctr2.tinh_thanh
where ctr1.ten_thau > ctr2.ten_thau;

--30. Tìm các cặp tên của các công nhân có lamg việc chung với nhau trong ít nhất là hai
--công trình
select th1.hoten_cn ten_cn1 , th2.hoten_cn ten_cn2 
from thamgia th1 join thamgia th2 on th1.stt_ctr = th2.stt_ctr
where th1.hoten_cn > th2.hoten_cn group by th1.hoten_cn, th2.hoten_cn
having count(th1.stt_ctr) >=2 ;
