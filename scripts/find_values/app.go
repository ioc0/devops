package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strings"
)

func extractValues() {

	cmd := exec.Command("grep", "-e repository: -e tag: values.yaml | awk -F ':' '{print $2}' > images-tags.txt")

	err := cmd.Start() // Starts command asynchronously

	if err != nil {
		fmt.Println(err.Error())
	}
}
func readLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, strings.TrimSpace(scanner.Text()))
	}
	return lines, scanner.Err()
}
func main() {
	//extractValues()
	//makeStringWrite()
	// Read the values.yaml file
	// Define the regular expressions to match the repository and tag
	// Find the matches
	// Create the slices
	// Add the matches to the slices
	// Print the results
	//newFunction()
	extractValuesYaml()

}

func newFunction() bool {
	data, err := ioutil.ReadFile("values.yaml")
	if err != nil {
		fmt.Println("Error reading file:", err)
		return true
	}

	repoRegex := regexp.MustCompile(`repository:\s*(.*)`)
	tagRegex := regexp.MustCompile(`tag:\s*(.*)`)

	repoMatches := repoRegex.FindAllStringSubmatch(string(data), -1)
	tagMatches := tagRegex.FindAllStringSubmatch(string(data), -1)

	var repos []string
	var tags []string

	for _, match := range repoMatches {
		repos = append(repos, match[1])
	}
	for _, match := range tagMatches {
		tags = append(tags, match[1])
	}

	fmt.Println("Repositories:", repos)
	fmt.Println("Tags:", tags)
	return false
}
func extractValuesYaml() {
	// Get the current directory
	dir, err := os.Getwd()
	if err != nil {
		fmt.Println("Error getting current directory:", err)
		return
	}

	// Walk the parent directories
	err = filepath.Walk(dir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// Check if the file is a values.yaml file
		if info.IsDir() || filepath.Ext(path) != ".yaml" {
			return nil
		}

		// Read the file
		data, err := ioutil.ReadFile(path)
		if err != nil {
			fmt.Println("Error reading file:", err)
			return nil
		}

		// Define the regular expressions to match the repository and tag
		repoRegex := regexp.MustCompile(`repository:\s*(.*)`)
		tagRegex := regexp.MustCompile(`tag:\s*(.*)`)

		// Find the matches
		repoMatches := repoRegex.FindAllStringSubmatch(string(data), -1)
		tagMatches := tagRegex.FindAllStringSubmatch(string(data), -1)

		// Create the slices
		var repos []string
		var tags []string
		var result []string // The final result

		//var resultString string

		// Add the matches to the slices
		for _, match := range repoMatches {
			repos = append(repos, match[1])
		}
		for _, match := range tagMatches {
			tags = append(tags, match[1])
		}
		for i := 0; i < len(repos); i++ {
			result = append(result, repos[i])
		}
		fmt.Println(result)
		if len(repos) == len(tags) {
			fmt.Println("The number of repositories and tags are equal")
		} else {
			fmt.Println("The number of repositories and tags are not equal")
			fmt.Printf("Number of repositories: %d\n", len(repos))
			fmt.Printf("Number of tags: %d\n", len(tags))
		}
		file, err := os.Create("output_notags.txt")
		if err != nil {
			log.Panicln("Error creating file:", err)

		}
		defer file.Close()
		for _, line := range result {
			_, err := file.WriteString(line + "\n")
			if err != nil {
				log.Panicln("Error writing to file:", err)
			}

		}

		return nil

	})

	if err != nil {
		fmt.Println("Error walking the file tree:", err)
	}

}
func makeStringWrite() {
	lines, err := readLines("files/images-tags.txt")
	var result []string
	if err != nil {
		panic(err)
	}
	name := ""
	tag := ""
	for i := 0; i < len(lines); i++ {
		if i == 0 {
			name = lines[i]
		} else if i%2 == 0 {
			name = lines[i]
		} else {
			tag = lines[i]
		}
		image := (name + ":" + tag)
		result = append(result, image)
	}
	f, err := os.Create("result.txt")
	if err != nil {
		log.Fatal(err)
	}
	// remember to close the file
	defer f.Close()

	for _, line := range result {
		_, err := f.WriteString(line + "\n")
		if err != nil {
			log.Fatal(err)
		}
	}

}
