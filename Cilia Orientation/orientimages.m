function imgfinal = orientimages(Img,revflip)
 if (revflip == "xdir")
   imgfinal = flip(Img ,2);
 elseif(revflip == "ydir")
     imgfinal = flip(Img ,1);
 elseif(revflip == "bothdir")
     im1 = flip(Img ,1);           %# vertical flip
     imgfinal = flip(im1,2);
 end