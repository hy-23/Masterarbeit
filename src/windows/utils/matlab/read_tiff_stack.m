function M = read_tiff_stack(filename)

info            = imfinfo(filename);
frames          = length(info);
width           = info.Width;
height          = info.Height;
tiff_link       = Tiff(filename,'r');
no_of_channels  = info.SamplesPerPixel;

if(no_of_channels == 3)
    M           = uint8(zeros(height, width, no_of_channels, frames));
else
    M           = uint8(zeros(height, width, frames));
end

for i = 1:frames
     tiff_link.setDirectory(i);
     if (no_of_channels == 3)
         M(:,:,:,i) = uint8(tiff_link.read());
     else
         M(:,:,i) = uint8(tiff_link.read());
     end
end
end