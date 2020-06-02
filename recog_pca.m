function recogRate = recog_pca(k)

for i = 1 : 65
    face = im2double(imread(['./PIE_Nolight/',num2str(i),'/7.bmp']));
    training(:,(i-1)*3+1) = face(:);
    face = im2double(imread(['./PIE_Nolight/',num2str(i),'/10.bmp']));
    training(:,(i-1)*3+2) = face(:);
    face = im2double(imread(['./PIE_Nolight/',num2str(i),'/19.bmp']));
    training(:,(i-1)*3+3) = face(:);
end

column = 1;
for i = 1 : 65
    for j = 1 : 21
        if(j~=7 && j~=10 && j~=19)
            face = im2double(imread(['./PIE_Nolight/',num2str(i),'/',num2str(j),'.bmp']));
            testdata(:,column) = face(:);
            column = column+1;
        end
    end
end

for i = 1 : 10000
    m_training(i,1) = mean(training(i,:));
    a_m_training(i,:) = training(i,:) - m_training(i,1); % m
    a_m_testdata(i,:) = testdata(i,:) - m_training(i,1); % m
end

A = transpose(a_m_training)*a_m_training;
[u D]=eig(A);
v = a_m_training*u;
v = normc(v);
D = diag(D);
[D I] = sort(D,'descend'); %eig vector
v = v(:,I); %eig face

pc = transpose(v(:,1:k))*(a_m_training);
t_pc = transpose(v(:,1:k))*(a_m_testdata);

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
disp(sprintf('Recognition rate = %f%%',counts*100/1170));
recogRate = counts/1170;