function P = N_pdf(x,mu,sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = length(x);
a = 1./((2*pi)^(n/2) * det(sigma + 1e-10)^0.5 );
e = exp(-0.5*(x - mu) * sigma^-1 * (x - mu).');
P = a*e;
end

