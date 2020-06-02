mint = -inf;
for esfds = 1 : 195
    recogRate = recog_pca(esfds);
    if recogRate>mint
        index = esfds;
        mint = recogRate;
    end
end
disp(sprintf('K = %d%%',index));