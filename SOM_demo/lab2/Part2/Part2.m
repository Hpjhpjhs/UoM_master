[imgs, training] = lab_featuresets('Image\',-1);

som_gui;

%imagedata without RGB
load imgs.mat;
load noRGB-features.mat;
load som_noRGB.mat;
som_show(som_noRGB,'umat','all');
lab_showsimilar(imgs, training, som_noRGB.codebook,1);

%data with RGB
load imgs.mat;
load full-featured-imgs.mat;
load som_RGB.mat;
som_show(som_RGB,'umat','all');
lab_showsimilar(imgs, training, som_RGB.codebook,1);