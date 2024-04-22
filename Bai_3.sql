-- auto-generated definition
create database bai_3;
use bai_3;
create table KhachHang
(
    maKh     varchar(4) primary key not null,
    tenKh    varchar(30)            not null,
    diachi   varchar(50),
    ngaysinh datetime,
    sodt     varchar(15) unique
);
create table NhanVien
(
    manv       varchar(4)  not null primary key,
    hoten      varchar(30) not null,
    gioitinh   bit         not null,
    diachi     varchar(50) not null,
    ngaysinh   datetime    not null,
    dienthoai  varchar(15),
    email      text,
    noisinh    varchar(20) not null,
    ngayvaolam datetime,
    maNQL      varchar(4)  not null
);
create table NhaCungCap
(
    maNCC     varchar(5)  not null primary key,
    tenNcc    varchar(50) not null,
    diachi    varchar(50) not null,
    dienthoai varchar(15) not null,
    email     varchar(30) not null,
    website   varchar(30)
);
create table LoaiSP
(
    maloaiSP  varchar(4)   not null primary key,
    tenloaiSP varchar(30)  not null,
    ghichu    varchar(100) not null
);
create table SanPham
(
    maSP      varchar(4)  not null primary key,
    maloaiSP  varchar(4)  not null,
    tenSP     varchar(50) not null,
    donvitinh varchar(10) not null,
    ghichu    varchar(100)
);
create table PhieuNhap
(
    soPN     varchar(5) not null primary key,
    maNV     varchar(4) not null,
    maNCC    varchar(5) not null,
    ngaynhap datetime   not null,
    ghichu   varchar(100)
);
create table CtPhieuNhap
(
    maSP    varchar(4) not null,
    soPN    varchar(5) not null,
    primary key (maSP, soPN),
    soluong smallint   not null default (0),
    gianhap decimal    not null check ( gianhap >= 0 )
);
create table PhieuXuat
(
    soPX    varchar(5) not null primary key,
    maNv    varchar(4) not null,
    maKh    varchar(4) not null,
    ngayban datetime   not null,
    ghichu  text
);
create table CtPhieuXuat
(
    soPX    varchar(5),
    maSP    varchar(4),
    primary key (soPX, maSP),
    soluong smallint not null,
    giaban  decimal  not null check ( giaban > 0 )
);
#Bài 2: Dùng câu lệnh ALTER để thêm rằng buộc khóa ngoại cho các bảng
alter table PhieuNhap
    add foreign key (maNCC) references NhaCungCap (maNCC),
    add foreign key (maNV) references NhanVien (manv);

alter table CtPhieuNhap
    add foreign key (soPN) references PhieuNhap (soPN),
    add foreign key (maSP) references SanPham (maSP);

alter table SanPham
    add foreign key (maloaiSP) references LoaiSP (maloaiSP);

alter table CtPhieuXuat
    add foreign key (maSP) references SanPham (maSP),
    add foreign key (soPX) references PhieuXuat (soPX);

alter table PhieuXuat
    add foreign key (maKh) references KhachHang (maKh);
alter table PhieuNhap
    modify ngaynhap date;
alter table NhanVien
    modify ngaysinh date;

#Bài 3: Dùng lệnh INSERT thêm dữ liệu vào các bảng:

insert into NhaCungCap (maNCC, tenNcc, diachi, dienthoai, email, website)
VALUES ('N01', 'ncc1', 'dcncc1', 'sdt1', 'email1', 'link1'),
       ('N02', 'ncc2', 'dcncc2', 'sdt2', 'email2', 'link2');
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV1', 'nv1', 1, 'dcnv1', '2000-11-11', '0988765432', 'emailnv1', 'HN', curdate(),
        'NQL1'),
       ('NV2', 'nv2', 0, 'dcnv2', '1999-11-12', '0988777666', 'emailnv2', 'TB', curdate(),
        'NQL2');

insert into LoaiSP (maloaiSP, tenloaiSP, ghichu)
VALUES ('lsp1', 'quan', 'ghichu1');
insert into SanPham (maSP, maloaiSP, tenSP, donvitinh, ghichu)
VALUES ('SP1', 'lsp1', 'tensanpham1', 'cai', 'ghichu1'),
       ('SP2', 'lsp1', 'tensanpham2', 'cai', 'ghichu2'),
       ('SP3', 'lsp1', 'tensanpham3', 'cai', 'ghichu3'),
       ('SP4', 'lsp1', 'tensanpham4', 'cai', 'ghichu4'),
       ('SP5', 'lsp1', 'tensanpham5', 'cai', 'ghichu5');

insert into PhieuNhap (soPN, maNV, maNCC, ngaynhap, ghichu)
VALUES ('PN01', 'NV1', 'N01', current_date, 'ghichuphieunhap1'),
       ('PN02', 'NV2', 'N02', current_date, 'ghichuphieunhap2');
insert into CtPhieuNhap (maSP, soPN, soluong, gianhap)
VALUES ('SP1', 'PN01', 2, 1.1),
       ('SP2', 'PN01', 5, 2.2),
       ('SP3', 'PN02', 3, 3.3),
       ('SP4', 'PN02', 4, 4.44);

insert into KhachHang (maKh, tenKh, diachi, ngaysinh, sodt)
VALUES ('kh1', 'khachhang1', 'diachiKH1', '2000-12-20', '0988111222'),
       ('kh2', 'khachhang2', 'diachiKH2', '1999-1-2', '0988333444');
insert into PhieuXuat (soPX, maNv, maKh, ngayban, ghichu)
VALUES ('PX1', 'NV1', 'KH1', curdate(), 'ghichu1'),
       ('px2', 'nv2', 'kH2', CURRENT_DATE, 'ghichu2');
insert into CtPhieuXuat (soPX, maSP, soluong, giaban)
VALUES ('px1', 'sp1', 3, 1.11),
       ('px1', 'sp2', 4, 2.22),
       ('px1', 'sp3', 5, 3.33),
       ('px2', 'sp2', 1, 4.44),
       ('px2', 'sp3', 6, 5.55),
       ('px2', 'sp4', 4, 6.2);
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV3', 'nv3', 1, 'dcnv3', '1999-10-10', '0988999888', 'emailnv3', 'HN', curdate(),
        'NQL1');

# Bài 4: Dùng lệnh UPDATE cập nhật dữ liệu các bảng
# 1. Cập nhật lại số điện thoại mới cho khách hàng mã KH2. (Tùy chọn các
# thông tin liên quan)
# 2. Cập nhật lại địa chỉ mới của nhân viên mã NV3 (Tùy chọn các thông tin
# liên quan)
-- Cập nhật số điện thoại mới cho khách hàng mã KH2
update KhachHang
set sodt = '0987654321'
where maKh = 'KH2';

-- Cập nhật địa chỉ mới của nhân viên mã NV3
update NhanVien
set diachi = 'Update3'
where manv = 'NV3';
# Bài 5: Dùng lệnh DELETE xóa dữ liệu các bảng
#                      1. Xóa nhân viên mới vừa thêm tại yêu cầu C.3
#                      2. Xóa sản phẩm mã SP15
-- Xóa nhân viên mới vừa thêm tại yêu cầu C.3
delete from Nhanvien
where manv = 'NV3';

-- Xóa sản phẩm mã SP
delete from SanPham
where maSP = 'SP5';
#Bài 6: Dùng lệnh SELECT lấy dữ liệu từ các bảng
#Liệt kê thông tin về nhân viên trong cửa hàng, gồm: mã nhân viên, họ tên
#theo tuổi.
select
    manv as 'mã nhân viên',
    hoten as 'họ tên nhân viên',
    case
        when gioitinh = 1 then 'nam'
        else 'nữ'
        end as 'giới tính',
    ngaysinh as 'ngày sinh',
    diachi as 'địa chỉ',
    dienthoai as 'số điện thoại',
    year(curdate()) - year(ngaysinh) as 'tuổi'
from
    nhanvien
order by
    ngaysinh;


# 6. Liệt kê chi tiết hóa đơn bán hàng trong 6 tháng đầu năm 2018 gồm thông tin:
# số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm,
# đơn vị tính, số lượng, giá bán, doanh thu.
select px.soPX,
       nv.hoten,
       px.ngayban,
       sp.maSP,
       sp.tenSP,
       sp.donvitinh,
       cpx.soluong,
       cpx.giaban,
       cpx.soluong * cpx.giaban as doanhthu
from phieuxuat px
         join nhanvien nv on px.maNv = nv.manv
         join ctphieuxuat cpx on cpx.soPX = px.soPX
         join sanpham sp on sp.maSP = cpx.maSP;
# 7. Hãy in danh sách khách hàng có ngày sinh nhật trong tháng hiện hành (gồm
# tất cả thông tin của khách hàng)
select *from khachhang kh
where month(date(kh.ngaysinh)) = month(curdate());
# 8. Liệt kê các hóa đơn bán hàng từ ngày 15/04/2018 đến 15/05/2018 gồm các
# thông tin: số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên
# sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu
insert
into PhieuXuat (soPX, maNv, maKh, ngayban, ghichu)
VALUES ('PX003', 'NV01', 'KH01', '2018-04-30', 'ghichuphieuxuat1'),
       ('px004', 'nv02', 'kH02', '2018-05-14', 'ghichuphieuxuat2');
insert into CtPhieuXuat (soPX, maSP, soluong, giaban)
VALUES ('px003', 'sp02', 3, 2.55),
       ('px003', 'sp01', 4, 3.55),
       ('px003', 'sp04', 5, 4.56),
       ('px004', 'sp01', 1, 10.55),
       ('px004', 'sp04', 6, 1.55),
       ('px004', 'sp02', 4, 7.2);
select px.soPX,
       px.maNv,
       px.ngayban,
       CPX.maSP,
       sp.tenSP,
       sp.donvitinh,
       CPX.soluong,
       CPX.giaban,
       (CPX.soluong * CPX.giaban) as doanhthu
from PhieuXuat px
         join CtPhieuXuat CPX on px.soPX = CPX.soPX
         join SanPham SP on CPX.maSP = SP.maSP
where px.ngayban >= date('2018-04-15')
  and px.ngayban <= date('2018-05-15');
# 9. Liệt kê các hóa đơn mua hàng theo từng khách hàng, gồm các thông tin: số
# phiếu xuất, ngày bán, mã khách hàng, tên khách hàng, trị giá.
select px.soPX,
       px.ngayban,
       px.maKh,
       kh.tenKh,
       sum(cpx.giaban * cpx.soluong) as trigia
from PhieuXuat px
         join KhachHang KH on px.maKh = KH.maKh
         join ctphieuxuat cpx on cpx.soPX = px.soPX
group by px.soPX, kh.maKh
order by kh.maKh;
# 10. Cho biết tổng số chai nước xả vải Comfort đã bán trong 6 tháng đầu năm
# 2018. Thông tin hiển thị: tổng số lượng.
insert into LoaiSP (maloaiSP, tenloaiSP, ghichu)
VALUES ('lsp2', 'comfort', 'ghichucomfort');
insert into SanPham (maSP, maloaiSP, tenSP, donvitinh, ghichu)
VALUES ('SP05', 'lsp2', 'nuocxavai', 'chai', 'ghichunuocxavai');
insert into PhieuXuat (soPX, maNv, maKh, ngayban, ghichu)
VALUES ('PX005', 'NV01', 'KH01', '2018-04-30', 'ghichuphieuxuat1'),
       ('px006', 'nv02', 'kH02', '2018-07-28', 'ghichuphieuxuat2');
insert into CtPhieuXuat (soPX, maSP, soluong, giaban)
VALUES ('px005', 'sp05', 3, 2.55),
       ('px006', 'sp05', 4, 7.2);
select cpx.soluong as Tongsoluong
from ctphieuxuat cpx
         join phieuxuat px on px.soPX = cpx.soPX
where px.ngayban <= date('2018-06-30')
  and cpx.maSP = 'sp05';
# 11.Tổng kết doanh thu theo từng khách hàng theo tháng, gồm các thông tin:
# tháng, mã khách hàng, tên khách hàng, địa chỉ, tổng tiền.
select month(px.ngayban)             as 'Month',
       kh.maKh,
       kh.tenKh,
       kh.diachi,
       sum(cpx.soluong * cpx.giaban) as 'Total revenue'
from khachhang kh
         join phieuxuat px on px.maKh = kh.maKh
         join ctphieuxuat cpx on px.soPX = cpx.soPX
group by month(px.ngayban), kh.maKh;
# 12.Thống kê tổng số lượng sản phẩm đã bán theo từng tháng trong năm, gồm
# thông tin: năm, tháng, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số
# lượng.
select year(px.ngayban) as 'Year',
       month(px.ngayban)   'Month',
       sp.maSP,
       sp.tenSP,
       sp.donvitinh,
       sum(cpx.soluong)    'Tong so'
from SanPham sp
         join phieuxuat px
         join ctphieuxuat cpx on cpx.maSP = sp.maSP
group by year(px.ngayban), month(px.ngayban), sp.maSP;
# 13.Thống kê doanh thu bán hàng trong trong 6 tháng đầu năm 2018, thông tin
# hiển thị gồm: tháng, doanh thu
select year(px.ngayban) as nam, month(px.ngayban) as thang, sum(cpx.soluong * cpx.giaban) as doanhthu
from ctphieuxuat cpx
         join phieuxuat px on cpx.soPX = px.soPX
where date(px.ngayban) <= date('2018-06-30')
group by nam, thang;
# 14.Liệt kê các hóa đơn bán hàng của tháng 5 và tháng 6 năm 2018, gồm các
# thông tin: số phiếu, ngày bán, họ tên nhân viên bán hàng, họ tên khách hàng,
# tổng trị giá.
select px.soPX, px.ngayban, nv.hoten, kh.tenKh, sum(cpx.soluong * cpx.giaban) as 'Tong tri gia'
from phieuxuat px
         join khachhang kh on px.maKh = kh.maKh
         join nhanvien nv on px.maNv = nv.manv
         join ctphieuxuat cpx on cpx.soPX = px.soPX
where year(px.ngayban) = 2018
  and (month(px.ngayban) = 5 or month(px.ngayban) = 6)
group by year(px.ngayban), month(px.ngayban), px.soPX;
# 15.Cuối ngày, nhân viên tổng kết các hóa đơn bán hàng trong ngày, thông tin
# gồm: số phiếu xuất, mã khách hàng, tên khách hàng, họ tên nhân viên bán
# hàng, ngày bán, trị giá.
select px.soPX, kh.maKh, kh.tenKh, nv.hoten, px.ngayban, sum(cpx.giaban * cpx.soluong)
from phieuxuat px
         join khachhang kh on px.maKh = kh.maKh
         join ctphieuxuat cpx on cpx.soPX = px.soPX
         join nhanvien nv on nv.manv = px.maNv
where px.ngayban = current_date
group by px.soPX;
# 16.Thống kê doanh số bán hàng theo từng nhân viên, gồm thông tin: mã nhân
# viên, họ tên nhân viên, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số
# lượng.
select nv.manv, nv.hoten, sp.maSP, sp.tenSP, sp.donvitinh, sum(cpx.soluong)
from NhanVien nv
         join phieuxuat px on nv.manv = px.maNv
         join ctphieuxuat cpx on cpx.soPX = px.soPX
         join sanpham sp on sp.maSP = cpx.maSP
group by nv.manv, sp.maSP
order by nv.manv;
# 17.Liệt kê các hóa đơn bán hàng cho khách vãng lai (KH01) trong quý 2/2018,
# thông tin gồm số phiếu xuất, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị
# tính, số lượng, đơn giá, thành tiền.
select px.soPX,
       px.ngayban,
       sp.maSP,
       sp.tenSP,
       sp.donvitinh,
       sum(cpx.soluong)              as 'So luong',
       cpx.giaban,
       sum(cpx.soluong * cpx.giaban) as 'Thanh tien'
from phieuxuat px
         join ctphieuxuat cpx on px.soPX = cpx.soPX
         join sanpham sp on cpx.maSP = sp.maSP
         join khachhang kh on kh.maKh = px.maKh
where kh.maKh = 'kh01'
  and px.ngayban >= '2018-4-1'
  and px.ngayban <= '2018-6-30'
group by px.soPX, sp.maSP;
# 18.Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018, thông tin
# gồm: mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
select sp.maSP, sp.tenSP, LoaiSP.tenloaiSP, sp.donvitinh, px.ngayban
from sanpham sp
         join loaisp on sp.maloaiSP = LoaiSP.maloaiSP
         join ctphieuxuat cpx on cpx.maSP = sp.maSP
         join phieuxuat px on px.soPX = cpx.soPX
where not (date(px.ngayban) >= date('2018-01-01')
    and date(px.ngayban) <= date('2018-06-30'))
group by sp.maSP, LoaiSP.tenloaiSP, px.ngayban;
# 19.Liệt kê danh sách nhà cung cấp không giao dịch mua bán với cửa hàng trong
# quý 2/2018, gồm thông tin: mã nhà cung cấp, tên nhà cung cấp, địa chỉ, số
# điện thoại.
insert into nhacungcap (maNCC, tenNcc, diachi, dienthoai, email, website)
VALUES ('NCC03', 'Nhacungcap3', 'diachi3', 'dienthoai3', 'email3', 'website3');
select ncc.maNCC, ncc.tenNcc, ncc.diachi, ncc.dienthoai
from nhacungcap ncc
         left join phieunhap pn on pn.maNCC = ncc.maNCC
#Ngày nhập không nằm trong khoảng quý 2 thì là không có giao dịch mua bán
where (not date(pn.ngaynhap) <= '2018-6-30'
    and date(pn.ngaynhap) >= '2018-4-1')
#Mã nhà cung cấp không trùng với bất kì mã nào của phiếu nhập => Chưa từng có giao dịch
   or (ncc.maNCC not in (select PhieuNhap.maNCC from phieunhap));
# 20.Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong 6 tháng đầu năm
# 2018.
select kh.tenKh, max(cpx.soluong * cpx.giaban) as maxPurchase
from KhachHang kh
         join PhieuXuat PX on kh.maKh = PX.maKh
         join ctphieuxuat cpx on cpx.soPX = px.soPX
#Điều kiện về thời gian mua hàng
where date(px.ngayban) >= '2018-1-1'
  and date(px.ngayban) <= '2018-6-30'
#Vì có max nên cần group by. Sắp xếp theo thứ tự giảm dần của giá trị hàng hóa
#limit 1 sẽ là khách hàng đầu tiên có đơn mua cao nhất
group by kh.tenKh
order by maxPurchase desc
limit 1;
# 21.Cho biết mã khách hàng và số lượng đơn đặt hàng của mỗi khách hàng.
select px.maKh, count(px.maKh)
from phieuxuat px
group by px.maKh;
# 22.Cho biết mã nhân viên, tên nhân viên, tên khách hàng kể cả những nhân viên
# không đại diện bán hàng.
# Không có cách tránh sự lặp lại họ tên mã nhân viên vì duyệt nhiều lần??
select distinct nv.manv, nv.hoten, kh.tenKh
from nhanvien nv
         join khachhang kh;
# 23.Cho biết số lượng nhân viên nam, số lượng nhân viên nữ
#Cách 1
select case nv.gioitinh
           when 1 then 'nam'
           when 0 then 'nu'
           end as gioitinh,
       count(nv.gioitinh)
from nhanvien nv
group by nv.gioitinh;
#Cách 2
select if(nv.gioitinh, 'nam','nu'), count(nv.gioitinh)
from nhanvien nv
where nv.gioitinh = 1
union
select if(nv.gioitinh, 'nam','nu'), count(nv.gioitinh)
from nhanvien nv
where nv.gioitinh = 0;
# 24.Cho biết mã nhân viên, tên nhân viên, số năm làm việc của những nhân viên
# có thâm niên cao nhất.
insert into NhanVien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV04', 'nhanvien4', 1, 'diachinhanvien4', '1994-10-10', '0987654321', 'emailnhanvien4', 'hanoi', '2018-11-1',
        'NQL1');
select nv.manv, nv.hoten, max(timediff(year(current_date), year(nv.ngayvaolam)))
from nhanvien nv
group by manv;
# 25.Hãy cho biết họ tên của những nhân viên đã đến tuổi về hưu (nam:60 tuổi,
# nữ: 55 tuổi)
insert into nhanvien (manv, hoten, gioitinh, diachi, ngaysinh, dienthoai, email, noisinh, ngayvaolam, maNQL)
VALUES ('NV10', 'nhanvienvehuu', 1, 'diachi', '1950-1-1', 'dienthoai', 'email', 'noisinh', '2022-2-2', 'NQL1');
select nv.hoten,
       case nv.gioitinh
           when 1 then 'nam'
           when 0 then 'nu'
           end                             as gioitinh,
       year(curdate()) - year(nv.ngaysinh) as tuoinhanvien
from nhanvien nv
where (case
           when nv.gioitinh = 1 then year(curdate()) - year(nv.ngaysinh) >= 60
           else
               year(curdate()) - year(nv.ngaysinh) >= 55 end);
# 26.Hãy cho biết họ tên của nhân viên và năm về hưu của họ.
select nv.hoten,
       (case
            when nv.gioitinh = 1 then year(date_add(nv.ngaysinh, interval 60 year))
            else
                year(date_add(nv.ngaysinh, interval 55 year))
           end) as namvehuu
from nhanvien nv;
# 27.Cho biết tiền thưởng tết dương lịch của từng nhân viên. Biết rằng - thâm
# niên <1 năm thưởng 200.000 - 1 năm <= thâm niên < 3 năm thưởng
# 400.000 - 3 năm <= thâm niên < 5 năm thưởng 600.000 - 5 năm <= thâm
# niên < 10 năm thưởng 800.000 - thâm niên >= 10 năm thưởng 1.000.000
select nv.hoten,
       case
           when year(now()) - year(nv.ngayvaolam) < 1 then '200k'
           when year(now()) - year(nv.ngayvaolam) >= 1 and year(now()) - year(nv.ngayvaolam) < 3 then '400k'
           when year(now()) - year(nv.ngayvaolam) >= 3 and year(now()) - year(nv.ngayvaolam) < 5 then '600k'
           when year(now()) - year(nv.ngayvaolam) >= 5 and year(now()) - year(nv.ngayvaolam) < 10 then '800k'
           when year(now()) - year(nv.ngayvaolam) >= 10 then '1000k'
           end as thuong
from nhanvien nv;

# 28.Cho biết những sản phẩm thuộc ngành hàng Hóa mỹ phẩm
select sp.tenSP
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Mỹ phẩm';
# 29.Cho biết những sản phẩm thuộc loại Quần áo.
select sp.tenSP
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Quần áo';
# 30.Cho biết số lượng sản phẩm loại Quần áo.
select sp.tenSP, count(sp.maloaiSP)
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Quần áo'
group by sp.tenSP;
# 31.Cho biết số lượng loại sản phẩm ngành hàng Hóa mỹ phẩm.
select sp.tenSP, count(sp.maloaiSP)
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
where lsp.tenloaiSP = 'Mỹ phẩm'
group by sp.tenSP;
# 32.Cho biết số lượng sản phẩm theo từng loại sản phẩm.
select sp.tenSP, count(sp.maloaiSP)
from sanpham sp
         join loaisp lsp on sp.maloaiSP = lsp.maloaiSP
group by sp.tenSP;