package main

import (
	"fmt"
	"net/http"

	"rsc.io/quote"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello world !\n")
	})

	fmt.Println(quote.Hello())
	http.ListenAndServe(":8080", nil)
}
