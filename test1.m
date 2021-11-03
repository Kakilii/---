%% 读取数据进入矩阵，以及设置内方位元素
[fileName,pathName] = uigetfile('*.*','Please select an image');%文件筐，选择文件
    fileName = strcat(pathName,fileName);
    [data,Known_Point,Unknown_Point] = Read_File(fileName);
    f = 0.15;
%% 计算外方位元素
    % 计算比例尺
    scale0 = 0;scale1 = 0;
    for i = 1:data(1,1)-1
    scale0 = dist(Known_Point(i,1),Known_Point(i+1,1),Known_Point(i,2),Known_Point(i+1,2))/(dist(Known_Point(i,5),Known_Point(i+1,5),Known_Point(i,6),Known_Point(i+1,6)))+scale0;
    scale1 = dist(Known_Point(i,3),Known_Point(i+1,3),Known_Point(i,4),Known_Point(i+1,4))/(dist(Known_Point(i,5),Known_Point(i+1,5),Known_Point(i,6),Known_Point(i+1,6)))+scale0;
    end
    scale0 = scale0/(data(1,1)-1);
    scale1 = scale1/(data(1,1)-1); 
    H0 = f/scale0*1000;
    H1 = f/scale1*1000;
    % 计算航高
%计算外方位元素
  [XS0,YS0,ZS0,a0,b0,c0] = Calculate_Initial_Value(data,Known_Point,1,f,H0);
  [XS1,YS1,ZS1,a1,b1,c1] = Calculate_Initial_Value(data,Known_Point,2,f,H1);
%% 构建左右片旋转矩阵
R0 = Compute_The_Rotation_Matrix(a0,b0,c0);
R1 = Compute_The_Rotation_Matrix(a1,b1,c1);
%% 计算基线分量
BX = XS1-XS0;BY = YS1-YS0;BZ = ZS1-ZS0;
%% 点投影计算
for i = 1:data(1,2)
    %计算像点在像辅系中的坐标
    [X0,Y0,Z0]=Calculate_The_Coordinate(Unknown_Point(i,1),Unknown_Point(i,2),f,a0,b0,c0);
    [X1,Y1,Z1]=Calculate_The_Coordinate(Unknown_Point(i,3),Unknown_Point(i,4),f,a1,b1,c1);
    %计算投影系数
    N0 = (BX*Z1-BZ*X1)/(X0*Z1-Z0*X1);
    N1 = (BX*Z0-BZ*X0)/(X0*Z1-Z0*X1);
    detX = N0*X0;
    detY = (N0*Y0+N1*Y1+BY)/2;
    detZ = N0*Z0;
    Unknown_Point(i,5) = XS0 + detX;
    Unknown_Point(i,6) = YS0 + detY;
    Unknown_Point(i,7) = ZS0 + detZ;
end



