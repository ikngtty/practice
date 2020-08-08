package excide

func Compute(n []int) int {
	if len(n) < 2 {
		return -1
	}
	excide := 1
	for i := 1; i < len(n); i++ {
		diff := abs(n[i] - n[i-1])
		if diff <= 1 {
			return -1
		}

		excide *= diff
	}
	return excide
}
