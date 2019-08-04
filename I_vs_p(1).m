clear all;
close all;

%pvals = 1:100:2001;
pvals = 1:1:20;
I_p = [];
for p=pvals
   f = @(x) sin(log(x)./(x.^(p)))./x;
   I = 0;
   a = [];
   temp = 0;
   Q = [];
   for k = 1:2000
       b = fzero( @(x) x*exp(p*x)-k*pi , 0);
       a = [a exp(-b)];
       if k==1
           I = I + integral(f,a(k),1);
           Q_0 = I;
       else
           I = I + integral(f, a(k),a(k-1));
           Q = [Q I];
       end
   end
   I_p = [I_p I];
end

% this is for the curve fitting
c = polyfit(log(pvals), log(abs(I_p)), 1);
xx = pvals;
yy = polyval(c, log(xx) );

% this is for the plotting
scatter(pvals,I_p );
hold on;
plot(xx, -exp(yy))
set(gca,'yscale','log')
set(gca,'xscale','log')
title('I(p) v.s. p');
ylabel('I(p)');
xlabel('p');