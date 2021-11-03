%%��ȡ����ָ����ʽ�Ų����ļ������������ļ�����Ȼ�������
function [data,Known_Point,Unknown_Point] = Read_File(fileName)
    data = importdata(fileName);
    Known_Point = zeros(data(1,1),7); % �洢��֪�������ľ���
    Unknown_Point = zeros(data(1,2),7); % �洢δ֪��ľ���
       for i = 1:data(1,1)
        for j = 1:7
            Known_Point(i,j) = data(7*i+j - 5);
        end
       end % Ϊ��֪�����ֵ
    for i = 1:data(1,2)
        for j = 1:4
            Unknown_Point(i,j) = data(4*i+j+26);
        end
    end % Ϊδ֪�����ֵ
end