%Codes for Qn and Qn_Hat.
clear all;
close all;
format long;

%Codes for Computing Qn

f = @(x) sin(log(x)./x)./x;
n_array = 50:50:550;
for n = n_array
    a = [];
    I = 0;
    Q = [];
    for i = 1:n
        b = fzero( @(x) x*exp(x)-i*pi , 0);
        a = [a exp(-b)];
        if i==1
           I = I + integral(f,a(i),1);
           Q_0 = I;
        else
           I = I + integral(f, a(i),a(i-1));
           Q = [Q I];
        end
    end
end

%Codes for Computing Qn_Hat via Aitken's Method

for i = 1:500
    Q_Hat(i) = Q(i) - ((Q(i+1)-Q(i))^2)/(Q(i+2)-2*Q(i+1)+Q(i));
end
Q_Hat_0 = Q_0 - (Q(1) - Q_0)^2/(Q(2) - 2*Q(1) + Q_0); 
Q = [Q_0 Q];
Q_Hat = [Q_Hat_0 Q_Hat];


