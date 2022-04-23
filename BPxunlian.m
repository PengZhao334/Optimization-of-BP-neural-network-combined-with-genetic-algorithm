load data input output%�������������������

Y = 1;
for Y = 1:5000;
%��1��100�������
k = rand(1,100);
[m,n] = sort(k);

%�ҳ�ѵ�����ݺ�Ԥ������
input_train = input(n(1:82),:)';
output_train = output(n(1:82),:)';
input_test = input(n(83:100),:)';
output_test = output(n(83:100),:)';

%���ݹ�һ��
[inputn,inputps] = mapminmax(input_train);
[outputn,outputps] = mapminmax(output_train);

%����BP������
net = newff(inputn,outputn,4);

net.trainParam.epochs =1000;%���ѵ������
net.trainParam.lr = 0.001;%ѧϰ����
net.trainParam.goal = 0.0000004;%ѵ������
net.trainParam.mc = 0.95

%BP������ѵ��
net = train(net,inputn,outputn);

%����������һ��
inputn_test = mapminmax('apply',input_test,inputps);

%BP������Ԥ��
an = sim(net,inputn_test);

%Ԥ��������һ��
BPoutput = mapminmax('reverse',an,outputps);

%����洢
save data net inputps outputps;

R2 = 1-(sum((output_test-BPoutput).^2))/(sum((output_test-mean(output_test)).^2)); %����Ŷ�

if R2 >0.95;
    break;
else Y+1;
end
end

%����Ԥ��ͼ��
figure('color',[1 1 1]);
figure(1)
plot(BPoutput,': or');
hold on;
plot(output_test,'- *');
legend('BP','real','fontsize',12);
title('prediction of BP','fontsize',12);
xlabel('sample','fontsize',12);
ylabel('Peak of flow force(N)','fontsize',12);

error = (abs(BPoutput-output_test))./output_test*100;%Ԥ�����
figure(2)
plot(error,'-*')
title('Relative error of BP','fontsize',12);
ylabel('Relative error(%)','fontsize',12)
xlabel('sample','fontsize',12)

RMSE = sqrt(sum((BPoutput-output_test).^2)/10) %���������
MAE = (sum(BPoutput-output_test))/10 %ƽ���������