from app import create_app

app = create_app()

for rule in app.url_map.iter_rules():
    print(rule)
    
if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
