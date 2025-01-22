classdef test_user_inputs < matlab.unittest.TestCase

    properties
        
    end
    
    methods(Test) 
        
        function test_channel_inputs(testCase)
            num_channels = 1000;
            channel_inputs = [zeros(1,32); zeros(1,32); zeros(1,32); zeros(1,32)];
            input_error_thrown=false;
            try
                if numel(channel_inputs) < num_channels
                     error('Insufficient channel inputs for number of channels.');
                     input_error_thrown=true;
                end
                verifyTrue(testCase, testCase.input_error_thrown,'Test failed: did not raise error for insufficient channel inputs.');
            catch e
                % Check that the error message is correct
                expectedErrorMessage = 'Insufficient channel inputs for number of channels.';
                verifyEqual(testCase, e.message, 'Insufficient channel inputs for number of channels.','Test failed: incorrect error message.')
            end
        end
        
        function test_prior_values(testCase)
            num_channels = 1000;
            prior_values= [0, 0, 1, 1, 1];
            prior_input_error_thrown=false;
            try
                if numel(prior_values) < num_channels
                     error('Insufficient prior values for number of channels.');
                     prior_input_error_thrown=true;
                end
                verifyTrue(testCase, testCase.prior_input_error_thrown,'Test failed: did not raise error for insufficient prior values.');
            catch e
                % Check that the error message is correct
                expectedErrorMessage = 'Insufficient prior values for number of channels.';
                verifyEqual(testCase, e.message, 'Insufficient prior values for number of channels.','Test failed: incorrect error message.')
            end
        end

        function test_phantom_options(testCase)
            num_channels = 1000;
            phantom_sound = [false, false, true, true, true];
            phantom_input_error_thrown=false;
            try
                if numel(phantom_sound) < num_channels
                     error('Insufficient phantom sound options for number of channels.');
                     phantom_input_error_thrown=true;
                end
                verifyTrue(testCase, testCase.phantom_input_error_thrown,'Test failed: did not raise error for insufficient phantom sound options.');
            catch e
                % Check that the error message is correct
                expectedErrorMessage = 'Insufficient phantom sound options for number of channels.';
                verifyEqual(testCase, e.message, 'Insufficient phantom sound options for number of channels.','Test failed: incorrect error message.')
            end
        end

        function test_continuous_options(testCase)
            num_channels = 1000;
            continuous_sound = [true true, true, false, true];
            continuous_input_error_thrown=false;
            try
                if numel(continuous_sound) < num_channels
                     error('Insufficient continuous sound options for number of channels.');
                     continuous_input_error_thrown=true;
                end
                verifyTrue(testCase, testCase.continuous_input_error_thrown,'Test failed: did not raise error for insufficient continuous sound options.');
            catch e
                % Check that the error message is correct
                expectedErrorMessage = 'Insufficient continuous sound options for number of channels.';
                verifyEqual(testCase, e.message, 'Insufficient continuous sound options for number of channels.','Test failed: incorrect error message.')
            end
        end

        function test_custom_prior_options(testCase)
            num_channels = 1000;
            custom_prior_set = [zeros(1,32); zeros(1,32); zeros(1,32); zeros(1,32)];
            custom_input_error_thrown=false;
            try
                if numel(custom_prior_set) < num_channels
                     error('Insufficient custom prior options for number of channels.');
                     custom_input_error_thrown=true;
                end
                verifyTrue(testCase, testCase.custom_input_error_thrown,'Test failed: did not raise error for insufficient custom prior options.');
            catch e
                % Check that the error message is correct
                expectedErrorMessage = 'Insufficient custom prior options for number of channels.';
                verifyEqual(testCase, e.message, 'Insufficient custom prior options for number of channels.','Test failed: incorrect error message.')
            end
        end
    end
end