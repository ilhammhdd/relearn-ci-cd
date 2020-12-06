package main

import (
	"fmt"
	"net/http"
	"os"
	"strings"

	"github.com/ilhammhdd/go-toolkit/errorkit"
	"github.com/ilhammhdd/go-toolkit/safekit"
)

func init() {
	if len(os.Args) > 1 {
		for _, val := range os.Args[1:] {
			env := strings.Split(val, "=")
			env[1] = strings.ReplaceAll(env[1], ".exe", "")
			os.Setenv(env[0], env[1])
		}
	}
}

func main() {
	wp := safekit.NewWorkerPool()

	wp.Work <- restListener

	wp.PoolWG.Wait()
}

func restListener() {
	http.Handle("/test", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("OKE"))
		w.WriteHeader(http.StatusOK)
	}))

	server := &http.Server{
		Addr: fmt.Sprintf(":%s", os.Getenv("REST_PORT"))}

	defer server.Close()

	errorkit.ErrorHandled(server.ListenAndServe())
}
