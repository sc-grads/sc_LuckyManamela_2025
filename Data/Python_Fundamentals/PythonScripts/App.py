from flask import Flask

app = Flask(__name__)

stores = [
    {
        "name": "My Store",
        "items": [
            {"name": "Chair", "price": 15.99},
            {"name": "Table", "price": 49.99}
        ]
    },
    {
        "name": "Tech Store",
        "items": [
            {"name": "Laptop", "price": 999.99},
            {"name": "Mouse", "price": 19.99}
        ]
    }
]

@app.get("/store")
def get_stores():
    return {"stores": stores}

if __name__ == "__main__":
    app.run(debug=True)