from flask import request
from flask.views import MethodView
from flask_smorest import Blueprint, abort
from uuid import uuid4
from resources.store import stores  # Import stores from store.py

# Create the items blueprint
blp = Blueprint("items", __name__, description="Operations on items")

# Class for /item/<item_id> endpoints (GET, DELETE, PUT)
@blp.route("/item/<string:item_id>")
class Item(MethodView):
    def get(self, item_id):
        for store in stores:
            for item in store["items"]:
                if item["id"] == item_id:
                    return item
        abort(404, message="Item not found")

    def delete(self, item_id):
        for store in stores:
            for i, item in enumerate(store["items"]):
                if item["id"] == item_id:
                    store["items"].pop(i)
                    return {"message": "Item deleted"}
        abort(404, message="Item not found")

    def put(self, item_id):
        item_data = request.get_json()
        if not item_data or "name" not in item_data or "price" not in item_data:
            abort(400, message="Invalid data, 'name' and 'price' are required")
        for store in stores:
            for item in store["items"]:
                if item["id"] == item_id:
                    item["name"] = item_data["name"]
                    item["price"] = item_data["price"]
                    return item
        abort(404, message="Item not found")

# Class for /item endpoints (GET, POST)
@blp.route("/item")
class ItemList(MethodView):
    def get(self):
        items = [item for store in stores for item in store["items"]]
        return {"items": items}

    def post(self):
        item_data = request.get_json()
        if not item_data or "name" not in item_data or "price" not in item_data or "store_id" not in item_data:
            abort(400, message="Invalid data, 'name', 'price', and 'store_id' are required")
        for store in stores:
            if store["id"] == item_data["store_id"]:
                new_item = {
                    "id": str(uuid4()),
                    "name": item_data["name"],
                    "price": item_data["price"]
                }
                store["items"].append(new_item)
                return new_item, 201
        abort(404, message="Store not found")