X = prepareCellData();
[W V M] = FLDA(X);
column = 1;
for i = 1 : 65
    for j = 1 : 21
        if(j~=7 && j~=10 && j~=19)
            face = double(imread(['./PIE_Nolight/',num2str(i),'/',num2str(j),'.bmp']));
            testdata(:,column) = face(:);
            column = column+1;
        end
    end
end

pc = transpose(W)*transpose(V)*cell2mat(X);
t_pc = transpose(W)*transpose(V)*(testdata);

counts = 0;
for kS = 0 : 1169
    minDist = inf;
    for i = 1 : 65
        for j = 1 : 3
            x = norm(t_pc(:,kS+1)-pc(:,(i-1)*3+j));
            if x < minDist
                minDist = x;
                classLabel = i;
            end
        end
    end
    if (fix(kS/18)+1) == classLabel
        counts = counts+1;
    end
end
recogRate = counts*100/1170;
disp(sprintf('The overall recognition rate with FLDA is %f%%',recogRate));