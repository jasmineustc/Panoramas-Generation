clear all

p=100*[-2,-1,0,1,2;10,2,1,2,10];
p_test=100*[0;3];

p_test_hto1=[];
p_test_hto1_norm=[];

hto1=[];
hto1_norm=[];

for i=1:1000
    r =  1.*randn(2,5);
    p_corrupt=p+r;
    
    H=computeH(p,p_corrupt);
    H_norm=computeH_norm(p, p_corrupt);
    hto1=[hto1,H];
    hto1_norm=[hto1_norm,H_norm];
    
    p_test_hto1=[p_test_hto1, H*[p_test;1]];
    p_test_hto1_norm=[p_test_hto1_norm,H_norm*[p_test;1]];   
end

for i=1:1000
    p_test_hto1(:,i)=p_test_hto1(:,i)/p_test_hto1(3,i);
    p_test_hto1_norm(:,i)=p_test_hto1_norm(:,i)/p_test_hto1_norm(3,i);
end


scatter(p_test_hto1(1,:),p_test_hto1(2,:),'*','r');
hold on;
scatter(p_test_hto1_norm(1,:),p_test_hto1_norm(2,:),'.','b');
ylim([200,400]);
legend('un-normalized','normalized');
saveas(gcf,'../results/q3_1.jpg');

cov1=cov(p_test_hto1');
cov2=cov(p_test_hto1_norm');

var1=eig(cov1);
var2=eig(cov2);

sigma1=var1(length(cov1))^0.5;
sigma2=var2(length(cov2))^0.5;

ratio=sigma1/sigma2;
fprintf('--------the ration of standard deviation is ---------\n');
disp(ratio);
























