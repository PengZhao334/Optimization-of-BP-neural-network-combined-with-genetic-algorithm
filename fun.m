function fitness = fun(x);
%计算个体适应度
%x input 个体
%fitness output 个体适应度值

%神经网络下载
load data net inputps outputps;

%输入数据归一化
x=x';
inputn_test = mapminmax('apply',x,inputps);%x为个体

%神经网络预测
an = sim(net,inputn_test);

%预测数据反归一化作为适应度值
fitness = mapminmax('reverse',an,outputps);
end
