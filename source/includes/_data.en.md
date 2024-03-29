# Data API

The data API provides information about a specific domain identified by a key.

The available domains are:

* pessoas
* empresas

Through the standard address of this service `/v1/data/:domain`,
specify the data collection domain, for example:

* `/v1/data/pessoas/:cpf`
* `/v1/data/empresas/:cnpj`

Below we have details of each of the requests.
Before consuming any such endpoint, make sure you have obtained
a resource access token from the protected service.

## Authentication

> To authentication, use this code:

```go
package main

import (
  "fmt"
  "strings"
  "net/http"
  "io/ioutil"
)

func main() {

  url := "https://api.neoway.com.br/auth/token"
  method := "POST"

  payload := strings.NewReader(`{ 
   "application": "<your-application-id>",
   "application_secret": "<your-application-secret>" 
  }`)

  client := &http.Client {
  }
  req, err := http.NewRequest(method, url, payload)

  if err != nil {
    fmt.Println(err)
    return
  }
  req.Header.Add("Content-Type", "application/json")

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

url = URI("https://api.neoway.com.br/auth/token")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Post.new(url)
request["Content-Type"] = "application/json"
request.body = "{ \n   \"application\": \"<your-application-id>\",\n   \"application_secret\": \"<your-application-secret>\" \n}"

response = https.request(request)
puts response.read_body
```

```python
import requests

url = "https://api.neoway.com.br/auth/token"

payload="{ \n   \"application\": \"<your-application-id>\",\n   \"application_secret\": \"<your-application-id>\" \n}"
headers = {
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)
```

```shell
curl -X POST 'https://api.neoway.com.br/auth/token' \
  --header 'Content-Type: application/json' \
  --data-raw '{ 
    "application": "<your-application-id>",
    "application_secret": "<your-application-secret>"
  }'
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Content-Type", "application/json");

var raw = JSON.stringify({"application":"<your-application-id>","application_secret":"<your-application-secret>"});

var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: raw,
  redirect: 'follow'
};

fetch("https://api.neoway.com.br/auth/token", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

> The above command returns JSON structured like this:

```json
{
  "token": "<your-token>"
}
```

To access Neoway's Data API you need to obtain an authentication token.

The Data API expects the header `Authorization` using type `Bearer`.

`Authorization: Bearer <your-token>`

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
  req.Header.Add("Authorization", "Bearer <your-token>")

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
  'Authorization': 'Bearer <your-token>'
}
conn.request("GET", "/v1/data/pessoas/:cpf", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```

```shell
curl -X GET 'https://api.neoway.com.br/v1/data/pessoas/:cpf' \
  --header 'Authorization: Bearer <your-token>'
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Authorization", "Bearer <your-token>");

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
fields | Use this parameter to filter the reponse fields.
metadata | If set to false, hides metadata. If true, shows metadata.

<aside class="notice">
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
  req.Header.Add("Authorization", "Bearer <your-token>")

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
request["Authorization"] = "Bearer <your-token>"

response = https.request(request)
puts response.read_body
```

```python
import http.client

conn = http.client.HTTPSConnection("api.neoway.com.br")
payload = ''
headers = {
  'Authorization': 'Bearer <your-token>'
}
conn.request("GET", "/v1/data/empresas/:cnpj", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))
```

```shell
curl -X GET 'https://api.neoway.com.br/v1/data/empresas/:cnpj' \
  --header 'Authorization: Bearer <your-token>'
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Authorization", "Bearer <your-token>");

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

<aside class="notice">
  Remember — this endpoint needs authentication!
</aside>

### HTTP Request

`GET https://api.neoway.com.br/v1/data/empresas/:cnpj`

### URL Parameters

Parameter | Description
--------- | -----------
cnpj | The CNPJ identifier of company
fields | Use this parameter to filter the reponse fields.
metadata | If set to false, hides metadata. If true, shows metadata.

## Response Status

The Data API uses the following error codes:

Code | Description | Ticketed?
---- | ----------- | --------
200 - OK | Indicates that the request has succeeded. | Yes
400 - Bad Request | Your request is invalid. | No
401 - Unauthorized | Access token is missing or invalid. | No
404 - Not Found | The specified document could not be found. | No
423 - Locked | Insufficient credits for the operation. | No
429 - Too Many Requests | You're requesting too many documents! Slow down! | No
500 - Internal Server Error | We had a problem with our server. Try again later. | No
503 - Service Unavailable | We're temporarily offline for maintenance. Please try again later. | No
