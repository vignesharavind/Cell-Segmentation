%% Using filter to despeckle if needed
J=uint8(BW.*255);
K = wiener2(J,[24 24]);
Kmedian = medfilt2(J);
figure;imshowpair(K,J,'montage')
figure;imshowpair(Kmedian,J,'montage')
%%
kind =find(K<80);
K2=K; K2(kind)=0;
figure;imshow(K2)
K3=logical(K2);
figure;imshow(K3)