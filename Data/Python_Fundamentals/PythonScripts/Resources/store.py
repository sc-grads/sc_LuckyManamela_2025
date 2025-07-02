from flask import request
from flask.views import MethodView
from flask_smorest import Blueprint, abort
from uuid import uuid4

# Create the stores blueprint
blp = Blueprint("stores", __name__, description="Operations on stores")

# Class for /store/<store_id> endpoints (GET, DELETE)
@blp.route("/store/<string:store_id>")
class Store(MethodView):
    def get(self, store_id):
        for store in stores:
            if store["id"] == store_id:
                return store
        abort(404, message="Store not found")

    def delete(self, store_id):
        for i, store in enumerate(stores):
            if store["id"] == store_id:
                stores.pop(i)
                return {"message": "Store deleted"}
        abort(404, message="Store not found")

# Class for /store endpoints (GET, POST)
@blp.route("/store")
class StoreList(MethodView):
    def get(self):
        return {"stores": stores}

    def post(self):
        store_data = request.get_json()
        if not store_data or "name" not in store_data:
            abort(400, message="Invalid data, 'name' is required")
        new_store = {
            "id": str(uuid4()),
            "name": store_data["name"],
            "items": store_data.get("items", [])
        }
        stores.append(new_store)
        return new_store, 201

# In-memory store data (temporary, will replace with database later)
stores = [
    {
        "id": str(uuid4()),
        "name": "My Store",
        "items": [
            {"name": "Chair", "price": 15.99},
            {"name": "Table", "price": 49.99}
        ]
    },
    {
        "id": str(uuid4()),
        "name": "Tech Store",
        "items": [
            {"name": "Laptop", "price": 999.99},
            {"name": "Mouse", "price": 19.99}
        ]
    }
]