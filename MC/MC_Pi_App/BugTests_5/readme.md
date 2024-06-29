5. Accessibility Testing:

* Ensure your app works well with VoiceOver and other accessibility features

- - - -

# Monte Carlo Pi Estimation App - Accessibility Testing Guide

This guide provides instructions on how to test accessibility features for the Monte Carlo Pi Estimation app, with a focus on VoiceOver compatibility.

## Testing Accessibility Features

### Enable VoiceOver

1. On your iOS device or simulator, go to Settings > Accessibility > VoiceOver.
2. Turn on VoiceOver.

### Run Accessibility Audit

1. Open your project in Xcode.
2. Build and run your app on a simulator or device.
3. In Xcode, go to Xcode > Open Developer Tool > Accessibility Inspector.
4. In the Accessibility Inspector, select your running app from the target menu.
5. Click the Audit tab.
6. Click Run Audit to check for basic accessibility issues.

### Manual VoiceOver Testing

1. With your app running and VoiceOver enabled, swipe right to move through elements.
2. Listen to how VoiceOver reads each element.
3. Double-tap to activate buttons.

### Key Areas to Test

1. **Pi Estimation Display**
   - Swipe to the Pi estimation text.
   - Verify that VoiceOver reads "Estimated value of pi" followed by the current value.

2. **Scatter Plot**
   - Swipe to the scatter plot.
   - Verify that VoiceOver reads "Monte Carlo simulation scatter plot" and provides the hint about its purpose.

3. **Run Simulation Button**
   - Swipe to the "Run Simulation" button.
   - Verify that VoiceOver reads the button label and the hint about running the simulation.
   - Double-tap to activate and verify that VoiceOver announces the updated Pi estimation.

4. **Toggle Context Button**
   - Swipe to the "Simulation Context" or "Show Simulation" button.
   - Verify that VoiceOver reads the correct label and hint based on the current state.
   - Double-tap to toggle and verify that VoiceOver announces the view change.

5. **Context View**
   - When in the context view, swipe through all elements.
   - Verify that all text is properly read by VoiceOver.

### Act on Results

1. If VoiceOver skips any elements, add appropriate accessibility labels.
2. If any element's purpose is unclear, add or refine accessibility hints.
3. Ensure that all interactive elements can be activated via VoiceOver.
4. If the scatter plot is not sufficiently descriptive, consider adding a summary of the results that's accessible to VoiceOver users.

## Additional Accessibility Considerations

1. **Color Contrast**: Use the Accessibility Inspector to verify sufficient color contrast for text and important UI elements.

2. **Dynamic Type**: Test your app with different text sizes in Settings > Accessibility > Display & Text Size > Larger Text.

3. **Reduce Motion**: Test your app with Reduce Motion enabled in Settings > Accessibility > Motion.

Remember, accessibility is an ongoing process. Regularly test your app with VoiceOver and other accessibility features as you develop new functionalities.
