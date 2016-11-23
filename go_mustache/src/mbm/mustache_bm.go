package main

import (
	"fmt"
	"os"
	"strconv"
	"io/ioutil"
	"encoding/json"
	"github.com/cbroglie/mustache"
	"time"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	dataFile := os.Args[1]
	bindingsFile := os.Args[2]
	numTests, err := strconv.Atoi(os.Args[3])
	if err != nil {
		fmt.Println(err)
		os.Exit(2)
	}
	fmt.Printf("do_test %s %s %d\n", dataFile, bindingsFile, numTests)

	dataBin, err := ioutil.ReadFile(dataFile)
	check(err)
	data := string(dataBin)

	bindingsBin, err2 := ioutil.ReadFile(bindingsFile)
	check(err2)

	var bindings map[string]interface{}
	err3 := json.Unmarshal(bindingsBin, &bindings)
	check(err3)

	t1 := time.Now()
	for i := 0; i < numTests; i++ {
		_, err4 := mustache.Render(data, bindings)
		check(err4)
	}
	t2 := time.Now()
	diff := t2.Sub(t1)
	fmt.Println(diff)
}
