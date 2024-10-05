function RGB=colormap2(canvas3,R,G,B)
%R   = 1;  % Value in range [0, 1]
%G   = 0;
%B   = 0;
RGB = cat(3, canvas3 * R, canvas3 * G, canvas3 * B);
figure;imshow(RGB)
end