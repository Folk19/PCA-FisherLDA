function X = prepareCellData()
for i = 1 : 65
    face = [];
    temp = double(imread(['./PIE_Nolight/',num2str(i),'/7.bmp']));
    face(:,1) = temp(:);
    temp = double(imread(['./PIE_Nolight/',num2str(i),'/10.bmp']));
    face(:,2) = temp(:);
    temp = double(imread(['./PIE_Nolight/',num2str(i),'/19.bmp']));
    face(:,3) = temp(:);
    X(i) = {face};
end