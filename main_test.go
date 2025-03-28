package main

import "testing"

func TestGreet(t *testing.T) {
	expected := "Hello World!"
	actual := greet()

	if actual != expected {
		t.Errorf("Expected %s, but got %s", expected, actual)
	}
}
