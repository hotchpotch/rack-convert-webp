# Rack::Convert::Webp

Auto convert to WebP.

## Installation

```
gem install rack-convert-webp
```

## Usage

```
$ rackup -r 'rack/convert/webp' -b "use Rack::Convert::Webp;run Rack::Directory.new '.'"
$ curl -X GET -I -H "Accept: image/webp" -H "Content-Type: image/jpeg" 'http://localhost:9292/example.jpg'
HTTP/1.1 200 OK
Last-Modified: Thu, 20 Mar 2014 14:50:34 GMT
Content-Type: image/webp
Content-Length: 19340
X-Encoding-Time: 42ms
X-Compress: 24% - original: 78361 webp: 19340
Connection: keep-alive
Server: thin 1.6.1 codename Death Proof

$ curl -X GET -I -H "Accept: image/webp" -H "Content-Type: image/jpeg" 'http://localhost:9292/example.jpg?quality=10'
HTTP/1.1 200 OK
Last-Modified: Thu, 20 Mar 2014 14:50:34 GMT
Content-Type: image/webp
Content-Length: 4346
X-Encoding-Time: 36ms
X-Compress: 5% - original: 78361 webp: 4346
Connection: keep-alive
Server: thin 1.6.1 codename Death Proof
```

