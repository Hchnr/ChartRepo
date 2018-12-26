package main
import (
    "net/http"
    "fmt"
    "strings"
    "os/exec"
    "bytes"
)
/*
func sayhelloName(w http.ResponseWriter, r *http.Request) {
    r.ParseForm() //解析参数，默认是不会解析的
    fmt.Println(r.Form) //这些信息是输出到服务器端的打印信息
    fmt.Println("path", r.URL.Path)
    fmt.Println("scheme", r.URL.Scheme)
    fmt.Println(r.Form["url_long"])
    for k, v := range r.Form {
        fmt.Println("key:", k)
        fmt.Println("val:", strings.Join(v, ""))
    }
    fmt.Fprintf(w, "Hello Wrold!") //这个写入到w的是输出到客户端的
}
func main() {
    http.HandleFunc("/", sayhelloName) //设置访问的路由
    err := http.ListenAndServe(":9090", nil) //设置监听的端口
    if err != nil {
        log.Fatal("ListenAndServe: ", err)
    }
}
*/

func exec_shell(s string) (string, error) {
    cmd := exec.Command("/bin/bash", "-c", s)

    var out bytes.Buffer
    cmd.Stdout = &out
    err := cmd.Run()
    
    fmt.Println("[Info] Shell output: ", out.String())
    fmt.Println("[Info] Shell error: ", err)
    return out.String(), err
}

func update(w http.ResponseWriter, r *http.Request) {
    r.ParseForm() 
    // fmt.Println("[Request]: form ", r.Form) 
    fmt.Println("[Request]: path ", r.URL.Path)
    // fmt.Println("[Request]: scheme ", r.URL.Scheme)
    // fmt.Println("[Request]: url ", r.Form["url_long"])
    for k, v := range r.Form {
        fmt.Println("key:", k)
        fmt.Println("val:", strings.Join(v, ""))
    }
    exec_shell("./update.sh") 
}

func main() {
        http.Handle("/release/", http.StripPrefix("/release/", http.FileServer(http.Dir("./release"))))
        http.HandleFunc("/update", update)
        http.ListenAndServe(":9421", nil)
}

