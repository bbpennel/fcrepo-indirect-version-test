rm -f results/*

curl -XDELETE "http://localhost:8080/fcrepo/rest/mainObject" 2>/dev/null
curl -XDELETE "http://localhost:8080/fcrepo/rest/mainObject/fcr:tombstone" 2>/dev/null
curl -XDELETE "http://localhost:8080/fcrepo/rest/childObject" 2>/dev/null
curl -XDELETE "http://localhost:8080/fcrepo/rest/childObject/fcr:tombstone" 2>/dev/null


curl -XPUT "http://localhost:8080/fcrepo/rest/mainObject" -H "Content-Type: text/turtle" --data-binary @main.ttl

curl -XPUT "http://localhost:8080/fcrepo/rest/mainObject/indirect" -H "Content-Type: text/turtle" --data-binary @indirect.ttl

curl -XPUT "http://localhost:8080/fcrepo/rest/childObject"

curl -XPUT "http://localhost:8080/fcrepo/rest/mainObject/indirect/proxy" -H "Content-Type: text/turtle" --data-binary @proxy.ttl

curl -XPOST "http://localhost:8080/fcrepo/rest/mainObject/fcr:versions" -H "Slug: version"

curl "http://localhost:8080/fcrepo/rest/mainObject" > results/mainObject.current.ttl
curl "http://localhost:8080/fcrepo/rest/mainObject/fcr:versions/version" > results/mainObject.version.ttl
