# API de Dados

A API de dados fornece informações sobre um domínio específico, identificado por uma chave.

Os domínios disponíveis são:
- pessoas
- empresas
- processos

## Token

> Para obter um token, use esse código:

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

> O retorno será algo como:

```json
{
  "access_token": "<your-bearer-token>",
  "expires_in": 1799,
  "scope": "scope.read",
  "token_type": "bearer"
}
```

Para acessar a API de dados da Neoway você precisar obter um token de autenticação,
para depois conseguir os resursos disponíveis através dos endpoints de API.

A API de dados espera que tenha um cabeçalho `Authorization` com o token obtido nesse passo.

Da seguinte maneira:

`Authorization: Bearer <your-bearer-token>`

<aside class="notice">
Você deve alterar o <code>your-bearer-token</code> pelo token obtido no endpoint `oauth/token`.
</aside>

## Obter informações de pessoas

> Para pegar dados de pessoa, use esse código:

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

Esse endpoint retorna os dados de uma pessoa, pela chave que é o cpf.

### Request

`GET https://api.neoway.com.br/v1/data/pessoas/:cpf`

### Parâmetros

Parâmetro | Descrição
--------- | -----------
cpf | campo-chave representado pelo cpf para obter os dados da pessoa.
metadata | Se definido como falso, oculta os metadados. Se verdadeiro, mostra metadados.

<aside class="notice">
Lembre-se - este endpoint precisa de autenticação!
</aside>

## Obter informação de uma empresa

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

> O comando acima retorna um JSON estruturado, como:

```json
{
  "empresa": {
    "cnpj": "<cnpj>",
    "razaoSocial": "<razao-social>",
    ...
  }
}
```

Esse endpoint retorna as informaçõse de uma empresa pelo identificador da empresa cnpj.

<aside class="notice">
Lembre-se - este endpoint precisa de autenticação!
</aside>

### HTTP Request

`GET https://api.neoway.com.br/v1/data/empresas/:cnpj`

### Parâmetros

Parâmetro | Descrição
--------- | -----------
cnpj | Número identificador da empresa

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

Esse endpoint retorna informações de um processo específico.

### Request

`GET https://api.neoway.com.br/v1/data/processos/:id`

### Parâmetros

Parâmetro | Descrição
--------- | -----------
id | Identificador do processo

## Errors

The Data API uses the following error codes:

Error Code | Meaning
---------- | -------
400 | Bad Request -- Sua solicitação é inválida.
401 | Unauthorized -- Token de acesso ausente ou inválido.
404 | Not Found -- O documento especificado não foi encontrado.
423 | Locked -- Créditos insuficientes para a operação.
429 | Too Many Requests -- Você está solicitando muitos documentos, Vá com calma!
500 | Internal Server Error -- Ocorreu um problema com o nosso servidor. Tente mais tarde
503 | Service Unavailable -- Estamos temporariamente offline para manutenção. Por favor, tente novamente mais tarde.
