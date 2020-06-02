function [W V M] = FLDA(X)
Xmat = cell2mat(X);
M = mean(Xmat,2);
for i = 1:10000
    Xmat(i,:) = Xmat(i,:) - M(i,1);
end
a = Xmat'*Xmat;
[u D]=eig(a);
V = Xmat*u;
V = normc(V);
D = diag(D);
[D I] = sort(D,'descend');
V = V(:,I);
V = V(:,1:130);

for i = 1:65
    reduce{i} = transpose(V)*X{i};
    Cmean{i} = mean(reduce{i},2);
end
temp = cell2mat(Cmean);
globalmean = mean(temp,2);

% FLDA
SB = zeros(130,130);
SW = zeros(130,130);
for i = 1:65
    SB = SB + (cell2mat(Cmean(i))-globalmean)*(cell2mat(Cmean(i))-globalmean)';
end
for i = 1:65
    for j = 1:3
        SW = SW + (reduce{i}(:,j)-Cmean{i})*(reduce{i}(:,j)-Cmean{i})';
    end
end
v = inv(SW)*SB;
[W landa]=eig(v);
landa = diag(landa);
[landa I] = sort(landa,'descend');
W = W(:,I); 
W = W(:,1:64);