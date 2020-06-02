function displayEigenface(pid)
for i = 1 : 21
    face(i,:,:) = im2double(imread(['./PIE_Nolight/',num2str(pid),'/', num2str(i), '.bmp']));
    column_vector(:,i) = face(i,:);
end
for i = 1 : 10000
    mean_vector(i,1) = mean(column_vector(i,:));
    column_vector(i,:) = column_vector(i,:) - mean_vector(i,1);
end
A = transpose(column_vector)*column_vector;
[u D]=eig(A);
v = column_vector*u;
v = normc(v);
D = diag(D);
[D I] = sort(D,'descend');
v = v(:,I);

subplot(4,6,1);
im=reshape(mean_vector,100,100);
imagesc(im); colormap gray;
axis off;axis image;
title('Mean');

for i = 1 : 21
    subplot(4,6,i+1);
    im=reshape(v(:,i),100,100);
    imagesc(im); colormap gray;
    axis off;axis image;    
    title(sprintf('V%d',i));
end