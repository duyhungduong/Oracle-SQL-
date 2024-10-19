-- 1. Thêm khóa chính cho các bảng đã cho
-- Đặt thuộc tính "ten" là khóa ngoài của bảng LUI_TOI và AN
-- Thêm ràng buộc giá>0 cho cột "gia" của bảng PHUC_VU

ALTER TABLE NGUOI_AN 
ADD CONSTRAINT PK_NGUOIAN 
PRIMARY KEY (ten);
ALTER TABLE LUI_TOI 
ADD CONSTRAINT PK_LUITOI 
PRIMARY KEY (ten , quanPizza);
ALTER TABLE AN ADD CONSTRAINT PK_AN PRIMARY KEY (ten , pizza);
ALTER TABLE PHUC_VU ADD CONSTRAINT PK_PHUCVU PRIMARY KEY (quanPizza , pizza , gia);

ALTER TABLE LUI_TOI
ADD CONSTRAINT FK_LUITOI_NGUOIAN
FOREIGN KEY (ten)
REFERENCES NGUOI_AN (ten);

ALTER TABLE AN
ADD CONSTRAINT FK_AN_NGUOIAN
FOREIGN KEY (ten)
REFERENCES NGUOI_AN (ten);

ALTER TABLE PHUC_VU 
ADD CONSTRAINT CK_PHUC_VU_GIA 
CHECK (gia > 0);

-- 2. Cho biết quán ‘Pizza Hut’ đã phục vụ các bánh pizza nào ?
select pizza from phuc_vu where QUANPIZZA = 'Pizza Hut' ;

-- 3. Danh sách các bánh pizza mà các quán có bán ?
select pizza
from phuc_vu
group by pizza ;
-- 4. Cho biết tên các quán có phục vụ các bánh pizza mà tên gồm chữ ‘m’
select distinct quanpizza from phuc_vu where pizza like '%m%';

-- 5. Tìm tên và tuổi của người ăn đã đến quán ‘Dominos’, sắp xếp kết quả giảm dần theo
-- tuổi?
select n.ten , n.tuoi  from lui_toi l join nguoi_an n on l.ten = n.ten
where quanpizza = 'Dominos' order by n.tuoi desc;
-- 6. Tìm tên quán pizza và số bánh pizza mà mỗi quán phục vụ ?
select quanpizza , count(pizza) So_banh_Pizza
from phuc_vu
group by quanpizza ;
-- 7. Tìm tên những quán pizza phục vụ pizza với giá cao nhất ?
select distinct quanpizza
from phuc_vu
where gia = (select max(gia) from phuc_vu);
-- 8. Tìm tên các quán có phục vụ ít nhất một bánh pizza mà “Ian” thích ăn ?
select distinct l.quanpizza
from an join lui_toi l on an.ten = l.ten 
where l.ten = 'Ian';

-- 9. Tìm tên các quán có phục vụ ít nhất một bánh mà “Eli” không thích ?
select distinct quanpizza from lui_toi l join an on an.ten = l.ten where an.pizza IN(
    select pizza from an 
    minus 
    select pizza from an where ten = 'Eli'
)
-- 10.Tìm tên các quán chỉ phục vụ các bánh mà “Eli” thích ?
SELECT DISTINCT LUI_TOI.quanPizza FROM LUI_TOI JOIN AN ON LUI_TOI.ten = AN.ten WHERE AN.pizza NOT IN (SELECT AN.pizza FROM AN JOIN NGUOI_AN ON AN.ten = NGUOI_AN.ten WHERE NGUOI_AN.ten = 'Eli') AND LUI_TOI.quanPizza NOT IN (SELECT LUI_TOI.quanPizza FROM LUI_TOI JOIN AN ON LUI_TOI.ten = AN.ten WHERE AN.pizza IN (SELECT AN.pizza FROM AN JOIN NGUOI_AN ON AN.ten = NGUOI_AN.ten WHERE NGUOI_AN.ten = 'Eli'));

-- 11.Tên quán có phục vụ bánh với giá lớn hơn tất cả bánh phục vụ bởi quán ‘New York
-- Pizza’
select distinct quanpizza from phuc_vu where gia > ALL (select gia from phuc_vu where quanpizza = 'New York Pizza');

-- 12.Tìm tên các quán chỉ phục vụ các bánh có giá nhỏ hơn 10 ?
select quanpizza from phuc_vu group by quanpizza having max(gia) < 10;

-- 13.Tìm tên bánh được phục vụ bởi quán ‘New York Pizza’ và quán ‘Dominos’
select pizza from phuc_vu where quanpizza = 'New York Pizza'
intersect
select pizza from phuc_vu where quanpizza = 'Dominos';

-- 14.Tìm tên bánh được phục vụ bởi quán ‘Little Caesars’ và không phục vụ bởi quán 'Pizza
-- Hut'
select pizza from phuc_vu where quanpizza = 'Little Caesars'
minus
select pizza from phuc_vu where quanpizza = 'Pizza Hut';
-- 15.Tìm tên các quán có phục vụ tất cả các loại bánh pizza?
select quanpizza from phuc_vu group by quanpizza 
having count(pizza) = (select max(count(pizza)) from phuc_vu group by quanpizza);
-- 16.Tên quán phục vụ ít nhất 2 bánh pizza mà ‘Gus’ thích ?
select p.quanpizza from an join phuc_vu p on p.pizza = an.pizza where an.ten = 'Gus'
group by p.quanpizza having count(ten) >= 2;

-- 17.Tìm tên các quán có phục vụ tất cả các bánh mà ‘Ian’ thích
select p.quanpizza from an join phuc_vu p on p.pizza = an.pizza where an.ten = 'Ian'
group by p.quanpizza having count(ten) = (select count(ten) from an where ten = 'Ian');
-- 18.Tên người ăn lui tới ít nhất 3 quán?
select ten , count(quanpizza)
from lui_toi group by ten 
having count(quanpizza) >= 3;

-- 19.Tính số loại pizza mà mỗi quán có bán ?
select quanpizza , count(pizza) 
from phuc_vu group by quanpizza;

-- 20.Tìm tên người ăn thích các bánh ít nhất là giống các bánh mà Hil thích ?
SELECT A.ten
FROM AN A
JOIN AN Hil ON A.pizza = Hil.pizza AND Hil.ten = 'Hil'
GROUP BY A.ten
HAVING COUNT(*) >= (SELECT COUNT(*) FROM AN WHERE ten = 'Hil');
