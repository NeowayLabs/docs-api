---
title: Data API - Neoway

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - go
  - ruby
  - python
  - javascript

toc_footers:
  - Developed by <a href='https://neoway.com.br'>Neoway</a>

includes:
  - errors

search: true

code_clipboard: true
---

# Introduction

Welcome to the Data API! You can use our API to access the data sources, which can get information on various people, company, and other documents in our database.

We have language bindings in Shell, Go, Ruby, Python, and JavaScript! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.

If you're familiar with the postman, here are the collections to import.

<div class="postman-run-button"
  data-postman-action="collection/import"
  data-postman-var-1="864f0579179de207592f">
</div>

# Authentication

> To authorize, use this code:

```go
package main

import (
  "fmt"
  "bytes"
  "mime/multipart"
  "net/http"
  "io/ioutil"
)

func main() {

  url := "https://api.neoway.com.br/oauth2/token"
  method := "POST"

  payload := &bytes.Buffer{}
  writer := multipart.NewWriter(payload)
  _ = writer.WriteField("client_id", "<your-client-id")
  _ = writer.WriteField("client_secret", "<your-client-secret>")
  _ = writer.WriteField("grant_type", "client_credentials")
  err := writer.Close()
  if err != nil {
    fmt.Println(err)
    return
  }


  client := &http.Client {
  }
  req, err := http.NewRequest(method, url, payload)

  if err != nil {
    fmt.Println(err)
    return
  }
  req.Header.Add("Content-Type", "application/x-www-form-urlencoded")

  req.Header.Set("Content-Type", writer.FormDataContentType())
  res, err := client.Do(req)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer res.Body.Close()

  body, err := ioutil.ReadAll(res.Body)
  if err != nil {
    fmt.Println(err)
    return
  }
  fmt.Println(string(body))
}
```

```ruby
require "uri"
require "net/http"

url = URI("https://api.neoway.com.br/oauth2/token")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Post.new(url)
request["Content-Type"] = "application/x-www-form-urlencoded"
form_data = [['client_id', '<your-client-id'],['client_secret', '<your-client-secret>'],['grant_type', 'client_credentials']]
request.set_form form_data, 'multipart/form-data'
response = https.request(request)
puts response.read_body
```

```python
import requests

headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
}

response = requests.post('https://api.neoway.com.br/oauth2/token', headers=headers)
```

```shell
curl -X POST 'https://api.neoway.com.br/oauth2/token' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --form 'client_id="<your-client-id>"' \
  --form 'client_secret="<your-client-secret>"' \
  --form 'grant_type="client_credentials"'
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Content-Type", "application/x-www-form-urlencoded");

var formdata = new FormData();
formdata.append("client_id", "<your-client-id>");
formdata.append("client_secret", "<your-client-secret>");
formdata.append("grant_type", "client_credentials");

var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: formdata,
  redirect: 'follow'
};

fetch("https://api.neoway.com.br/oauth2/token", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

> The above command returns JSON structured like this:

```json
{
  "access_token": "<your-bearer-token>",
  "expires_in": 1799,
  "scope": "scope.read",
  "token_type": "bearer"
}
```

Kittn uses API keys to allow access to the API. You can register a new Kittn API key at our [developer portal](http://example.com/developers).

Kittn expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: Bearer <your-bearer-token>`

<aside class="notice">
  You must replace <code>your-bearer-token</code> with your personal API key.
</aside>

# Data API

The data API provides information about a specific domain identified by a key.

## Get a Person Data

> To get a person data, use this code:

```go
package main

import (
  "fmt"
  "net/http"
  "io/ioutil"
)

func main() {

  url := "https://api.neoway.com.br/v1/data/pessoas/:cpf"
  method := "GET"

  client := &http.Client {
  }
  req, err := http.NewRequest(method, url, nil)

  if err != nil {
    fmt.Println(err)
    return
  }
  req.Header.Add("Authorization", "Bearer <your-bearer-token>")

  res, err := client.Do(req)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer res.Body.Close()

  body, err := ioutil.ReadAll(res.Body)
  if err != nil {
    fmt.Println(err)
    return
  }
  fmt.Println(string(body))
}
```

```ruby
require "uri"
require "net/http"

url = URI("https://api.neoway.com.br/v1/data/pessoas/:cpf")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Authorization"] = "Bearer <your-client-id>"

response = https.request(request)
puts response.read_body
```

```python
import http.client

conn = http.client.HTTPSConnection("api.neoway.com.br")
payload = ''
headers = {
  'Authorization': 'Bearer <your-bearer-token>'
}
conn.request("GET", "/v1/data/pessoas/:cpf", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```

```shell
curl --location --request GET 'https://api.neoway.com.br/v1/data/pessoas/:cpf' \
  --header 'Authorization: Bearer <your-bearer-token>'
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Authorization", "Bearer <your-bearer-token>");

var requestOptions = {
  method: 'GET',
  headers: myHeaders,
  redirect: 'follow'
};

fetch("https://api.neoway.com.br/v1/data/pessoas/:cpf", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

> The above command returns JSON structured like this:

```json
{
  "pessoa": {
    "cpf": "<cpf>",
    "nome": "<Nome da Pessoa>"
    ...
  }
}
```

This endpoint returns a person's data.

### HTTP Request

`GET https://api.neoway.com.br/v1/data/pessoas/:cpf`

### Path Parameters

Parameter | Description
--------- | -----------
cpf | key field represented by the cpf to obtain a person's data.
metadata | If set to false, hides metadata. If true, shows metadata.

<aside class="success">
  Remember — this endpoint needs authentication!
</aside>

## Get a Company Data

```go
package main

import (
  "fmt"
  "net/http"
  "io/ioutil"
)

func main() {

  url := "https://api.neoway.com.br/v1/data/empresas/:cnpj"
  method := "GET"

  client := &http.Client {
  }
  req, err := http.NewRequest(method, url, nil)

  if err != nil {
    fmt.Println(err)
    return
  }
  req.Header.Add("Authorization", "Bearer <your-bearer-token>")

  res, err := client.Do(req)
  if err != nil {
    fmt.Println(err)
    return
  }
  defer res.Body.Close()

  body, err := ioutil.ReadAll(res.Body)
  if err != nil {
    fmt.Println(err)
    return
  }
  fmt.Println(string(body))
}
```

```ruby
require "uri"
require "net/http"

url = URI("https://api.neoway.com.br/v1/data/empresas/:cnpj")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Authorization"] = "Bearer <your-bearer-token>"

response = https.request(request)
puts response.read_body
```

```python
import http.client

conn = http.client.HTTPSConnection("api.neoway.com.br")
payload = ''
headers = {
  'Authorization': 'Bearer <your-bearer-token>'
}
conn.request("GET", "/v1/data/empresas/:cnpj", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```

```shell
curl -X GET 'https://api.neoway.com.br/v1/data/empresas/:cnpj' \
  --header 'Authorization: Bearer <your-bearer-token>'
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Authorization", "Bearer <your-bearer-token>");

var requestOptions = {
  method: 'GET',
  headers: myHeaders,
  redirect: 'follow'
};

fetch("https://api.neoway.com.br/v1/data/empresas/:cnpj", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

> The above command returns JSON structured like this:

```json
{
  "empresa": {
    "cnpj": "<cnpj>",
    "razaoSocial": "<razao-social>",
    ...
  }
}
```

This endpoint retrieves a specific company by cnpj key.

<aside class="success">
  Remember — this endpoint needs authentication!
</aside>

### HTTP Request

`GET https://api.neoway.com.br/v1/data/empresas/:cnpj`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID of the kitten to retrieve

## Get a Specific Process

```ruby
# TODO
```

```python
// TODO
```

```shell
# TODO
```

```javascript
// TODO
```

> The above command returns JSON structured like this:

```json
{
  "TO": "DO",
}
```

This endpoint gets a specific process.

### HTTP Request

`DELETE http://example.com/v1/data/processos/:id`

### URL Parameters

Parameter | Description
--------- | -----------
ID | The ID
