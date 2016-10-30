%MUSIC ALOGRITHM
%DOA ESTIMATION BY CLASSICAL_MUSIC
clear all;
%close all;
clc;

source_number=3;%��Ԫ��
sensor_number=8;%��Ԫ��
N_x=1024; %�źų���
snapshot_number=N_x;%������
w=[pi/4 pi/6].';%�ź�Ƶ��
l=((2*pi*3e8)/w(1)+(2*pi*3e8)/w(2))/2;%�źŲ���  
d=0.5*l;%��Ԫ���
snr=0;%�����

source_doa=[-45 60];%�����źŵ�����Ƕ�
A=[exp(-j*(0:sensor_number-1)*d*2*pi*sin(source_doa(1)*pi/180)/l);exp(-j*(0:sensor_number-1)*d*2*pi*sin(source_doa(2)*pi/180)/l)].';%��������

s=sqrt(10.^(snr/10))*exp(j*w*[0:N_x-1]);%�����ź�
%x=awgn(s,snr);
x=A*s+(1/sqrt(2))*(randn(sensor_number,N_x)+j*randn(sensor_number,N_x));%���˸�˹������������н����ź�

R=x*x'/snapshot_number;
disp(R);
%[V,D]=eig(R);
%Un=V(:,1:sensor_number-source_number);
%Gn=Un*Un';
[V,D]=eig(R);
D=diag(D);
disp(D);
Un=V(:,1:sensor_number-source_number);
Gn=Un*Un';
disp(Gn);

searching_doa=-90:0.1:90;%�����������ΧΪ-90~90��
 for i=1:length(searching_doa)
   a_theta=exp(-j*(0:sensor_number-1)'*2*pi*d*sin(pi*searching_doa(i)/180)/l);
   Pmusic(i)=1./abs((a_theta)'*Gn*a_theta);
 end
plot(searching_doa,10*log(Pmusic),'r');
%axis([-90 90 -90 90]);
xlabel('�����/degree');
ylabel('�ռ���/dB');
legend('Music Spectrum');
title('����MUSIC����');
grid on;
