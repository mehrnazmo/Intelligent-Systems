function [image,padded,enhanced_image] = AHE(im,win_size)
image = imread(im);
imshow(image);
r = floor(win_size/2);
padded = padarray(image,[r,r],'symmetric','both');
enhanced_image = zeros(size(image,1),size(image,2));
for x=1+r:size(padded,1)-r
    for y=1+r:size(padded,2)-r
        rank = 0;
        contextual_region = padded(x-r:x+r,y-r:y+r);
        for i=1:size(contextual_region,1)-1
            for j=1:size(contextual_region,2)-1
                if padded(x,y) > padded(i+x-r-1,j+y-r-1)
                    rank = rank+1;
                end
            end
        end
        enhanced_image(x-r,y-r) = double(rank*255)/double(win_size*win_size);
    end
end
figure();
imshow(enhanced_image,[0,255]);

%% Histogram Equilization (HE)
mx = double(max(max(image)));
mn = double(min(min(image)));
r = 255/(mx-mn);
image_HE = (r*image - 255*mn/(mx-mn));
figure();
imshow(image_HE,[0,255]);
figure();
imshow(image,[0,255]);

end


