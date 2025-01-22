class predictive_coding_tinnitus_model
    % Main function - users can change the states of the model from here
    % params include:
    % =====================================================================
    % num_channels = sets the number of channels of the tonotopic map
    % external_sound = example of an external sound (must be 1x32)
    % experiment_5_custom_priors = example of custom priors (must be 1x32)
    % channel_inputs = external sound is inputted (zeros(1,32) - no sound)
    % for each channel
    % prior_values = sets the maximum prior values for each channel
    % phantom_sound = helps user if they do not know how to set custom 
    % priors (will change prior value to 1 if less than 0.5) (bool) for
    % each channel 
    % continuous_sound = sets prior values to constant or a curve depending
    % on value (bool) for each channel
    % custom_prior_set = set custom priors (1x32) for each channel
    % =====================================================================

    % set number of tonotopic map channels
    % ---------------------------------------------------------------------
    num_channels    = 5;

    % example external sound
    external_sound = exp(-((1:32) - 32/2).^2/(4.^2))*4;

    % values for experiment 4
    experiment4_custom_priors = zeros(1, 32); 
    experiment4_custom_priors(1,1:6) = linspace(0, 1, 6);
    experiment4_custom_priors(1,7:16) = ones(1, 10);
    experiment4_custom_priors(1,17:22) = linspace(1, 0, 6);
    experiment4_custom_priors(1,23:end) = 0;
    
    % set external sounds
    % ---------------------------------------------------------------------
    channel_inputs = [zeros(1,32); external_sound; zeros(1,32); zeros(1,32); external_sound];
    try
        if numel(channel_inputs) < num_channels
             error('Insufficient channel inputs for number of channels.');
        end
    catch e
        fprintf('Exception: %s\n', e.message);
        msgbox(e.message);
        return;
    end
    %check to see if each element in custom priors is of the correct length
    for i = 1:num_channels
        try
            if numel(channel_inputs(i,:)) ~= 32 
                error(['Incorrect channel input format for channel ' num2str(i)]);
            end
        catch e
            fprintf('Exception: %s\n', e.message);
            msgbox(e.message);
            return;
        end
    end
  
    % set prior values 
    % ---------------------------------------------------------------------
    prior_values= [0, 0, 1, 1, 1];
    try
        if numel(prior_values) < num_channels
            error('Insufficient prior values for number of channels.');
        end
    catch e
        fprintf('Exception: %s\n', e.message);
        msgbox(e.message);
        return;
    end

    % sets priors to strong, thereby creating a phantom internal sound
    phantom_sound = [false, false, true, true, true];
    try
        if numel(phantom_sound) < num_channels
            error('Insufficient phantom sound options for number of channels.');
        end
    catch e
        fprintf('Exception: %s\n', e.message);
        msgbox(e.message);
        return;
    end

    % sets this phantom sound to a more continuous sound or a short 'burst'
    continuous_sound = [true true, true, false, true];
    try
        if numel(continuous_sound) < num_channels
            error('Insufficient continuous sound options for number of channels.');
        end
    catch e
        fprintf('Exception: %s\n', e.message);
        msgbox(e.message);
        return;
    end
    
    % set custom prior values 
    % ---------------------------------------------------------------------
    custom_prior_set = [zeros(1,32); zeros(1,32); zeros(1,32); experiment4_custom_priors; zeros(1,32)];
    try
        if numel(custom_prior_set) < num_channels
            error('Insufficient custom prior options for number of channels.');
        end
    catch e
        fprintf('Exception: %s\n', e.message);
        msgbox(e.message);
        return;
    end
    %check to see if each element in custom priors is of the correct length
    for i = 1:num_channels
        try
            if numel(custom_prior_set(i,:)) ~= 32 
                error(['Incorrect cutsom prior format for channel ' num2str(i)]);
            end
        catch e
            fprintf('Exception: %s\n', e.message);
            msgbox(e.message);
            return;
        end
    end

    test_results = run(test_user_inputs);

    % generate figures for each channel of tonotopic map
    % ---------------------------------------------------------------------
    for i = 1:num_channels
            generate_internal_figures(num_channels, i, channel_inputs(i,:), prior_values(i), phantom_sound(i), continuous_sound(i), custom_prior_set(i,:));
    end

    % close all SPM generated figures
    % ---------------------------------------------------------------------   
    select_on = 'SPM'; 
    all_figs = findobj('Type', 'figure'); % get all figures
    for i = 1:length(all_figs)
    if contains(all_figs(i).Name, select_on) % check if the figure name contains 'SPM'
        close(all_figs(i)); % close the figure
    end
end
