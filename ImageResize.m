function [ newImage ] = ImageResize( oldImage, resizeValue )

[y, x] = size(oldImage);

if x > y
    oldImage = imresize(oldImage, [(resizeValue*y)/x, resizeValue]);
    [y, x] = size(oldImage);

    sideBarSize = (resizeValue-y)/2;
    if floor(sideBarSize) == sideBarSize
        sidePanel1 = zeros(sideBarSize, resizeValue, 'uint8');
        sidePanel2 = zeros(sideBarSize, resizeValue, 'uint8');
    else
       sidePanel1 = zeros(ceil(sideBarSize), resizeValue, 'uint8');
       sidePanel2 = zeros(floor(sideBarSize), resizeValue, 'uint8');
    end

    newImage = [sidePanel1; oldImage; sidePanel2];
else
    oldImage = imresize(oldImage, [resizeValue, (resizeValue*x)/y]);
    [y, x] = size(oldImage);
    
    sideBarSize = (resizeValue-x)/2;
    if floor(sideBarSize) == sideBarSize
        sidePanel1 = zeros(resizeValue, sideBarSize, 'uint8');
        sidePanel2 = zeros(resizeValue, sideBarSize, 'uint8');
    else
       sidePanel1 = zeros(resizeValue, ceil(sideBarSize), 'uint8');
       sidePanel2 = zeros(resizeValue, floor(sideBarSize), 'uint8');
    end
    
    newImage = [sidePanel1, oldImage, sidePanel2];
end

end

