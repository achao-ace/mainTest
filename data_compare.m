% %----joint1----%%
% true=load('1_true.mat');
% TRUE=true.yTest;
% Bi=load('1_BILSTM_0.0305.mat');
% BILSTM=Bi.YPred;
% gru=load('1_gru_0.0339.mat');
% GRU=gru.YPred;
% lstm=load('1_lstm_0.0359.mat');
% LSTM=lstm.YPred;
% ssa=load('1_SSA_LSTM_0.0247.mat');
% SSA_LSTM=ssa.YPred2;
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% R_bilstm=fitlm(BILSTM,TRUE)
% R_gru=fitlm(GRU,TRUE)
% R_lstm=fitlm(LSTM,TRUE)
% R_our=fitlm(SSA_LSTM,TRUE)
% 
% MAE_LSTM = mean(abs(TRUE - LSTM));
% MAE_BI = mean(abs(TRUE - BILSTM));
% MAE_GRU = mean(abs(TRUE - GRU));
% MAE_SSA = mean(abs(TRUE - SSA_LSTM));
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% %----joint1_origin----%%
% ps=load('1_outputps.mat');
% outputps=ps.outputps;
% true=load('1_true_origin.mat');
% TRUE=true.yTest;
% Bi=load('1_BILSTM_0.0305.mat');
% BILSTM=mapminmax('reverse',Bi.YPred,outputps);
% gru=load('1_gru_0.0339.mat');
% GRU=mapminmax('reverse',gru.YPred,outputps);
% lstm=load('1_lstm_0.0359.mat');
% LSTM=mapminmax('reverse',lstm.YPred,outputps);
% ssa=load('1_SSA_LSTM_0.0247.mat');
% SSA_LSTM=mapminmax('reverse',ssa.YPred2,outputps);
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% res_bi=fitlm(BILSTM,TRUE)
% res_bi.RMSE
% res_lstm=fitlm(LSTM,TRUE)
% res_lstm.RMSE
% res_gru=fitlm(GRU,TRUE)
% res_gru.RMSE
% res_ssa=fitlm(SSA_LSTM,TRUE)
% res_ssa.RMSE
% 
% err=SSA_LSTM-TRUE;
% sumerr=0;
% sumout=0;
% for i=1:1:4449
%     sumerr=sumerr+err(i)*err(i);
%     sumout=sumout+t_test(i)*t_test(i);
% end
% LSTM_RMSE=sqrt(sumerr/length(err))
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% % ----joint2----%%
% true=load('2_true.mat');
% TRUE=true.t_test;
% Bi=load('2_BILSTM_0.0963.mat');
% BILSTM=Bi.YPred;
% gru=load('2_gru_0.0974.mat');
% GRU=gru.YPred;
% lstm=load('2_lstm_0.1033.mat');
% LSTM=lstm.YPred;
% ssa=load('2_SSA_LSTM_0.0898.mat');
% SSA_LSTM=ssa.YPred;
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% MAE_LSTM = mean(abs(TRUE - LSTM));
% MAE_BI = mean(abs(TRUE - BILSTM));
% MAE_GRU = mean(abs(TRUE - GRU));
% MAE_SSA = mean(abs(TRUE - SSA_LSTM));
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

%%----joint3----%%
% true=load('3_true.mat');
% TRUE=true.t_test;
% Bi=load('3_BILSTM_0.0557.mat');
% BILSTM=Bi.YPred;
% gru=load('3_gru_0.0604.mat');
% GRU=gru.YPred;
% lstm=load('3_lstm_0.0547.mat');
% LSTM=lstm.YPred;
% ssa=load('3_SSA_LSTM_0.0462.mat');
% SSA_LSTM=ssa.YPred;
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% R_bilstm=fitlm(BILSTM,TRUE)
% R_gru=fitlm(GRU,TRUE)
% R_lstm=fitlm(LSTM,TRUE)
% R_our=fitlm(SSA_LSTM,TRUE)
% 
% MAE_LSTM = mean(abs(TRUE - LSTM));
% MAE_BI = mean(abs(TRUE - BILSTM));
% MAE_GRU = mean(abs(TRUE - GRU));
% MAE_SSA = mean(abs(TRUE - SSA_LSTM));
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% %----joint4----%%
% true=load('4_true.mat');
% TRUE=true.t_test;
% Bi=load('4_BILSTM_0.0710.mat');
% BILSTM=Bi.YPred;
% gru=load('4_gru_0.0756.mat');
% GRU=gru.YPred;
% lstm=load('4_lstm_0.0725.mat');
% LSTM=lstm.YPred;
% ssa=load('4_SSA_LSTM_0.0665.mat');
% SSA_LSTM=ssa.YPred;
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% MAE_LSTM = mean(abs(TRUE - LSTM));
% MAE_BI = mean(abs(TRUE - BILSTM));
% MAE_GRU = mean(abs(TRUE - GRU));
% MAE_SSA = mean(abs(TRUE - SSA_LSTM));
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

%%----joint5----%%
% true=load('5_true.mat');
% TRUE=true.t_test;
% Bi=load('5_BILSTM_0.0963.mat');
% BILSTM=Bi.YPred;
% gru=load('5_gru_0.1026.mat');
% GRU=gru.YPred;
% lstm=load('5_lstm_0.1022.mat');
% LSTM=lstm.YPred;
% ssa=load('5_SSA_LSTM_0.0909.mat');
% SSA_LSTM=ssa.YPred;
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% MAE_LSTM = mean(abs(TRUE - LSTM));
% MAE_BI = mean(abs(TRUE - BILSTM));
% MAE_GRU = mean(abs(TRUE - GRU));
% MAE_SSA = mean(abs(TRUE - SSA_LSTM));
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% %%----joint5_origin----%%
% ps=load('5_outputps.mat');
% outputps=ps.outputps;
% true=load('5_true_origin.mat');
% TRUE=true.yTest;
% Bi=load('5_BILSTM_0.0963.mat');
% BILSTM=mapminmax('reverse',Bi.YPred,outputps);
% gru=load('5_gru_0.1026.mat');
% GRU=mapminmax('reverse',gru.YPred,outputps);
% lstm=load('5_lstm_0.1022.mat');
% LSTM=mapminmax('reverse',lstm.YPred,outputps);
% ssa=load('5_SSA_LSTM_0.0909.mat');
% SSA_LSTM=mapminmax('reverse',ssa.YPred,outputps);
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% res_bi=fitlm(BILSTM,TRUE)
% res_bi.RMSE
% res_lstm=fitlm(LSTM,TRUE)
% res_lstm.RMSE
% res_gru=fitlm(GRU,TRUE)
% res_gru.RMSE
% res_ssa=fitlm(SSA_LSTM,TRUE)
% res_ssa.RMSE
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

%%----joint6----%%
% true=load('6_true.mat');
% TRUE=true.yTest;
% Bi=load('6_BILSTM_0.0480.mat');
% BILSTM=Bi.YPred;
% gru=load('6_gru_0.0517.mat');
% GRU=gru.YPred;
% lstm=load('6_lstm_0.0524.mat');
% LSTM=lstm.YPred;
% ssa=load('6_SSA_LSTM_0.0439.mat');
% SSA_LSTM=ssa.YPred;
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% MAE_LSTM = mean(abs(TRUE - LSTM));
% MAE_BI = mean(abs(TRUE - BILSTM));
% MAE_GRU = mean(abs(TRUE - GRU));
% MAE_SSA = mean(abs(TRUE - SSA_LSTM));
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

%%----joint7----%%
% true=load('7_true.mat');
% TRUE=true.yTest;
% Bi=load('7_BILSTM_0.0641.mat');
% BILSTM=Bi.YPred;
% gru=load('7_gru_0.0728.mat');
% GRU=gru.YPred;
% lstm=load('7_lstm_0.0704.mat');
% LSTM=lstm.YPred;
% ssa=load('7_SSA_LSTM_0.0603.mat');
% SSA_LSTM=ssa.YPred;
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% MAE_LSTM = mean(abs(TRUE - LSTM));
% MAE_BI = mean(abs(TRUE - BILSTM));
% MAE_GRU = mean(abs(TRUE - GRU));
% MAE_SSA = mean(abs(TRUE - SSA_LSTM));
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

%%----joint7_origin----%%
% ps=load('7_outputps.mat');
% outputps=ps.outputps;
% true=load('7_true_origin.mat');
% TRUE=true.yTest;
% Bi=load('7_BILSTM_0.0641.mat');
% BILSTM=mapminmax('reverse',Bi.YPred,outputps);
% gru=load('7_gru_0.0728.mat');
% GRU=mapminmax('reverse',gru.YPred,outputps);
% lstm=load('7_lstm_0.0704.mat');
% LSTM=mapminmax('reverse',lstm.YPred,outputps);
% ssa=load('7_SSA_LSTM_0.0603.mat');
% SSA_LSTM=mapminmax('reverse',ssa.YPred,outputps);
% 
% 
% plot(TRUE,'LineWidth',1.2);
% hold on;
% plot(BILSTM,'LineWidth',1.2);
% hold on;
% plot(GRU,'LineWidth',1.2);
% hold on;
% plot(LSTM,'LineWidth',1.2);
% hold on;
% plot(SSA_LSTM,'LineWidth',1.2);
% legend('Actual','BiLSTM','GRU','LSTM','Ours','FontSize',20)
% 
% res_bi=fitlm(BILSTM,TRUE)
% res_bi.RMSE
% res_lstm=fitlm(LSTM,TRUE)
% res_lstm.RMSE
% res_gru=fitlm(GRU,TRUE)
% res_gru.RMSE
% res_ssa=fitlm(SSA_LSTM,TRUE)
% res_ssa.RMSE
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% %%----joint7-errors----%%
% true=load('7_true.mat');
% TRUE=true.yTest;
% Bi=load('7_BILSTM_0.0641.mat');
% BILSTM=Bi.YPred;
% gru=load('7_gru_0.0728.mat');
% GRU=gru.YPred;
% lstm=load('7_lstm_0.0704.mat');
% LSTM=lstm.YPred;
% ssa=load('7_SSA_LSTM_0.0603.mat');
% SSA_LSTM=ssa.YPred;
% ZERO=zeros(1,4449);
% 
% plot(TRUE-BILSTM,'LineWidth',1.2);
% hold on;
% plot(TRUE-GRU,'LineWidth',1.2);
% hold on;
% plot(TRUE-LSTM,'LineWidth',1.2);
% hold on;
% plot(TRUE-SSA_LSTM,'LineWidth',1.2);
% hold on;
% plot(ZERO,'LineWidth',1.2);
% hold on;
% legend('BiLSTM','GRU','LSTM','Ours','zero','FontSize',20)
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% %%----joint1-errors----%%
% true=load('1_true.mat');
% TRUE=true.yTest;
% Bi=load('1_BILSTM_0.0305.mat');
% BILSTM=Bi.YPred;
% gru=load('1_gru_0.0339.mat');
% GRU=gru.YPred;
% lstm=load('1_lstm_0.0359.mat');
% LSTM=lstm.YPred;
% ssa=load('1_SSA_LSTM_0.0247.mat');
% SSA_LSTM=ssa.YPred2;
% ZERO=zeros(1,4449);
% 
% plot(TRUE-BILSTM,'LineWidth',1.2);
% hold on;
% plot(TRUE-GRU,'LineWidth',1.2);
% hold on;
% plot(TRUE-LSTM,'LineWidth',1.2);
% hold on;
% plot(TRUE-SSA_LSTM,'LineWidth',1.2);
% hold on;
% plot(ZERO,'LineWidth',1.2);
% hold on;
% legend('BiLSTM','GRU','LSTM','Ours','zero','FontSize',20)
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% %%----joint2-errors----%%
% true=load('2_true.mat');
% TRUE=true.t_test;
% Bi=load('2_BILSTM_0.0963.mat');
% BILSTM=Bi.YPred;
% gru=load('2_gru_0.0974.mat');
% GRU=gru.YPred;
% lstm=load('2_lstm_0.1033.mat');
% LSTM=lstm.YPred;
% ssa=load('2_SSA_LSTM_0.0898.mat');
% SSA_LSTM=ssa.YPred;
% ZERO=zeros(1,4449);
% 
% plot(TRUE-BILSTM,'LineWidth',1.2);
% hold on;
% plot(TRUE-GRU,'LineWidth',1.2);
% hold on;
% plot(TRUE-LSTM,'LineWidth',1.2);
% hold on;
% plot(TRUE-SSA_LSTM,'LineWidth',1.2);
% hold on;
% plot(ZERO,'LineWidth',1.2);
% hold on;
% legend('BiLSTM','GRU','LSTM','Ours','zero','FontSize',20)
% 
% 
% resquared=fitlm(SSA_LSTM,TRUE)
% 
% zp = BaseZoom();
% zp.run;
% zp.run;

% %-----条形图-----%%
% y_RMSE=[0.0339,0.0359,0.0305,0.0247;
%     0.0974,0.1033,0.0963,0.0898;
%     0.0604,0.0547,0.0557,0.0462;
%     0.0756,0.0725,0.0710,0.0665;
%     0.1026,0.1022,0.0963,0.0909;
%     0.0517,0.0524,0.0480,0.0439;
%     0.0728,0.0704,0.0641,0.0603];
% bar(y_RMSE);
% xlabel('joint')
% ylabel('RMSE')
% legend({'GRU','LSTM','BI-LSTM','Ours'})

MAE=[0.0277,0.0276,0.0238,0.0156;
    0.0746,0.0822,0.0724,0.0648;
    0.0446,0.0400,0.0439,0.0358;
    0.0596,0.0520,0.0448,0.0434;
    0.0740,0.0770,0.0756,0.0693;
    0.0404,0.0298,0.0284,0.0254;
    0.0535,0.0502,0.0455,0.0420];
name1=['joint1','joint2','joint3','joint4','joint5','joint6','joint7'];
name2=["joint1" "joint2" "joint3" "joint4" "joint5" "joint6" "joint7"];
bar(MAE);
xlabel('joint')
ylabel('MAE')
legend({'GRU','LSTM','BI-LSTM','Ours'})








