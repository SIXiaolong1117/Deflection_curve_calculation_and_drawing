% Deflection curve calculation and drawing
% (C)2021 SI-Xiaolong(ustb_stu_sixiaolong@outlook.com)
% MIT License

%清理
clear all
clc

%给定信息
disp('给定材料信息及受力情况');
L=input('园杆长度L(/m)=');
D=input('园杆直径D(/m)=');
E=input('弹性模量E(/GPa)=');
F=input('切向集中力大小【向下为正，若无取零】F(/N)=');
a=input('切向集中力作用位置a(/m)=');
M=input('弯矩大小【逆时针为正，若无取零】M(/N*m)=');
b=input('弯矩作用位置b(/m)=');
disp('给定计算精度');
n=input('计算精度=');

%惯性矩计算
I=double(D^4*3.14/32);

%计算由集中力引起的挠度
x1=0:n:a;
vx1=(-F*x1.^2*3*a+F*x1.^3)*(1/(6*E*10^9*I));
x2=a:n:L;
vx2=(-F*a.^2*3*x2+F*a.^3)*(1/(6*E*10^9*I));
%计算由集中力偶引起的挠度
x3=0:n:b;
vx3=(-M*x3.^2)*(1/(2*E*10^9*I));
x4=b:n:L;
vx4=(-M*b*x4+M*0.5*b.^2)*(1/(E*10^9*I));

%连接矩阵
v11=[vx1,vx2];
v22=[vx3,vx4];

%采用叠加法计算总挠度
v33=v22+v11;

%绘图
xu=[x1,x2];
plot(xu,v33),xlabel('x/m'),ylabel('v(x)/m')
title('挠曲线图')
grid on;