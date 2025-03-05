function [X] = TFR_pam(M,omega,opts)
% This is an pam-based algorithm for TFR minimization model

tol = 1e-8; 
max_iter = 100;
rho = 0.001;

mu = opts.mu;
alpha=opts.alpha;
p=opts.p;
b=opts.b;
dim = size(M);
X = zeros(dim);
X(omega) = M(omega);
V = zeros(dim);
X1=X;
V1=V;

for iter = 1 : max_iter
    % update V
    [V]=TFR((mu.*X+rho.*V1)./(mu+rho),1/(mu+rho),alpha,p,b);
    % update X
    X =(mu*V+rho*X1)./(mu+rho);
    X(omega) = M(omega);
    chg=norm(X(:)-X1(:), 'fro')./norm(X1(:), 'fro');
    X1=X;
    V1=V;
    if chg < tol
        break;
    end 
end

end

