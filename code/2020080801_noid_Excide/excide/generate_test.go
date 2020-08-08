package excide

import (
	"fmt"
	"reflect"
	"testing"
)

func TestGenerate(t *testing.T) {
	const maxDigit = 7
	maxN := pow(10, maxDigit)
	maxExcide := pow(2, maxDigit-1)
	// The excide of `n` over `maxN` is always higher than `maxExcide`.

	isExcideFound := make([]bool, maxExcide+1)
	for n := 10; n < maxN; n++ {
		nDigits := breakUpDigits(n)
		excide := Compute(nDigits)
		if excide < 0 || excide > maxExcide {
			continue
		}

		isExcideFound[excide] = true
	}

	for excide := 2; excide <= maxExcide; excide++ {
		t.Run(fmt.Sprintf("excide:%d", excide), func(t *testing.T) {
			got := Generate(excide)
			if reflect.DeepEqual(got, []int{-1}) {
				if isExcideFound[excide] {
					t.Error("got -1, but actually some excite number exists")
				}
			} else {
				excideOfGenerated := Compute(got)
				if excideOfGenerated != excide {
					t.Errorf("got %#v, but its excide is %d", got, excideOfGenerated)
				}
			}
		})
	}
}
