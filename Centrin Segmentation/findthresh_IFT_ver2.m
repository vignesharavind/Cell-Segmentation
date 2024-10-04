function BW = findthresh_IFT_ver2(grayImage,thr)
grayImage(find(grayImage< round(max(grayImage,[],'all')*thr)))=0; %0.4 works for control
BW = imbinarize(grayImage, 'adaptive', 'Sensitivity', 0.00000, 'ForegroundPolarity', 'bright');
figure;imshow(BW)
figure;imshowpair(grayImage,BW)
%figure;imshowpair(I11,BW)
end