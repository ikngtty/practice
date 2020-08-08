package excide

func Generate(excide int) []int {
	primeCounts := []*numCount{{7, 0}, {5, 0}, {3, 0}, {2, 0}}
	for _, primeCount := range primeCounts {
		for excide%primeCount.Num == 0 {
			excide /= primeCount.Num
			primeCount.Count++
		}
	}

	if excide > 1 {
		return []int{-1}
	}

	totalCount := 0
	for _, primeCount := range primeCounts {
		totalCount += primeCount.Count
	}

	exciteNumber := make([]int, totalCount+1)
	exciteNumber[0] = 1
	pos := 1
	sign := 1
	for _, primeCount := range primeCounts {
		for i := 0; i < primeCount.Count; i++ {
			exciteNumber[pos] = exciteNumber[pos-1] + sign*primeCount.Num
			pos++
			sign *= -1
		}
	}
	return exciteNumber
}

type numCount struct {
	Num   int
	Count int
}
