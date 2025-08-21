function PartB_Circle_Detection()
    % Step 1: Read the image
    [filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files'}, 'Select an image');
    if isequal(filename, 0)
        disp('User selected Cancel');
        return;
    end
    full_filename = fullfile(pathname, filename);
    img = imread(full_filename);

    % Step 2: Display the original image
    figure;
    imshow(img);
    title('Original Image');

    % Step 3: Check if the image is grayscale or RGB
    if size(img, 3) == 3
        % Convert to grayscale if the image is RGB
        gray_image = im2gray(img);
    else
        % If the image is already grayscale, use it directly
        gray_image = img;
    end

    % Step 4: Display the grayscale image
    figure;
    imshow(gray_image);
    title('Grayscale Image');

    % Step 5: Determine radius for searching circle (optional, interactive
    % d = drawline;
    % pos = d.Position;
    % diffPos = diff(pos);
    % diameter = hypot(diffPos(1), diffPos(2));
    % radiusRange = [round(diameter/4) round(diameter/2)]; % Example radius range
    radiusRange = [20 25]; % Default range

    % Step 6: Detect dark circles
    [darkCenters, darkRadii] = imfindcircles(gray_image, radiusRange, ...
        'ObjectPolarity', 'dark', 'Sensitivity', 0.94, 'EdgeThreshold', 0.1);

    % Step 7: Detect light circles
    [lightCenters, lightRadii] = imfindcircles(gray_image, radiusRange, ...
        'ObjectPolarity', 'bright', 'Sensitivity', 0.93, 'EdgeThreshold', 0.1);

    % Step 8: Combine results
    Centers = [darkCenters; lightCenters];
    Radii = [darkRadii; lightRadii];

    % Step 9: Display results with detected circles
    figure; % Create a new figure for the detected circles
    imshow(img);
    hold on;

    % Plot dark circles in blue
    if ~isempty(darkCenters)
        viscircles(darkCenters, darkRadii, 'EdgeColor', 'b');
    end

    % Plot light circles in red
    if ~isempty(lightCenters)
        viscircles(lightCenters, lightRadii, 'EdgeColor', 'r');
    end

    title('Detected Circles');
    hold off;

    % Step 10: Show the number of detected circles in a pop-up dialog
    numDarkCircles = length(darkRadii);
    numLightCircles = length(lightRadii);
    totalCircles = numDarkCircles + numLightCircles;

    message = sprintf('Number of dark circles detected: %d\nNumber of light circles detected: %d\nTotal circles detected: %d', ...
        numDarkCircles, numLightCircles, totalCircles);
    msgbox(message, 'Detection Result');

    % Optional: Print details of detected circles in the command window
    for i = 1:numDarkCircles
        fprintf('Dark Circle %d: Center = (%.2f, %.2f), Radius = %.2f\n', i, darkCenters(i,1), darkCenters(i,2), darkRadii(i));
    end

    for i = 1:numLightCircles
        fprintf('Light Circle %d: Center = (%.2f, %.2f), Radius = %.2f\n', i, lightCenters(i,1), lightCenters(i,2), lightRadii(i));
    end
end