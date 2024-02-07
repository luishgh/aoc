package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"strings"
)

func printUsage() {
	fmt.Println("TODO!")
}

var homeDir = os.Getenv("HOME")

var pFlag = flag.String("aoc-path", filepath.Join(homeDir, "Projects/Code/aoc"), "Path to AOC root folder")

var noExample = flag.Bool("no-example", false, "Disable testing the example")

var verbose = flag.Bool("verbose", false, "Enable logging")

type Problem struct {
	year int
	day int
}

func (p Problem) String() string {
	return fmt.Sprintf("%d/%d", p.year, p.day)
}

// TODO: do better error handling, the program should not silently fail if --verbose is not present
func (p Problem) RunCommand(cmd *exec.Cmd, inputFile string, expectedOutputFile *string) {

	inputBytes, err := ioutil.ReadFile(inputFile)
	if err != nil {
		log.Fatalf("Error reading input file: %v", err)
	}
	cmd.Stdin = strings.NewReader(string(inputBytes))

	outputBytes, err := cmd.Output()
	if err != nil {
		log.Fatalf("Error running compiled file: %v", err)
	}

	if expectedOutputFile != nil {
		// Check if expectedOutputFile exists
		if _, err := os.Stat(*expectedOutputFile); err != nil {
			log.Fatalf("expected output file %s does not exist", *expectedOutputFile)
		}

		// Compare actual output to expected output
		diffCmd := exec.Command("diff", "-u", *expectedOutputFile, "-")
		diffCmd.Stdin = strings.NewReader(string(outputBytes))
		diffOutput, _ := diffCmd.CombinedOutput()

		if len(diffOutput) > 0 {
			log.Fatalf("Test for problem %s failed:\n%s", p.String(), diffOutput)
		}
	} else {
		fmt.Print(string(outputBytes))
	}

}

func (p Problem) TestProblem() {
	switch p.year {
	case 2015:
		log.Println("I made 2015 in Ocaml, I don't need Yule for it :)")
		os.Exit(0)
	case 2022:
		execFile, err := ioutil.TempFile("", fmt.Sprintf("aoc-%d-%d", p.year, p.day))
		if err != nil {
			log.Fatalf("failed creating temporary file")
		}
		defer os.Remove(execFile.Name())

		cmd := exec.Command("g++", p.GetProgramFile(), "-o", execFile.Name())
		output, err := cmd.CombinedOutput()
		if err != nil {
			log.Fatalf("Error compiling file: %v\nOutput: %s", err, output)
		}

		log.Println("Compilation successful")

		cmd = exec.Command(execFile.Name())
		execFile.Close() // we need to close the file descriptor before executing it, thanks chatGPT!

		if ! *noExample {
			// Run compiled file with example file
			exampleOutputFile := p.GetExampleOutputFile()
			p.RunCommand(cmd, p.GetExampleFile(), &exampleOutputFile)
		}

		// Run compiled file with input file
		p.RunCommand(cmd, p.GetInputFile(), nil)

		log.Printf("Tests for problem %s succeeded", p.String())
	}
}

func (p Problem) GetProgramFile() string {
	var fileName string
	switch p.year {
	case 2015:
		fileName = fmt.Sprintf("day%d.ml", p.day)
	case 2022:
		fileName = fmt.Sprintf("day%d.cpp", p.day)
	}
	return filepath.Join(*pFlag, strconv.Itoa(p.year), fileName)
}

func (p Problem) GetInputFile() string {
	return filepath.Join(*pFlag, strconv.Itoa(p.year), fmt.Sprintf("day%d.in", p.day))
}

func (p Problem) GetExampleFile() string {
	return filepath.Join(*pFlag, strconv.Itoa(p.year), fmt.Sprintf("day%d.ex", p.day))
}

func (p Problem) GetExampleOutputFile() string {
	return filepath.Join(*pFlag, strconv.Itoa(p.year), fmt.Sprintf("day%d.ex.out", p.day))
}

func parseProblem(s string) (*Problem, error) {
	components := strings.Split(s, "/")

	log.Printf("parsing %s as a Problem...", s)

	if len(components) != 2 {
		return nil, fmt.Errorf("invalid format for problem: %s", s)
	}

	year, err := strconv.Atoi(components[0])

	if err != nil {
		return nil, fmt.Errorf("invalid year: %s", components[0])
	}

	day, err := strconv.Atoi(components[1])

	if err != nil {
		return nil, fmt.Errorf("invalid day: %s", components[1])
	}

	return &Problem{year, day}, nil
}

func main() {
	flag.Parse()

	normalArgs := flag.Args()

	if !*verbose {
		log.SetOutput(ioutil.Discard)
	}

	log.Println("noExampleFlag:", *noExample)
        log.Println("normalArgs:", normalArgs)
        log.Println("fullArgs:", os.Args)

	// TODO: discover why flags after the problem arg don't work
	if len(normalArgs) != 1 {
		printUsage()
		os.Exit(1)
	}

	problem, err := parseProblem(normalArgs[0])

	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	problem.TestProblem()
}
