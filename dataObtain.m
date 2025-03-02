% clear;

%% UR5机械臂数据  读取时间大概1-2min

sarcos_train=load('sarcos_inv.mat');
data=sarcos_train.sarcos_inv;

sarcos_test=load('sarcos_inv_test.mat');
data2=sarcos_test.sarcos_inv_test;

accel_filt = designfilt('lowpassiir','FilterOrder',5, ...
        'HalfPowerFrequency',0.01,'DesignMethod','butter');

% A_position1=xlsread('Qtrain.xlsx','Q','B:B');       %读取数据  关节位置
% A_position2=xlsread('Qtrain.xlsx','Q','C:C');
% A_position3=xlsread('Qtrain.xlsx','Q','D:D');
% A_position4=xlsread('Qtrain.xlsx','Q','E:E');
% A_position5=xlsread('Qtrain.xlsx','Q','F:F');
% A_position6=xlsread('Qtrain.xlsx','Q','G:G');

position1=data(:,1);
position2=data(:,2);
position3=data(:,3);
position4=data(:,4);
position5=data(:,5);
position6=data(:,6);
position7=data(:,7);

position8=data2(:,1);
position9=data2(:,2);
position10=data2(:,3);
position11=data2(:,4);
position12=data2(:,5);
position13=data2(:,6);
position14=data2(:,7);

% B_speed1=xlsread('Qtrain.xlsx','Q','H:H');        %  关节速度
% B_speed2=xlsread('Qtrain.xlsx','Q','I:I');
% B_speed3=xlsread('Qtrain.xlsx','Q','J:J');
% B_speed4=xlsread('Qtrain.xlsx','Q','K:K');
% B_speed5=xlsread('Qtrain.xlsx','Q','L:L');
% B_speed6=xlsread('Qtrain.xlsx','Q','M:M');

velocity1=data(:,8);
velocity2=data(:,9);
velocity3=data(:,10);
velocity4=data(:,11);
velocity5=data(:,12);
velocity6=data(:,13);
velocity7=data(:,14);

velocity8=data2(:,8);
velocity9=data2(:,9);
velocity10=data2(:,10);
velocity11=data2(:,11);
velocity12=data2(:,12);
velocity13=data2(:,13);
velocity14=data2(:,14);

acceleration1=data(:,15);
acceleration2=data(:,16);
acceleration3=data(:,17);
acceleration4=data(:,18);
acceleration5=data(:,19);
acceleration6=data(:,20);
acceleration7=data(:,21);

acceleration8=data2(:,15);
acceleration9=data2(:,16);
acceleration10=data2(:,17);
acceleration11=data2(:,18);
acceleration12=data2(:,19);
acceleration13=data2(:,20);
acceleration14=data2(:,21);

% C_current1=xlsread('Qtrain.xlsx','Q','N:N');        %  电机电流
% C_current2=xlsread('Qtrain.xlsx','Q','O:O');
% C_current3=xlsread('Qtrain.xlsx','Q','P:P');
% C_current4=xlsread('Qtrain.xlsx','Q','Q:Q');
% C_current5=xlsread('Qtrain.xlsx','Q','R:R');
% C_current6=xlsread('Qtrain.xlsx','Q','S:S');

torque1=data(:,22);
torque2=data(:,23);
torque3=data(:,24);
torque4=data(:,25);
torque5=data(:,26);
torque6=data(:,27);
torque7=data(:,28);

torque8=data2(:,22);
torque9=data2(:,23);
torque10=data2(:,24);
torque11=data2(:,25);
torque12=data2(:,26);
torque13=data2(:,27);
torque14=data2(:,28);

% E_time=xlsread('Qtrain.xlsx','Q','A:A');           %  时间

trainIn11=[];
trainIn12=[];
trainIn13=[];
trainIn14=[];
trainIn15=[];
trainIn16=[];
trainIn17=[];

trainIn21=[];
trainIn22=[];
trainIn23=[];
trainIn24=[];
trainIn25=[];
trainIn26=[];
trainIn27=[];

trainIn31=[];
trainIn32=[];
trainIn33=[];
trainIn34=[];
trainIn35=[];
trainIn36=[];
trainIn37=[];

trainIn41=[];
trainIn42=[];
trainIn43=[];
trainIn44=[];
trainIn45=[];
trainIn46=[];
trainIn47=[];

trainIn51=[];
trainIn52=[];
trainIn53=[];
trainIn54=[];
trainIn55=[];
trainIn56=[];
trainIn57=[];

trainIn61=[];
trainIn62=[];
trainIn63=[];
trainIn64=[];
trainIn65=[];
trainIn66=[];
trainIn67=[];

trainOut1=[];
trainOut2=[];
trainOut3=[];
trainOut4=[];
trainOut5=[];
trainOut6=[];
trainOut7=[];

trainOut8=[];
trainOut9=[];
trainOut10=[];
trainOut11=[];
trainOut12=[];
trainOut13=[];
trainOut14=[];

% time0=[];

trainIn11=position1';
trainIn12=position2';
trainIn13=position3';
trainIn14=position4';
trainIn15=position5';
trainIn16=position6';
trainIn17=position7';

trainIn21=velocity1';
trainIn22=velocity2';
trainIn23=velocity3';
trainIn24=velocity4';
trainIn25=velocity5';
trainIn26=velocity6';
trainIn27=velocity7';

trainIn31=acceleration1';
trainIn32=acceleration2';
trainIn33=acceleration3';
trainIn34=acceleration4';
trainIn35=acceleration5';
trainIn36=acceleration6';
trainIn37=acceleration7';

testIn11=position8';
testIn12=position9';
testIn13=position10';
testIn14=position11';
testIn15=position12';
testIn16=position13';
testIn17=position14';

testIn21=velocity8';
testIn22=velocity9';
testIn23=velocity10';
testIn24=velocity11';
testIn25=velocity12';
testIn26=velocity13';
testIn27=velocity14';

testIn31=acceleration8';
testIn32=acceleration9';
testIn33=acceleration10';
testIn34=acceleration11';
testIn35=acceleration12';
testIn36=acceleration13';
testIn37=acceleration14';

trainOut1=torque1';
trainOut2=torque2';
trainOut3=torque3';
trainOut4=torque4';
trainOut5=torque5';
trainOut6=torque6';
trainOut7=torque7';

testOut1=torque8';
testOut2=torque9';
testOut3=torque10';
testOut4=torque11';
testOut5=torque12';
testOut6=torque13';
testOut7=torque14';

% plot(trainIn11);
% hold on;
% plot(trainIn12);
% hold on;
% plot(trainIn13);
% hold on;
% plot(trainIn14);
% hold on;
% plot(trainIn15);
% hold on;
% plot(trainIn16);
% hold on;
% plot(trainIn17);
% hold on;
% legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7')

trainIn11 = filtfilt(accel_filt,trainIn11);    %低通滤波平滑处理
trainIn12 = filtfilt(accel_filt,trainIn12);
trainIn13 = filtfilt(accel_filt,trainIn13);
trainIn14 = filtfilt(accel_filt,trainIn14);
trainIn15 = filtfilt(accel_filt,trainIn15);
trainIn16 = filtfilt(accel_filt,trainIn16);
trainIn17 = filtfilt(accel_filt,trainIn17);

% plot(trainIn11,'LineWidth',1.2);  %position
% hold on;
% plot(trainIn12,'LineWidth',1.2);
% hold on;
% plot(trainIn13,'LineWidth',1.2);
% hold on;
% plot(trainIn14,'LineWidth',1.2);
% hold on;
% plot(trainIn15,'LineWidth',1.2);
% hold on;
% plot(trainIn16,'LineWidth',1.2);
% hold on;
% plot(trainIn17,'LineWidth',1.2);
% hold on;
% legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7','FontSize',20)

testIn11 = filtfilt(accel_filt,testIn11);    %低通滤波平滑处理
testIn12 = filtfilt(accel_filt,testIn12);
testIn13 = filtfilt(accel_filt,testIn13);
testIn14 = filtfilt(accel_filt,testIn14);
testIn15 = filtfilt(accel_filt,testIn15);
testIn16 = filtfilt(accel_filt,testIn16);
testIn17 = filtfilt(accel_filt,testIn17);


trainIn21 = filtfilt(accel_filt,trainIn21);   %低通滤波平滑处理
trainIn22 = filtfilt(accel_filt,trainIn22);
trainIn23 = filtfilt(accel_filt,trainIn23);
trainIn24 = filtfilt(accel_filt,trainIn24);
trainIn25 = filtfilt(accel_filt,trainIn25);
trainIn26 = filtfilt(accel_filt,trainIn26);
trainIn27 = filtfilt(accel_filt,trainIn27);

% plot(trainIn21,'LineWidth',1.2);  %velocity
% hold on;
% plot(trainIn22,'LineWidth',1.2);
% hold on;
% plot(trainIn23,'LineWidth',1.2);
% hold on;
% plot(trainIn24,'LineWidth',1.2);
% hold on;
% plot(trainIn25,'LineWidth',1.2);
% hold on;
% plot(trainIn26,'LineWidth',1.2);
% hold on;
% plot(trainIn27,'LineWidth',1.2);
% hold on;
% legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7','FontSize',20)

testIn21 = filtfilt(accel_filt,testIn21);   %低通滤波平滑处理
testIn22 = filtfilt(accel_filt,testIn22);
testIn23 = filtfilt(accel_filt,testIn23);
testIn24 = filtfilt(accel_filt,testIn24);
testIn25 = filtfilt(accel_filt,testIn25);
testIn26 = filtfilt(accel_filt,testIn26);
testIn27 = filtfilt(accel_filt,testIn27);

trainIn31 = filtfilt(accel_filt,trainIn31);   %低通滤波平滑处理
trainIn32 = filtfilt(accel_filt,trainIn32);
trainIn33 = filtfilt(accel_filt,trainIn33);
trainIn34 = filtfilt(accel_filt,trainIn34);
trainIn35 = filtfilt(accel_filt,trainIn35);
trainIn36 = filtfilt(accel_filt,trainIn36);
trainIn37 = filtfilt(accel_filt,trainIn37);

% plot(trainIn31,'LineWidth',1.2);  %acc
% hold on;
% plot(trainIn32,'LineWidth',1.2);
% hold on;
% plot(trainIn33,'LineWidth',1.2);
% hold on;
% plot(trainIn34,'LineWidth',1.2);
% hold on;
% plot(trainIn35,'LineWidth',1.2);
% hold on;
% plot(trainIn36,'LineWidth',1.2);
% hold on;
% plot(trainIn37,'LineWidth',1.2);
% hold on;
% legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7','FontSize',20)

testIn31 = filtfilt(accel_filt,testIn31);   %低通滤波平滑处理
testIn32 = filtfilt(accel_filt,testIn32);
testIn33 = filtfilt(accel_filt,testIn33);
testIn34 = filtfilt(accel_filt,testIn34);
testIn35 = filtfilt(accel_filt,testIn35);
testIn36 = filtfilt(accel_filt,testIn36);
testIn37 = filtfilt(accel_filt,testIn37);

trainOut1 = filtfilt(accel_filt,trainOut1);   %低通滤波平滑处理
trainOut2 = filtfilt(accel_filt,trainOut2);
trainOut3 = filtfilt(accel_filt,trainOut3);
trainOut4 = filtfilt(accel_filt,trainOut4);
trainOut5 = filtfilt(accel_filt,trainOut5);
trainOut6 = filtfilt(accel_filt,trainOut6);
trainOut7 = filtfilt(accel_filt,trainOut7);

testOut1 = filtfilt(accel_filt,testOut1);   %低通滤波平滑处理
testOut2 = filtfilt(accel_filt,testOut2);
testOut3 = filtfilt(accel_filt,testOut3);
testOut4 = filtfilt(accel_filt,testOut4);
testOut5 = filtfilt(accel_filt,testOut5);
testOut6 = filtfilt(accel_filt,testOut6);
testOut7 = filtfilt(accel_filt,testOut7);

% plot(trainOut1,'LineWidth',1.2);
% hold on;
% plot(trainOut2,'LineWidth',1.2);
% hold on;
% plot(trainOut3,'LineWidth',1.2);
% hold on;
% plot(trainOut4,'LineWidth',1.2);
% hold on;
% plot(trainOut5,'LineWidth',1.2);
% hold on;
% plot(trainOut6,'LineWidth',1.2);
% hold on;
% plot(trainOut7,'LineWidth',1.2);
% hold on;
% legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7','FontSize',20)

% plot(testOut1);
% hold on;
% plot(testOut2);
% hold on;
% plot(testOut3);
% hold on;
% plot(testOut4);
% hold on;
% plot(testOut5);
% hold on;
% plot(testOut6);
% hold on;
% plot(testOut7);
% hold on;
% legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7')





% trainIn11 = smoothdata(trainIn11,'sgolay',50);    %滤波平滑处理
% trainIn12 = smoothdata(trainIn12,'sgolay',50);
% trainIn13 = smoothdata(trainIn13,'sgolay',50);
% trainIn14 = smoothdata(trainIn14,'sgolay',50);
% trainIn15 = smoothdata(trainIn15,'sgolay',50);
% trainIn16 = smoothdata(trainIn16,'sgolay',50);
% 
% trainIn21 = smoothdata(trainIn21,'sgolay',50);    %滤波平滑处理
% trainIn22 = smoothdata(trainIn22,'sgolay',50);
% trainIn23 = smoothdata(trainIn23,'sgolay',50);
% trainIn24 = smoothdata(trainIn24,'sgolay',50);
% trainIn25 = smoothdata(trainIn25,'sgolay',50);
% trainIn26 = smoothdata(trainIn26,'sgolay',50);
% % trainOut = smoothdata(trainOut,30,'sgolay');    %滤波平滑处理
% trainOut = smoothdata(trainOut,'sgolay',50);    %滤波平滑处理

% for i=0:1:(length(E_time)-1)
%     time0=[time0,i*0.002];
% end
% figure(1);
% subplot(3,2,1);
% plot(time0,C_current1');
% title('1关节电流'); 
% subplot(3,2,2);
% plot(time0,C_current2');
% title('2关节电流'); 
% subplot(3,2,3);
% plot(time0,C_current3');
% title('3关节电流'); 
% subplot(3,2,4);
% plot(time0,C_current4');
% title('4关节电流'); 
% subplot(3,2,5);
% plot(time0,C_current5');
% title('5关节电流'); 
% subplot(3,2,6);
% plot(time0,trainOut6);
% title('6关节电流'); 
% 
% figure(2);
% plot(time0,trainIn16);
% title('6关节位置');
% figure(3);
% plot(time0,trainIn26);
% title('6关节速度');
