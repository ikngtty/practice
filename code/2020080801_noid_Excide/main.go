package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"

	"github.com/ikngtty/excide/excide"
)

func main() {
	sc := NewScanner()
	n := sc.ReadInt()

	answerDigits := excide.Generate(n)

	w := bufio.NewWriter(os.Stdout)
	for _, d := range answerDigits {
		fmt.Fprint(w, strconv.Itoa(d))
	}
	fmt.Fprint(w, "\n")
	w.Flush()
}

type Scanner struct {
	bufScanner *bufio.Scanner
}

func NewScanner() *Scanner {
	bufSc := bufio.NewScanner(os.Stdin)
	bufSc.Split(bufio.ScanWords)
	bufSc.Buffer(nil, 100000000)
	return &Scanner{bufSc}
}

func (sc *Scanner) ReadInt() int {
	bufSc := sc.bufScanner
	bufSc.Scan()
	text := bufSc.Text()

	num, err := strconv.Atoi(text)
	if err != nil {
		panic(err)
	}
	return num
}
