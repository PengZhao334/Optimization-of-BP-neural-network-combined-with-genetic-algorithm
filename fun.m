function fitness = fun(x);
%���������Ӧ��
%x input ����
%fitness output ������Ӧ��ֵ

%����������
load data net inputps outputps;

%�������ݹ�һ��
x=x';
inputn_test = mapminmax('apply',x,inputps);%xΪ����

%������Ԥ��
an = sim(net,inputn_test);

%Ԥ�����ݷ���һ����Ϊ��Ӧ��ֵ
fitness = mapminmax('reverse',an,outputps);
end
