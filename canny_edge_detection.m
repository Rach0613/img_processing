clc;
clear all;
close all;
warning off;

% Initialize the webcam
c = webcam;

% Display instructions on command window
disp('Press "q" in the figure window to terminate the program.');

% Create a figure for real-time display
hFig = figure('Name', 'Real-Time Edge Detection', 'NumberTitle', 'off');

while ishandle(hFig) 
    x = c.snapshot;

    a = rgb2gray(x);

    a = imgaussfilt(a, 2); 

    w = edge(a, 'canny');

    subplot(1, 2, 1);
    imshow(x);
    title('Original Image');

    subplot(1, 2, 2);
    imshow(w);
    title('Canny Edge Detection');

    % Checks if the user pressed the 'q' key to terminate
    if strcmp(get(hFig, 'CurrentKey'), 'q')
        disp('Program terminated by user.');
        break;
    end
    
    % Pauses briefly to allow the figure to update
    pause(0.1);
end

% Releases the webcam and close all figures
clear c;
close all;