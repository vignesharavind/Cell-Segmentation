function h4 = quantumwatershed(h3)
D = -bwdist(~h3);
D(~h3) = -Inf;
figure; imshow(D,[])
Ld = watershed(D);
figure;imshow(label2rgb(Ld))
h4=h3;
h4(Ld==0)=0;
figure; imshow(h4)
end
