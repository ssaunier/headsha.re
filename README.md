## Api example

```bash
curl -H "X-API-EMAIL: seb@saunier.me" \
     -H "X-API-TOKEN: *******************************" \
     -H "Content-Type: application/json" \
     -d '{ "content_url": "http://interesting.example.org", "header_url": "http://sebastien.saunier.me", "header_content": "Read my blog", "header_background_color": "#111111", "header_text_color": "#eeeeee" }' \
      http://localhost:3000/api/v1/shares.json
```

{
    "content_url": "http://interesting.example.org",
    "header_url": "http://sebastien.saunier.me",
    "header_content": "Read my blog!",
    "header_background_color": "#111111",
    "header_text_color": "#eeeeee"
}