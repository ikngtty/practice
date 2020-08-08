package excide

import "fmt"

func abs(n int) int {
	if n < 0 {
		return -1 * n
	}
	return n
}

func pow(base, exponent int) int {
	if exponent < 0 {
		panic(fmt.Sprintf("exponent (%d) should not be a minus", exponent))
	}

	answer := 1
	for i := 0; i < exponent; i++ {
		answer *= base
	}
	return answer
}

func reverseInts(ns []int) []int {
	if ns == nil {
		return nil
	}

	reversed := make([]int, len(ns))
	for i := 0; i < len(ns); i++ {
		reversed[i] = ns[len(ns)-1-i]
	}
	return reversed
}

func breakUpDigits(n int) []int {
	if n < 0 {
		panic(fmt.Sprintf("n (%d) should not be a minus", n))
	}
	if n == 0 {
		return []int{0}
	}
	reversedDigits := make([]int, 0)
	for n > 0 {
		reversedDigits = append(reversedDigits, n%10)
		n /= 10
	}
	return reverseInts(reversedDigits)
}
