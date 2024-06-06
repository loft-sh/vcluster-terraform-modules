package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/loft-sh/vcluster/pkg/util/translate"
)

type TestCase struct {
	ResourceName string `json:"resource_name"`
	Namespace    string `json:"namespace"`
	VclusterName string `json:"vcluster_name"`
}

func main() {
	file, err := os.Open("test_cases.json")
	if err != nil {
		log.Fatalf("failed to open test_cases.json: %v", err)
	}
	defer file.Close()

	bytes, err := ioutil.ReadAll(file)
	if err != nil {
		log.Fatalf("failed to read test_cases.json: %v", err)
	}

	var testCases []TestCase
	err = json.Unmarshal(bytes, &testCases)
	if err != nil {
		log.Fatalf("failed to unmarshal test cases: %v", err)
	}

	for _, tc := range testCases {
		expectedName := translate.SingleNamespacePhysicalName(tc.ResourceName, tc.Namespace, tc.VclusterName)
		fmt.Printf("%s %s %s %s\n", tc.ResourceName, tc.Namespace, tc.VclusterName, expectedName)
	}
}
