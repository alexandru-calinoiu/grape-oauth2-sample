# Client credentials

# fail
```
curl -d '{"grant_type": "client_credentials", "client_id": "42"}' 'http://localhost:9292/api/v1/token' -H Content-Type:application/json -v
```

# success
```
curl -d '{"grant_type": "client_credentials", "client_id": "42", "client_secret": "secret"}' 'http://localhost:9292/api/v1/token' -H Content-Type:application/json -v
```