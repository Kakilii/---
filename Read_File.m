%%读取按照指定格式排布的文件。不能随便打开文件，不然会崩溃。
function [data,Known_Point,Unknown_Point] = Read_File(fileName)
    data = importdata(fileName);
    Known_Point = zeros(data(1,1),7); % 存储已知点的坐标的矩阵
    Unknown_Point = zeros(data(1,2),7); % 存储未知点的矩阵
       for i = 1:data(1,1)
        for j = 1:7
            Known_Point(i,j) = data(7*i+j - 5);
        end
       end % 为已知点矩阵赋值
    for i = 1:data(1,2)
        for j = 1:4
            Unknown_Point(i,j) = data(4*i+j+26);
        end
    end % 为未知点矩阵赋值
end