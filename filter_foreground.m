

function[fgImg] = filter_foreground(fgImg)

    % Apply morphological operations to remove noise and fill in holes.
    fgImg = imclose(imopen(fgImg,strel('square',3)),strel('square',5));
    fgImg = imopen(fgImg, strel('rectangle', [3,3]));
    fgImg = imclose(fgImg, strel('rectangle', [15, 15]));
    fgImg = imfill(fgImg, 'holes');

end