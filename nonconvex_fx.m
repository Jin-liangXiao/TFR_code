function [y] = nonconvex_fx(x,alpha,p,b)
y=b.*x.^p./(1./alpha+x.^p);
end

