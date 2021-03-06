%Verdier for oppgave 1
h = 6.62607004*10^-34;
c = 10^8;
eV = 1.6*10^-19;
Ek = 60*eV; %eV
lambda = (h*c/Ek);%B�lgelengden

%Verdier for oppgave 2

l = [0 0.1 0.11 0.21];
t = l./c;
my = [20 600 20 20];
% finner intensiteter
% I0 = 1;
% I1 = I0*exp((-(t(2)-t(1))*my(1)));
% I2 = I1*exp((-(t(3)-t(2))*my(2)));
% I3 = I2*exp((-(t(4)-t(3))*my(1)));
I0 = 1;
I = ones(1,length(t))*I0;
for i = 1:length(t)-1
    I(i+1)=I(i)*exp(-(t(i+1)-t(i))*my(i));
end
% finner projeksjonen 
p = log(I(1)/I(4));
%det har ingenting � si om man f�rst g�r gjennom bein ogs� bl�tt ved
%eller motsatt fordi addisjonens rekkef�lge er irrelevant