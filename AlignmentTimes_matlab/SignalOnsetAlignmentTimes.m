function [Alignment_Times] = SignalOnsetAlignmentTimes(xds, target_dir, target_center, event)

%% Basic settings, some variable extractions, & definitions

% Window to calculate the cursor onset
half_window_size = 1; % Bins
step_size = 1; % Bins

%% Extract the signal corresponding to the event
[Signal, Timing] = Extract_Signal(xds, target_dir, target_center, event);

%% Defines onset time via the maximum of the signal

Signal_onset_idx = zeros(length(Signal),1);
% Loop through each trial
for ii = 1:length(Signal)
    [sliding_avg, ~, ~] = Sliding_Window(Signal{ii,1}, half_window_size, step_size);
    % Find the peak cursor position
    temp_1 = find(sliding_avg == max(sliding_avg));
    % Find the onset of this peak
    temp_2 = find(Signal{ii,1}(1:temp_1) < prctile(Signal{ii,1}, 15));
    if isempty(temp_2)
        temp_2 = find(Signal{ii,1}(1:temp_1) == min(Signal{ii,1}(1:temp_1)));
    end
    Signal_onset_idx(ii,1) = temp_2(end);
end

%% Convert the onset_time_idx array into actual timings in seconds

Alignment_Times = zeros(length(Timing),1);
for ii = 1:length(Timing)
    Alignment_Times(ii) = Timing{ii, 1}(Signal_onset_idx(ii));
end





