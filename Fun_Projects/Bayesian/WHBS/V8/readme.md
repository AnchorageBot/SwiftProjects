8th Draft

- - - -

Abstract:

This test suite validates the core functionality of the BayesCalculator
app, including probability calculations, data validation, and formatting
helpers. It ensures accurate Bayesian analysis calculations and proper
handling of edge cases.

- - - -

Test results:

* testRoomDataValidation(): Expectation failed: (negativeNoise.noise → -5.0) == (0 → 0.0)
Negative noise should be set to 0

* testRoomDataValidation(): Expectation failed: (negativeNoNoise.noNoise → -15.0) == (0 → 0.0)
Negative no-noise should be set to 0

* testEdgeCases(): Expectation failed: (calculator.results.priorB → 0.8823529411764706) == (0 → 0.0)
Prior should be 0 with no observations

* testEdgeCases(): Expectation failed: (calculator.results.likelihoodNB → 0.1) == (0 → 0.0)
Likelihood should be 0 with no observations

* testEdgeCases(): Expectation failed: (calculator.results.posteriorBN → 0.7500000000000001) == (0 → 0.0)
Posterior should be 0 with no observations



