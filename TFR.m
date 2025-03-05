function [X] = TFR(Y,rho,alpha,p,b)
%% arg y min (1/2)||y-x||_F^2 + rho*||y||_TFR
[n1,n2,n3] = size(Y);
X = zeros(n1,n2,n3);
for i = 1 : n3
    [U,S,V] = svd(Y(:,:,i),'econ');
    S = diag(S);
    S1=S;
    for j=1:4
    gra=p.*b./(alpha.*((1./alpha+S.^p).^2).*(S.^(1-p)));
    S=S1-rho*gra;
    S(S<0)=0;
    end
    F0=0.5*S1.^2;
    F1=rho.*nonconvex_fx(S,alpha,p,b)+0.5*(S1-S).^2;
    mask=double(F0<F1);
    S2=0.*mask+S.*(1-mask);
    X(:,:,i) = U*diag(S2)*V';
end


end

