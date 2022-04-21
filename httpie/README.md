# httpie

```bash
brew install httpie
```

## 常用命令

```bash
http [--json] [--form] [--pretty {all,colors,format,none}]
     [--style STYLE] [--print WHAT] [--headers] [--body] [--verbose]
     [--all] [--history-print WHAT] [--stream] [--output FILE]
     [--download] [--continue]
     [--session SESSION_NAME_OR_PATH | --session-read-only SESSION_NAME_OR_PATH]
     [--auth USER[:PASS]] [--auth-type {basic,digest}]
     [--proxy PROTOCOL:PROXY_URL] [--follow]
     [--max-redirects MAX_REDIRECTS] [--timeout SECONDS]
     [--check-status] [--verify VERIFY]
     [--ssl {ssl2.3,ssl3,tls1,tls1.1,tls1.2}] [--cert CERT]
     [--cert-key CERT_KEY] [--ignore-stdin] [--help] [--version]
     [--traceback] [--default-scheme DEFAULT_SCHEME] [--debug]
     [METHOD] URL [REQUEST_ITEM [REQUEST_ITEM ...]]
```

基本语法： **http [flags] [METHOD] URL [ITEM [ITEM]]**

## Method

如果不带METHOD参数，这默认为GET(没有附带请求参数)或POST(附带请求参数,默认以json格式传输)

```bash
$ http example.org               # => GET
$ http example.org hello=world   # => POST


http -v :8080/api/v1/public/user key=='rs' page==5 limit==3
```

## URL
默认协议为`http://`,如果主机是`localhost`,还可以如下简写：

```bash
$ http :3000                    # => http://localhost:3000
$ http :/foo                    # => http://localhost/foo
```

另外可以使用param==value语法像url添加参数，所产生的效果就是浏览器中通过&连接的参数，注意区分POST方法所使用的param=value语法
```bash
$ http www.google.com search=='HTTPie logo' tbm==isch
```

## 示例

```bash
http -v httpie.org

http PUT example.com X-API-Token:123 name=John

# 提交表单数据
http -f POST httpie hello=World name=John

http DELETE example.org/todos/7

# 为了设置请求头你可以使用 Header:Value 标记：
http example.org  User-Agent:Bacon/1.0 'Cookie:valued-visitor=yes;foo=bar' \
    X-Foo:Bar Referer:http://httpie.org/


# 想要取消上面默认指定的请求头，可以使用 Header:：
http httpbin.org/headers Accept: User-Agent:
# 也可以使用 Header: 来发送一个空值请求头：
http httpbin.org/headers 'Header;'

# 发送单个 cookie：
http example.org Cookie:sessionid=foo

# 发送多个 cookies 值时，cookies 需要使用引号包裹并以 ; 分号分隔的值对：
http example.org 'Cookie:sessionid=foo;another-cookie=bar'
```

## JSON
`param=value`格式的参数全部会转换成`json`格式传输，并且`value`全是字符串

```bash
$ http PUT example.org name=John email=john@example.org
```

Non-string fields use the `:=` separator, which allows you to embed raw `JSON` into the resulting object. Text and raw `JSON` files can also be embedded into fields using `=@` and `:=@`:

```bash
$ http PUT api.example.com/person/1 \
    name=John \
    age:=29 married:=false hobbies:='["http", "pies"]' \  # Raw JSON
    description=@about-john.txt \   # Embed text file
    bookmarks:=@bookmarks.json      # Embed JSON file
```






## from

- [https://xin053.github.io/2016/08/15/httpie%E4%BA%BA%E6%80%A7%E5%8C%96curl%E5%B7%A5%E5%85%B7%E4%BD%BF%E7%94%A8%E8%AF%A6%E8%A7%A3/](https://xin053.github.io/2016/08/15/httpie%E4%BA%BA%E6%80%A7%E5%8C%96curl%E5%B7%A5%E5%85%B7%E4%BD%BF%E7%94%A8%E8%AF%A6%E8%A7%A3/)
- [ 官网手册最全 ](https://httpie.io/docs/cli/querystring-parameters)
