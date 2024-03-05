--Truy vấn 1: Đếm xem mỗi nhân viên cho bao nhiêu độc giả mượn sách
SELECT NhanVien.ID_NhanVien, NhanVien.HoTen, SoLuongDocGia = COUNT(DISTINCT DocGia.ID_DocGia)
FROM NhanVien
JOIN MuonSach
ON NhanVien.ID_NhanVien = MuonSach.ID_NhanVien
JOIN DocGia
On DocGia.ID_DocGia = MuonSach.ID_DocGia
GROUP BY NhanVien.ID_NhanVien, NhanVien.HoTen
ORDER BY COUNT(DISTINCT DocGia.ID_DocGia) DESC

--Truy vấn 4: Liệt kê các nhân viên quê ở Hà nội thu phí độc giả vào ngày 2023-05-12
SELECT NhanVien.ID_NhanVien, NhanVien.HoTen, NhanVien.DiaChi
FROM NhanVien
JOIN ThuPhi
ON NhanVien.ID_NhanVien = ThuPhi.ID_NhanVien
WHERE ThuPhi.NgayThu= '2023-05-12'
AND NhanVien.DiaChi = 'Ha Noi'
ORDER BY NhanVien.HoTen

--Truy vấn 5: Liệt kê tổng số tiền lệ phí được thu bởi mỗi nhân viên theo thứ tự giảm dần 
SELECT NhanVien.ID_NhanVien, NhanVien.HoTen, TongTien = SUM(LePhi.TienLePhi)
FROM NhanVien
JOIN ThuPhi
ON NhanVien.ID_NhanVien = ThuPhi.ID_NhanVien
JOIN LePhi
ON ThuPhi.ID_LePhi = LePhi.ID_LePhi
GROUP BY NhanVien.ID_NhanVien, NhanVien.HoTen
ORDER BY SUM(LePhi.TienLePhi) DESC

--Truy vấn 7: Liệt kê tất cả các đầu sách được xuất bản vào ngày 2008-12-13 có chữ 'a' trong tên
SELECT DauSach.ID_DauSach, DauSach.TenDauSach, XuatBan.NgayXuatBan
FROM DauSach
JOIN XuatBan
ON DauSach.ID_DauSach = XuatBan.ID_DauSach
WHERE XuatBan.NgayXuatBan = '2008-12-13'
AND DauSach.TenDauSach LIKE '%a%'
ORDER BY DauSach.ID_DauSach

--Truy vấn 8: Tính tổng số sách thuộc mỗi thể loại
SELECT DauSach.TheLoai, SoLuong = SUM(NhapSach.SoLuong)
FROM DauSach
JOIN NhapSach
ON DauSach.ID_DauSach = NhapSach.ID_DauSach
GROUP BY DauSach.TheLoai
ORDER BY SUM(NhapSach.SoLuong) DESC

--Truy vấn 9: Tính tổng số tiền nhập sách vào ngày 2023-09-01
SELECT TongTien = SUM(NhapSach.SoLuong * DauSach.GiaTien)
FROM NhapSach
JOIN DauSach
ON NhapSach.ID_DauSach = DauSach.ID_DauSach
WHERE NhapSach.NgayNhap = '2023-09-01'

--Truy vấn 12: Liệt kê đầu sách có tên bắt đầu bằng chữ 'h' và có độc giả sinh năm 2001 mượn nhiều nhất
SELECT TOP 1 DauSach.ID_DauSach, DauSach.TenDauSach, SoLuongMuon = COUNT(DISTINCT MuonSach.ID_MuonSach)
FROM DauSach
JOIN Sach
ON DauSach.ID_DauSach = Sach.ID_DauSach
JOIN MuonSach 
ON MuonSach.ID_Sach = Sach.ID_Sach
JOIN DocGia
ON MuonSach.ID_DocGia = DocGia.ID_DocGia
WHERE DauSach.TenDauSach LIKE 'h%'
AND YEAR(DocGia.NgaySinh) = '2001'
GROUP BY DauSach.ID_DauSach, DauSach.TenDauSach

--Truy vấn 16: Liệt kê các độc giả mượn sách vào ngày 2023-05-30
SELECT DocGia.ID_DocGia, DocGia.HoTen
FROM DocGia
JOIN MuonSach
ON DocGia.ID_DocGia = MuonSach.ID_DocGia
WHERE MuonSach.NgayMuon = '2023-05-30'
GROUP BY DocGia.ID_DocGia, DocGia.HoTen
ORDER BY DocGia.ID_DocGia, DocGia.HoTen

--Truy vấn 17: Tính tổng lệ phí của mỗi độc giả trong tên có chữ 'h'
SELECT DocGia.ID_DocGia, DocGia.HoTen, TongLePhi = SUM(LePhi.TienLePhi)
FROM DocGia
JOIN ThuPhi
ON DocGia.ID_DocGia = ThuPhi.ID_DocGia
JOIN LePhi
ON ThuPhi.ID_LePhi = LePhi.ID_LePhi
WHERE DocGia.HoTen LIKE '%h%'
GROUP BY DocGia.ID_DocGia, DocGia.HoTen
ORDER BY SUM(LePhi.TienLePhi), DocGia.ID_DocGia, DocGia.HoTen

--Truy vấn 18: Liệt kê độc giả có tên có chữ 'h' và chỉ mượn sách vào ngày 2023-05-21
SELECT DocGia.ID_DocGia, DocGia.HoTen, NgayMuonSach = MAX(MuonSach.NgayMuon)
FROM DocGia
JOIN MuonSach
ON DocGia.ID_DocGia = MuonSach.ID_DocGia
WHERE DocGia.HoTen LIKE '%h%'
GROUP BY DocGia.ID_DocGia, DocGia.HoTen, MuonSach.NgayMuon
HAVING COUNT(DISTINCT NgayMuon) = 1
AND NgayMuon = '2023-05-21'

--Truy vấn 19: Hiển thị thông tin của tất cả độc giả sinh vào năm 2000 và mượn sách vào ngày '2023-05-19'
SELECT DocGia.ID_DocGia, DocGia.HoTen, DocGia.NgaySinh, MuonSach.NgayMuon
FROM DocGia
JOIN MuonSach
ON DocGia.ID_DocGia = MuonSach.ID_DocGia
WHERE MuonSach.NgayMuon = '2023-05-19'
AND YEAR(DocGia.NgaySinh) = 2000
GROUP BY DocGia.ID_DocGia, DocGia.HoTen, DocGia.NgaySinh, MuonSach.NgayMuon
ORDER BY DocGia.ID_DocGia, DocGia.HoTen

--Truy vấn 20: Liệt kê tất các độc giả mượn sách của NXB Sai Gon vào ngày 2023-05-13
SELECT DocGia.ID_DocGia, DocGia.HoTen, MuonSach.NgayMuon, NhaXuatBan.TenNXB
FROM DocGia
JOIN MuonSach
ON DocGia.ID_DocGia = MuonSach.ID_DocGia
JOIN Sach
ON MuonSach.ID_Sach = Sach.ID_Sach
JOIN DauSach
ON DauSach.ID_DauSach = Sach.ID_DauSach
JOIN XuatBan
ON XuatBan.ID_DauSach = DauSach.ID_DauSach
JOIN NhaXuatBan
ON XuatBan.ID_NXB = NhaXuatBan.ID_NXB
WHERE NhaXuatBan.TenNXB = 'Sai Gon'
AND MuonSach.NgayMuon = '2023-05-13'

--Truy vấn 21: Liệt kê tất cả độc giả có giới tính nam, dân tộc kinh bị thu phí vào ngày 2023-05-12
SELECT DocGia.ID_DocGia, DocGia.HoTen, DocGia.GioiTinh, DocGia.DanToc, ThuPhi.NgayThu
FROM DocGia
JOIN ThuPhi
ON DocGia.ID_DocGia = ThuPhi.ID_DocGia
WHERE DocGia.GioiTinh = 'Nam'
AND DocGia.DanToc = 'Kinh'
AND ThuPhi.NgayThu = '2023-05-12'

--Truy vấn 22: Liệt số lượng độc giả mà mỗi nhân viên thu phí theo thứ tự giảm dần về số lượng độc giả
SELECT NhanVien.ID_NhanVien, NhanVien.HoTen, SoLuongDocGia = COUNT(DISTINCT DocGia.ID_DocGia)
FROM NhanVien
JOIN ThuPhi
ON NhanVien.ID_NhanVien = ThuPhi.ID_NhanVien
JOIN DocGia
ON DocGia.ID_DocGia = ThuPhi.ID_DocGia
GROUP BY NhanVien.ID_NhanVien, NhanVien.HoTen
ORDER BY COUNT(DISTINCT DocGia.ID_DocGia) DESC

--Truy vấn 23: Liệt kê các độc giả bị phạt trên 30000 trong tên có chữ 'a'
SELECT DocGia.ID_DocGia, DocGia.HoTen, TongTienPhat = SUM(Loi.TienPhat)
FROM DocGia
JOIN Loi
ON DocGia.ID_DocGia = Loi.ID_DocGia
WHERE DocGia.HoTen LIKE '%a%'
GROUP BY DocGia.ID_DocGia, DocGia.HoTen
HAVING SUM(Loi.TienPhat) > 30000
ORDER BY SUM(Loi.TienPhat) DESC

--Truy vấn 24: Liệt kê tất cả độc giả được thu phí bởi nhân viên Tran Quy Dat
SELECT DocGia.ID_DocGia, DocGia.HoTen
FROM DocGia
JOIN ThuPhi
ON DocGia.ID_DocGia = ThuPhi.ID_DocGia
JOIN NhanVien
ON NhanVien.ID_NhanVien = ThuPhi.ID_NhanVien
WHERE NhanVien.HoTen = 'Tran Quy Dat'
GROUP BY DocGia.ID_DocGia, DocGia.HoTen
ORDER BY DocGia.ID_DocGia, DocGia.HoTen

--Truy vấn 26: Liệt kê số lượng đầu sách được dịch bởi mỗi dịch giả
SELECT DichGia.ID_DichGia, DichGia.HoTen, SoLuongDauSach = COUNT(DISTINCT DauSach.ID_DauSach)
FROM DichGia
JOIN DauSach
ON DichGia.ID_DauSach = DauSach.ID_DauSach
GROUP BY DichGia.ID_DichGia, DichGia.HoTen

--Truy vấn 28: Liệt kê tất cả đầu sách của tác giả 'David Lee'
SELECT DauSach.ID_DauSach, DauSach.TenDauSach
FROM DauSach
JOIN XuatBan
ON XuatBan.ID_DauSach = DauSach.ID_DauSach
JOIN TacGia
ON TacGia.ID_TacGia = XuatBan.ID_TacGia
WHERE TacGia.HoTen = 'David Lee'
GROUP BY DauSach.ID_DauSach, DauSach.TenDauSach
ORDER BY DauSach.ID_DauSach, DauSach.TenDauSach

--Truy vấn 29: Liệt kê số lượng đầu sách đã xuất bản của mỗi tác giả 
SELECT TacGia.ID_TacGia, TacGia.HoTen, SoLuong = COUNT(DISTINCT DauSach.ID_DauSach)
FROM DauSach
JOIN XuatBan
ON XuatBan.ID_DauSach = DauSach.ID_DauSach
JOIN TacGia
ON TacGia.ID_TacGia = XuatBan.ID_TacGia
GROUP BY TacGia.ID_TacGia, TacGia.HoTen
ORDER BY COUNT(DISTINCT DauSach.ID_DauSach) DESC

--Truy vấn 30: Liệt kê tất cả các đầu sách mà độc giả có ID DG07 đã mượn
SELECT DauSach.ID_DauSach, DauSach.TenDauSach
FROM DauSach
JOIN Sach
ON DauSach.ID_DauSach = Sach.ID_DauSach
JOIN MuonSach
ON MuonSach.ID_Sach = Sach.ID_Sach
JOIN DocGia
ON DocGia.ID_DocGia = MuonSach.ID_DocGia
WHERE DocGia.ID_DocGia = 'DG07'
GROUP BY DauSach.ID_DauSach, DauSach.TenDauSach
ORDER BY DauSach.ID_DauSach, DauSach.TenDauSach

--Truy vấn 31: Liệt kê tất cả số lượng đầu sách của nhà xuất bản Kim Dong được dịch bởi mỗi dịch giả 
SELECT DichGia.ID_DichGia, DichGia.HoTen, SoLuong = COUNT(DISTINCT DauSach.ID_DauSach)
FROM DichGia
JOIN DauSach
ON DichGia.ID_DauSach = DauSach.ID_DauSach
JOIN XuatBan
ON DauSach.ID_DauSach = XuatBan.ID_DauSach
JOIN NhaXuatBan
ON NhaXuatBan.ID_NXB = XuatBan.ID_NXB
WHERE NhaXuatBan.TenNXB = 'Kim Dong'
GROUP BY DichGia.ID_DichGia, DichGia.HoTen
ORDER BY COUNT(DISTINCT DauSach.ID_DauSach)

--Truy vấn 32: Liệt kê thông tin của nhà xuất bản có số lượng đầu sách nhiều nhất
SELECT TOP 1 NhaXuatBan.ID_NXB, NhaXuatBan.TenNXB, SoLuong = COUNT(DISTINCT DauSach.ID_DauSach)
FROM NhaXuatBan
JOIN XuatBan
ON NhaXuatBan.ID_NXB = XuatBan.ID_NXB
JOIN DauSach
ON DauSach.ID_DauSach = XuatBan.ID_DauSach
GROUP BY NhaXuatBan.ID_NXB, NhaXuatBan.TenNXB
ORDER BY [SoLuong] DESC

--Truy vấn 33: Liệt kê thông tin của nhà xuất bản có số lượng sách nhiều nhất
SELECT TOP 1 NhaXuatBan.ID_NXB, NhaXuatBan.TenNXB, SoLuong = SUM(NhapSach.SoLuong)
FROM NhaXuatBan 
JOIN XuatBan
ON XuatBan.ID_NXB = NhaXuatBan.ID_NXB
JOIN DauSach
ON XuatBan.ID_DauSach = DauSach.ID_DauSach
JOIN NhapSach
ON NhapSach.ID_DauSach = DauSach.ID_DauSach
GROUP BY NhaXuatBan.ID_NXB, NhaXuatBan.TenNXB
ORDER BY [SoLuong] DESC

--Truy vấn 33: Liệt kê tất cả các dịch giả trong tên có chữ 'a' dịch sách cho nhà xuất bản Kim đồng
SELECT DichGia.ID_DichGia, DichGia.HoTen
FROM DichGia
JOIN DauSach
ON DauSach.ID_DauSach = DichGia.ID_DauSach
JOIN XuatBan
ON XuatBan.ID_DauSach = DauSach.ID_DauSach
JOIN NhaXuatBan
ON NhaXuatBan.ID_NXB = XuatBan.ID_NXB
WHERE DichGia.HoTen LIKE '%a%'
AND NhaXuatBan.TenNXB = 'Kim Dong'
GROUP BY DichGia.ID_DichGia, DichGia.HoTen
ORDER BY DichGia.ID_DichGia, DichGia.HoTen

--Truy vấn 34: Liệt kê thông tin các độc giả sinh năm 1997 và không bị phạt bởi nhân viên nào
SELECT DocGia.ID_DocGia, DocGia.HoTen, NamSinh = YEAR(DocGia.NgaySinh)
FROM DocGia
LEFT JOIN Loi
ON DocGia.ID_DocGia = Loi.ID_DocGia
WHERE YEAR(DocGia.NgaySinh) = 1997
GROUP BY DocGia.ID_DocGia, DocGia.HoTen, YEAR(DocGia.NgaySinh)
HAVING COUNT(DISTINCT Loi.ID_NhanVien) = 0

--Truy vấn 35: Liệt kê tất cả những đầu sách không được mượn bởi độc giả nào
SELECT DauSach.ID_DauSach, DauSach.TenDauSach
FROM DauSach
JOIN Sach
ON DauSach.ID_DauSach = Sach.ID_DauSach
LEFT JOIN MuonSach
ON MuonSach.ID_Sach = Sach.ID_Sach
GROUP BY DauSach.ID_DauSach, DauSach.TenDauSach
HAVING COUNT(DISTINCT MuonSach.ID_DocGia) = 0

--Truy vấn 36: Liệt kê những nhân viên không phạt độc giả nào
SELECT NhanVien.ID_NhanVien, NhanVien.HoTen
FROM NhanVien
LEFT JOIN Loi
ON NhanVien.ID_NhanVien = Loi.ID_NhanVien
GROUP BY NhanVien.ID_NhanVien, NhanVien.HoTen
HAVING COUNT(DISTINCT Loi.ID_DocGia) = 0

--Truy vấn 37: Liệt kê những độc giả sinh năm 2002 và không bị thu phí bởi nhân viên Tran Quy Dat một lần nào
SELECT DISTINCT DocGia.ID_DocGia, DocGia.HoTen, DocGia.NgaySinh
FROM DocGia
JOIN ThuPhi
ON DocGia.ID_DocGia = ThuPhi.ID_DocGia
JOIN NhanVien
ON ThuPhi.ID_NhanVien = NhanVien.ID_NhanVien
WHERE YEAR(DocGia.NgaySinh) = 2002
AND DocGia.ID_DocGia NOT IN (
    SELECT DISTINCT TP2.ID_DocGia
    FROM ThuPhi TP2
    JOIN NhanVien NV2 ON TP2.ID_NhanVien = NV2.ID_NhanVien
    WHERE NV2.HoTen = 'Tran Quy Dat'
)

--Truy vấn 38: Liệt kê những đầu sách không được mượn bởi độc giả nào của nhà xuất bản Kim Dong
SELECT DauSach.ID_DauSach, DauSach.TenDauSach
FROM DauSach
LEFT JOIN Sach 
ON DauSach.ID_DauSach = Sach.ID_DauSach
LEFT JOIN MuonSach 
ON Sach.ID_Sach = MuonSach.ID_Sach
LEFT JOIN DocGia 
ON MuonSach.ID_DocGia = DocGia.ID_DocGia
LEFT JOIN XuatBan 
ON DauSach.ID_DauSach = XuatBan.ID_DauSach
LEFT JOIN NhaXuatBan 
ON XuatBan.ID_NXB = NhaXuatBan.ID_NXB
WHERE NhaXuatBan.TenNXB = 'Kim Dong' 
GROUP BY DauSach.ID_DauSach, DauSach.TenDauSach
HAVING COUNT(DocGia.ID_DocGia) = 0

--Truy vấn 39: Liệt kê những dịch giả sinh năm 2002 không dịch quyển sách nào cho nhà xuất bản Kim Dong
SELECT DichGia.ID_DichGia, DichGia.HoTen, DichGia.NgaySinh
FROM DichGia
WHERE YEAR(DichGia.NgaySinh) = 2002
AND DichGia.ID_DichGia NOT IN(
SELECT DichGia.ID_DichGia
FROM DichGia
JOIN DauSach
ON DichGia.ID_DauSach = DauSach.ID_DauSach
JOIN XuatBan
ON XuatBan.ID_DauSach = DauSach.ID_DauSach
JOIN NhaXuatBan
ON NhaXuatBan.ID_NXB = XuatBan.ID_NXB
WHERE NhaXuatBan.TenNXB = 'Kim Dong'
)

--Truy vấn 40: Liệt kê những dịch giả tên có chữ 'h' chỉ dịch duy nhất 1 đầu sách cho nhà xuất bản Kim Dong
SELECT DichGia.ID_DichGia, DichGia.HoTen
FROM DichGia
JOIN DauSach
ON DichGia.ID_DauSach = DauSach.ID_DauSach
JOIN XuatBan
ON XuatBan.ID_DauSach = DauSach.ID_DauSach
JOIN NhaXuatBan
ON NhaXuatBan.ID_NXB = XuatBan.ID_NXB
WHERE DichGia.HoTen LIKE '%h%'
AND NhaXuatBan.TenNXB = 'Kim Dong'
GROUP BY DichGia.ID_DichGia, DichGia.HoTen
HAVING COUNT(DISTINCT DichGia.ID_DauSach) = 1

--Truy vấn 41: Liệt kê những đầu sách không được dịch bởi dịch giả nào kèm số lượng mỗi đầu sách
SELECT DauSach.ID_DauSach, DauSach.TenDauSach, SoLuong = SUM(NhapSach.SoLuong)
FROM DichGia
RIGHT JOIN DauSach
ON DauSach.ID_DauSach = DichGia.ID_DauSach
JOIN NhapSach
ON NhapSach.ID_DauSach = DauSach.ID_DauSach
GROUP BY DauSach.ID_DauSach, DauSach.TenDauSach
HAVING COUNT(DISTINCT DichGia.ID_DichGia) = 0
ORDER BY [SoLuong] DESC

--Truy vấn 42: Liệt kê thông tin của những đầu sách thuộc thể loại 'Lap trinh' kèm số lượng sách mỗi loại
SELECT DauSach.TenDauSach, DauSach.TheLoai, DauSach.GiaTien, DauSach.SoTrang, SoLuong = COUNT(NhapSach.SoLuong)
FROM DauSach
JOIN NhapSach
ON DauSach.ID_DauSach = NhapSach.ID_DauSach
WHERE DauSach.TheLoai = 'Lap Trinh'
GROUP BY DauSach.TenDauSach, DauSach.TheLoai, DauSach.GiaTien, DauSach.SoTrang
ORDER BY [SoLuong]

--Truy vấn 43: Liệt kê thông tin nhân viên sinh năm 2002 chỉ nhập duy nhất một đầu sách vào ngày 2023-09-01
SELECT NhanVien.ID_NhanVien, NhanVien.HoTen, NamSinh = YEAR(NhanVien.NgaySinh), SachNhap = DauSach.TenDauSach, NhapSach.NgayNhap
FROM NhanVien
JOIN NhapSach
ON NhanVien.ID_NhanVien = NhapSach.ID_NhanVien
JOIN DauSach
ON DauSach.ID_DauSach = NhapSach.ID_DauSach
WHERE YEAR(NhanVien.NgaySinh) = 2002
AND NhapSach.NgayNhap = '2023-09-01'
GROUP BY NhanVien.ID_NhanVien, NhanVien.HoTen, YEAR(NhanVien.NgaySinh), DauSach.TenDauSach, NhapSach.NgayNhap
HAVING COUNT(DISTINCT NhapSach.ID_DauSach) = 1

--Truy vấn 44: Liệt kê những độc giả chỉ đóng duy nhất 1 khoản phí và bị thu bởi duy nhất 1 nhân viên
SELECT DocGia.ID_DocGia, DocGia.HoTen
FROM DocGia
JOIN ThuPhi
ON DocGia.ID_DocGia = ThuPhi.ID_DocGia
JOIN NhanVien
ON NhanVien.ID_NhanVien = ThuPhi.ID_NhanVien
GROUP BY DocGia.ID_DocGia, DocGia.HoTen
HAVING COUNT(ThuPhi.ID_ThuPhi) = 1
AND COUNT(DISTINCT ThuPhi.ID_NhanVien) = 1

--Truy vấn 45: Liệt kê những độc giả sinh năm 2002 không bị phạt và phải nộp lệ phí >= 10000
SELECT DocGia.ID_DocGia, DocGia.HoTen, DocGia.NgaySinh, TongLePhi = SUM(LePhi.TienLePhi)
FROM DocGia
LEFT JOIN Loi
ON DocGia.ID_DocGia = Loi.ID_DocGia
JOIN ThuPhi
ON ThuPhi.ID_DocGia = DocGia.ID_DocGia
JOIN LePhi
ON LePhi.ID_LePhi = ThuPhi.ID_LePhi
WHERE YEAR(DocGia.NgaySinh) = 2002
GROUP BY DocGia.ID_DocGia, DocGia.HoTen, DocGia.NgaySinh
HAVING COUNT(Loi.ID_Loi) = 0
AND SUM(LePhi.TienLePhi) >= 10000

--Truy vấn 46: Đếm số lượng các đầu sách mà mỗi độc giả đã mượn và tên độc giả không có chữ 'h'
SELECT DocGia.ID_DocGia, DocGia.HoTen, SoLuong = COUNT(DISTINCT DauSach.ID_DauSach)
FROM DocGia
JOIN MuonSach
ON DocGia.ID_DocGia = MuonSach.ID_DocGia
JOIN Sach
ON Sach.ID_Sach = MuonSach.ID_Sach
JOIN DauSach
ON DauSach.ID_DauSach = Sach.ID_DauSach
WHERE DocGia.HoTen NOT LIKE '%h%'
GROUP BY DocGia.ID_DocGia, DocGia.HoTen
ORDER BY [SoLuong] DESC

--Truy vấn 47: Liệt kê những độc giả sinh năm 1995 không mượn quyển sách nào và phải nộp lệ phí >= 50000
SELECT DocGia.ID_DocGia, DocGia.HoTen, NamSinh = YEAR(DocGia.NgaySinh), TongLePhi = SUM(LePhi.TienLePhi)
FROM DocGia
LEFT JOIN MuonSach
ON DocGia.ID_DocGia = MuonSach.ID_MuonSach
LEFT JOIN ThuPhi
ON DocGia.ID_DocGia = ThuPhi.ID_DocGia
LEFT JOIN LePhi
ON LePhi.ID_LePhi = ThuPhi.ID_LePhi
WHERE YEAR(DocGia.NgaySinh) = 1995
GROUP BY DocGia.ID_DocGia, DocGia.HoTen, YEAR(DocGia.NgaySinh)
HAVING SUM(LePhi.TienLePhi) >= 50000
AND COUNT(MuonSach.ID_MuonSach) = 0

--Truy vấn 48: Liệt kê những nhà xuất bản không có dịch giả nào và xuất bản nhiều hơn 2 đầu sách
--Không có dữ liệu
SELECT NhaXuatBan.ID_NXB, NhaXuatBan.TenNXB
FROM NhaXuatBan
LEFT JOIN XuatBan
ON NhaXuatBan.ID_NXB = XuatBan.ID_NXB
LEFT JOIN DauSach
ON DauSach.ID_DauSach = XuatBan.ID_DauSach
LEFT JOIN DichGia
ON DichGia.ID_DauSach = DauSach.ID_DauSach
GROUP BY NhaXuatBan.ID_NXB, NhaXuatBan.TenNXB
HAVING COUNT(DISTINCT DichGia.ID_DichGia) = 0
AND COUNT(DISTINCT XuatBan.ID_DauSach) > 2

--Truy vấn 49: Liệt kê những nhân viên không nhập đầu sách nào và có chữ 'a' trong tên
--Không có dữ liệu
SELECT NhanVien.ID_NhanVien, NhanVien.HoTen
FROM NhanVien
LEFT JOIN NhapSach
ON NhanVien.ID_NhanVien = NhapSach.ID_NhanVien
LEFT JOIN DauSach
ON DauSach.ID_DauSach = NhapSach.ID_DauSach
WHERE NhanVien.HoTen LIKE '%a%'
GROUP BY NhanVien.ID_NhanVien, NhanVien.HoTen
HAVING COUNT(NhapSach.ID_NhapSach) = 0

--Truy vấn 50: Liệt kê những nhân viên sinh năm 2000 quê ở 'Ho Chi Minh' không phạt độc giả nào 
SELECT NhanVien.HoTen, NhanVien.NgaySinh, NhanVien.DiaChi
FROM NhanVien
LEFT JOIN Loi
ON NhanVien.ID_NhanVien = Loi.ID_NhanVien
WHERE YEAR(NhanVien.NgaySinh) = 2000
AND NhanVien.DiaChi = 'Ho Chi Minh'
GROUP BY NhanVien.HoTen, NhanVien.NgaySinh, NhanVien.DiaChi
HAVING COUNT(Loi.ID_Loi) = 0

--Truy vấn 51: Liệt kê những đầu sách không được nhập bởi nhân viên 'Tran Quy Dat' và số lượng
SELECT DISTINCT DauSach.ID_DauSach, DauSach.TenDauSach, NhanVien.ID_NhanVien, NhanVien.HoTen, SoLuong = NhapSach.SoLuong
FROM DauSach
JOIN NhapSach
ON DauSach.ID_DauSach = NhapSach.ID_DauSach
JOIN NhanVien
ON NhanVien.ID_NhanVien = NhapSach.ID_NhanVien
WHERE DauSach.ID_DauSach NOT IN(
SELECT DISTINCT DauSach.ID_DauSach
FROM DauSach
JOIN NhapSach
ON DauSach.ID_DauSach = NhapSach.ID_DauSach
JOIN NhanVien
ON NhanVien.ID_NhanVien = NhapSach.ID_NhanVien
WHERE NhanVien.HoTen = 'Tran Quy Dat'
)
ORDER BY [SoLuong] DESC

--Truy vấn 52: Liệt kê những độc giả sinh năm 2002 không bị phạt bởi nhân viên 'Tran Quy Dat'
SELECT DISTINCT DocGia.Hoten, DocGia.ID_DocGia, NhanVien.ID_NhanVien AS 'ID Nhan Vien phat', NhanVien.HoTen AS 'Ho Ten Nhan Vien phat'
FROM DocGia
JOIN Loi
ON Loi.ID_DocGia = DocGia.ID_DocGia
JOIN NhanVien
ON NhanVien.ID_NhanVien = Loi.ID_NhanVien
WHERE YEAR(DocGia.NgaySinh) = 2002
AND DocGia.ID_DocGia NOT IN (
SELECT DISTINCT DocGia.ID_DocGia
FROM DocGia
JOIN Loi
ON DocGia.ID_DocGia = Loi.ID_DocGia
JOIN NhanVien
ON NhanVien.ID_NhanVien = Loi.ID_NhanVien
WHERE NhanVien.HoTen = 'Tran Quy Dat'
)

--Truy vấn 53: Liệt kê những đầu sách không được xuất bản bởi Nha xuat ban Kim Dong và không được mượn bởi bất cứ độc giả nào
SELECT DauSach.ID_DauSach, DauSach.TenDauSach
FROM DauSach
LEFT JOIN Sach 
ON DauSach.ID_DauSach = Sach.ID_DauSach
LEFT JOIN MuonSach 
ON Sach.ID_Sach = MuonSach.ID_Sach
LEFT JOIN DocGia 
ON MuonSach.ID_DocGia = DocGia.ID_DocGia
LEFT JOIN XuatBan 
ON DauSach.ID_DauSach = XuatBan.ID_DauSach
LEFT JOIN NhaXuatBan 
ON XuatBan.ID_NXB = NhaXuatBan.ID_NXB
WHERE NhaXuatBan.TenNXB != 'Kim Dong' 
GROUP BY DauSach.ID_DauSach, DauSach.TenDauSach
HAVING COUNT(DocGia.ID_DocGia) = 0
