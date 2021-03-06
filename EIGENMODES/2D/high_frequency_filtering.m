
function pass_fail = high_frequency_filtering(field, mask, threshold)
    
    % this function helps filter out modes with feature scales below the
    % viable grid resolution

    pass_fail = 1;
    if(nargin<3)
       threshold = 0.5; 
    end
    %this is a grid with only the fields within the structure preserved
    fields_grid = real((mask==1).*field);
    
    %cycle through up down left right and calculate the difference in field
    for i = [-1,1]
        for j = [-1,1]
            difference = abs(fields_grid-circshift(fields_grid,[i,j]))./abs(fields_grid);
            
            
            restricted_difference = difference(mask == 1);
            if(mean(difference) > threshold)
                pass_fail = 0;
            end
            
        end
    end


end