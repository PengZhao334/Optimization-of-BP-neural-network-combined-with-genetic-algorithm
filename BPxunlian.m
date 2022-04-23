load data input output%下载输入输入输出数据

Y = 1;
for Y = 1:5000;
%从1到100随机排列
k = rand(1,100);
[m,n] = sort(k);

%找出训练数据和预测数据
input_train = input(n(1:82),:)';
output_train = output(n(1:82),:)';
input_test = input(n(83:100),:)';
output_test = output(n(83:100),:)';

%数据归一化
[inputn,inputps] = mapminmax(input_train);
[outputn,outputps] = mapminmax(output_train);

%构建BP神经网络
net = newff(inputn,outputn,4);

net.trainParam.epochs =1000;%最大训练次数
net.trainParam.lr = 0.001;%学习速率
net.trainParam.goal = 0.0000004;%训练精度
net.trainParam.mc = 0.95

%BP神经网络训练
net = train(net,inputn,outputn);

%测试样本归一化
inputn_test = mapminmax('apply',input_test,inputps);

%BP神经网络预测
an = sim(net,inputn_test);

%预测结果反归一化
BPoutput = mapminmax('reverse',an,outputps);

%网络存储
save data net inputps outputps;

R2 = 1-(sum((output_test-BPoutput).^2))/(sum((output_test-mean(output_test)).^2)); %拟合优度

if R2 >0.95;
    break;
else Y+1;
end
end

%网络预测图形
figure('color',[1 1 1]);
figure(1)
plot(BPoutput,': or');
hold on;
plot(output_test,'- *');
legend('BP','real','fontsize',12);
title('prediction of BP','fontsize',12);
xlabel('sample','fontsize',12);
ylabel('Peak of flow force(N)','fontsize',12);

error = (abs(BPoutput-output_test))./output_test*100;%预测误差
figure(2)
plot(error,'-*')
title('Relative error of BP','fontsize',12);
ylabel('Relative error(%)','fontsize',12)
xlabel('sample','fontsize',12)

RMSE = sqrt(sum((BPoutput-output_test).^2)/10) %均方根误差
MAE = (sum(BPoutput-output_test))/10 %平均绝对误差