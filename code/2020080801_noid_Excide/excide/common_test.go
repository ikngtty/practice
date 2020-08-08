package excide

import (
	"fmt"
	"reflect"
	"strconv"
	"testing"
)

func TestAbs(t *testing.T) {
	cases := []struct {
		n    int
		want int
	}{
		{2, 2},
		{1, 1},
		{0, 0},
		{-1, 1},
		{-2, 2},
	}

	for _, c := range cases {
		t.Run(strconv.Itoa(c.n), func(t *testing.T) {
			got := abs(c.n)
			if got != c.want {
				t.Errorf("got: %d, want: %d", got, c.want)
			}
		})
	}
}

func TestPow(t *testing.T) {
	cases := []struct {
		base     int
		exponent int
		want     int
	}{
		{5, 0, 1},
		{5, 1, 5},
		{5, 2, 25},
		{5, 3, 125},
	}

	for _, c := range cases {
		t.Run(fmt.Sprintf("%d^%d", c.base, c.exponent), func(t *testing.T) {
			got := pow(c.base, c.exponent)
			if got != c.want {
				t.Errorf("got: %d, want: %d", got, c.want)
			}
		})
	}
}

func TestReverseInts(t *testing.T) {
	cases := []struct {
		ns   []int
		want []int
	}{
		{nil, nil},
		{[]int{}, []int{}},
		{[]int{5}, []int{5}},
		{[]int{4, 2}, []int{2, 4}},
		{[]int{42, 25, 36}, []int{36, 25, 42}},
	}

	for _, c := range cases {
		t.Run(fmt.Sprintf("%#v", c.ns), func(t *testing.T) {
			got := reverseInts(c.ns)
			if !reflect.DeepEqual(got, c.want) {
				t.Errorf("got: %#v, want: %#v", got, c.want)
			}
		})
	}
}

func TestBreakUpDigits(t *testing.T) {
	cases := []struct {
		n    int
		want []int
	}{
		{0, []int{0}},
		{1, []int{1}},
		{425, []int{4, 2, 5}},
	}

	for _, c := range cases {
		t.Run(strconv.Itoa(c.n), func(t *testing.T) {
			got := breakUpDigits(c.n)
			if !reflect.DeepEqual(got, c.want) {
				t.Errorf("got: %#v, want: %#v", got, c.want)
			}
		})
	}
}
