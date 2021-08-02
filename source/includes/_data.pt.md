# API de Dados

A API de dados fornece informações sobre um domínio específico, identificado por uma chave.

Os domínios disponíveis são:

* pessoas
* empresas
* processos

Através do endereço padrão desse serviço `/v1/data/:domain`,
especificar o domínio de obtenção de dados, como por exemplo:

* `/v1/data/pessoas/:cpf`
* `/v1/data/empresas/:cnpj`
* `/v1/data/processos/:id-do-processo`.

Abaixo teremos detalhes de cada uma das requisições.
Mas antes de consumir qualquer endpoint desse, certifique-se que
você obteve um token de acesso ao recurso do serviço protegido.

## Token

> Para obter um token, use esse código:

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
   "application": "rafael-mateus-app",
   "application_secret": "uMPJMHGsUx" 
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

> O retorno será algo como:

```json
{
  "token": "<your-token>"
}
```

Para acessar a API de dados da Neoway você precisar obter um token de autenticação,
para depois conseguir os resursos disponíveis através dos endpoints de API.

A API de dados espera que tenha um cabeçalho `Authorization` com o token obtido nesse passo do tipo `Bearer`.

Da seguinte maneira:

`Authorization: Bearer <your-token>`

### Request

`POST - https://api.neoway.com.br/auth/token`

### Parâmetros

Parâmetro | Descrição
--------- | -----------
application | Nome identificador da conta de API.
application_secret | Senha da conta de API.

<aside class="notice">
Você deve alterar o <code>your-token</code> pelo token obtido no endpoint `oauth/token`.
</aside>

## Obter dados de pessoas

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

Esse endpoint retorna os dados de uma pessoa, pela chave que é o cpf.

<aside class="notice">
Lembre-se - este endpoint precisa de autenticação!
</aside>

### Request

`GET - https://api.neoway.com.br/v1/data/pessoas/:cpf`

### Parâmetros

Parâmetro | Descrição
--------- | -----------
cpf | campo-chave representado pelo cpf para obter os dados da pessoa.
metadata | Se definido como falso, oculta os metadados. Se verdadeiro, mostra metadados.

## Obter dados de empresas

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

`GET - https://api.neoway.com.br/v1/data/empresas/:cnpj`

### Parâmetros

Parâmetro | Descrição
--------- | -----------
cnpj | Número identificador da empresa

## Obter dados de processos

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

<aside class="notice">
Lembre-se - este endpoint precisa de autenticação!
</aside>

### Request

`GET https://api.neoway.com.br/v1/data/processos/:id`

### Parâmetros

Parâmetro | Descrição
--------- | -----------
id | Identificador do processo

## Status de Respostas

A API de dados tem os seguintes status de respostas:

Status | Descrição | Cobrado?
------ | --------- | --------
200 - OK | Sua requisição foi respondida com sucesso. | Sim
400 - Bad Request | Sua solicitação é inválida. | Não
401 - Unauthorized | Token de acesso ausente ou inválido. | Não
404 - Not Found | O documento especificado não foi encontrado. | Não
423 - Locked | Créditos insuficientes para a operação. | Não
429 - Too Many Requests | Você está solicitando muitos documentos, Vá com calma! | Não
500 - Internal Server Error | Ocorreu um problema com o nosso servidor. Tente mais tarde. | Não
503 - Service Unavailable | Estamos temporariamente offline para manutenção. Por favor, tente novamente mais tarde. | Não
