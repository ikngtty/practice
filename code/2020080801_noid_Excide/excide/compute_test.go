package excide

import (
	"fmt"
	"testing"
)

func TestCompute(t *testing.T) {
	cases := []struct {
		n    []int
		want int
	}{
		{[]int{9}, -1},
		{[]int{1, 3, 4}, -1},
		{[]int{9, 7}, 2},
		{[]int{4, 6, 1}, 10},
		{[]int{4, 6, 1, 9}, 80},
		// TODO: overflow pattern
	}

	for _, c := range cases {
		t.Run(fmt.Sprintf("%#v", c.n), func(t *testing.T) {
			got := Compute(c.n)
			if got != c.want {
				t.Errorf("got: %d, want: %d", got, c.want)
			}
		})
	}
}
