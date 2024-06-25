/*

Practical Artificial Intelligence with Swift

Normalization
A method applied to numerical data to bind the upper and lower bounds to a scale that will 
make them easier to work with

*/

func normalise(_ value: Double, upperBound: Double) -> Double {
        return (value / upperBound) * 1.0
    }

    // function normalizes only positive values
    // used to assess the health of fish

    length = normalise(length, upperBound: maxLength)
    weight = normalise(weight, upperBound: maxWeight)
    age = normalise(age, upperBound: theoreticalAgeLimit)
    eyesDifferent = normalise(eyesDifferent, upperBound: 2)


