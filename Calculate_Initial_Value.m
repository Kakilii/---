%% 计算一张相片的外方位元素，当judge为1的时候计算左片，当judge为2的时候计算右片
function [XS,YS,ZS,a,b,c] = Calculate_Initial_Value(data,Known_Point,judge,f,H)
 ZS = sum(Known_Point(:,7))/data(1,1)+H;
 XS = (Known_Point(judge,5)+Known_Point(judge+2,5))/2;
 YS = (Known_Point(judge,6)+Known_Point(judge+2,6))/2;
 f = f*1000;
 a=0;b=0;c=0;
 break_num = 2; 
 while break_num>0.000003
 a1=cos(a)*cos(c)-sin(a)*sin(b)*sin(c);
 a2=-cos(a)*sin(c)-sin(a)*sin(b)*cos(c);
 a3=-sin(a)*cos(b);
 b1=cos(b)*sin(c);
 b2=cos(b)*cos(c);
 b3=-sin(b);
 c1=sin(a)*cos(c)+cos(a)*sin(b)*sin(c);
 c2=-sin(a)*sin(c)+cos(a)*sin(b)*cos(c);
 c3=cos(a)*cos(b);
 R=[a1 a2 a3;
    b1 b2 b3;
    c1 c2 c3];
 %%%%共线方程%%%%%
 for i =1:4
 x(i)=-f*(a1*(Known_Point(i,5)-XS)+b1*(Known_Point(i,6)-YS)+c1*(Known_Point(i,7)-ZS))/(a3*(Known_Point(i,5)-XS)+b3*(Known_Point(i,6)-YS)+c3*(Known_Point(i,7)-ZS));
 y(i)=-f*(a2*(Known_Point(i,5)-XS)+b2*(Known_Point(i,6)-YS)+c2*(Known_Point(i,7)-ZS))/(a3*(Known_Point(i,5)-XS)+b3*(Known_Point(i,6)-YS)+c3*(Known_Point(i,7)-ZS));
 end
 %%%%%A矩阵%%%%

 for i=0:3
     A(2*i+1,1)=-f/(H)*cos(c);
     A(2*i+1,2)=-f/(H)*sin(c);
     A(2*i+1,3)=-(Known_Point(i+1,2*judge-1)-0)/(H);
     A(2*i+1,4)= -(f+((Known_Point(i+1,2*judge-1)-0)*(Known_Point(i+1,2*judge-1)-0))/f)*cos(c)+(Known_Point(i+1,2*judge-1)-0)*(Known_Point(i+1,2*judge)-0)/f*sin(c);
     A(2*i+1,5)=-(Known_Point(i+1,2*judge-1)-0)*(Known_Point(i+1,2*judge)-0)/f*cos(c)-(f+((Known_Point(i+1,2*judge-1)-0)*(Known_Point(i+1,2*judge-1)-0))/f)*sin(c);
     A(2*i+1,6)=Known_Point(i+1,2*judge)-0;
     A(2*i+2,1)=f/(H)*sin(c);
     A(2*i+2,2)=-f/(H)*cos(c);
     A(2*i+2,3)=-(Known_Point(i+1,2*judge)-0)/(H);
     A(2*i+2,4)=-(Known_Point(i+1,2*judge-1)-0)*(Known_Point(i+1,2*judge)-0)/f*cos(c)+(f+((Known_Point(i+1,2*judge)-0)*(Known_Point(i+1,2*judge)-0))/f)*sin(c);
     A(2*i+2,5)=-(f+((Known_Point(i+1,2*judge)-0)*(Known_Point(i+1,2*judge)-0))/f)*cos(c)-(Known_Point(i+1,2*judge-1)-0)*(Known_Point(i+1,2*judge)-0)/f*sin(c);
     A(2*i+2,6)=-(Known_Point(i+1,2*judge-1)-0);
     
 end
 %%%%%l矩阵%%%%
 for i=1:4
 l(2*i-1,1)= Known_Point(i,2*judge-1)-x(i);
 l(2*i,1) = Known_Point(i,2*judge)-y(i);
 end
X=inv(A'*A)*(A'*l);
XS=XS+X(1,1);
YS=YS+X(2,1);
ZS=ZS+X(3,1);
a=a+X(4,1);
b=b+X(5,1);
c=c+X(6,1);
break_num=max(abs(X(4:6,1)));
 end 