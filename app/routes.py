from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.services.stock_service import fetch_stock_price, fetch_stock_values, fetch_AI_Insights_From_BalanceSheet, fetch_Indices_Data, get_stock_open_current_price
from app.services.stock_database_listing import listing_stocks_in_database

# Create a blueprint for stock routes
stock_blueprint = Blueprint("stocks", __name__)
database_stock_list_blueprint = Blueprint("databaseStockList", __name__)


@stock_blueprint.route("/stock/symbol/<string:symbol>/period/<string:period>", methods=["GET"])
@jwt_required()  # Requires valid JWT token
def getStockPrice(symbol, period):
    try:
        user = get_jwt_identity()
    except Exception as e:
        return jsonify({"msg": "JWT processing error", "details": str(e)}), 401  # Unauthorized

    if(period == None):
        print("No period found")

    stock_data = fetch_stock_price(symbol, period)

    # if stock_data is None:
    #     return jsonify({"error": "Stock data not found"}), 404
    # return jsonify({"user": user, "stock_symbol": symbol, "data": stock_data})

    if not stock_data:
        return jsonify([]), 404  # Return empty array if no data
    

    return jsonify(stock_data)


@stock_blueprint.route("/stock/financials/symbol/<string:symbol>", methods=["GET"])
@jwt_required()
def getStockValues(symbol):
    try:
        user = get_jwt_identity()  # Extract user info
        # print("Decoded User:", user)
    except Exception as e:
        print("JWT Error:", str(e))
        return jsonify({"msg": "JWT processing error", "details": str(e)}), 401  # Unauthorized

    stock_values = fetch_stock_values(symbol)
    if stock_values is None:
        return jsonify({"error": "Financial data not found"}), 404
    print(stock_values)
    return jsonify(stock_values)

    # return jsonify({"user": user, "stock_symbol": symbol, "financials": stock_values})


@stock_blueprint.route("/stock/ai-insights-balance-sheet/symbol/<string:symbol>", methods=["GET"])
@jwt_required()
def getAIInsightsFromBalanceSheet(symbol):
    try:
        user = get_jwt_identity()  # Extract user info
        # print("Decoded User:", user)
    except Exception as e:
        print("JWT Error:", str(e))
        return jsonify({"msg": "JWT processing error", "details": str(e)}), 401  # Unauthorized

    insights = fetch_AI_Insights_From_BalanceSheet(symbol)
    if insights is None:
        return jsonify({"error": "Financial data not found"}), 404
    
    return jsonify(insights)

@stock_blueprint.route("/stock/indices", methods=["GET"])
@jwt_required()
def getIndicesData():
    try:
        user = get_jwt_identity()  # Extract user info
        # print("Decoded User:", user)
    except Exception as e:
        print("JWT Error:", str(e))
        return jsonify({"msg": "JWT processing error", "details": str(e)}), 401  # Unauthorized

    indicesData = fetch_Indices_Data()
    if indicesData is None:
        return jsonify({"error": "Indices data not found"}), 404
    
    print(indicesData)
    return jsonify(indicesData)

@stock_blueprint.route("/stock/fetch-stock-open-current-price", methods=["GET"])
@jwt_required()
def fetchStockOpenCurrentPrice():
    print("Fetching Stock Open Current Price.....")
    try:
        user = get_jwt_identity()  # Extract user info
        # print("Decoded User:", user)
    except Exception as e:
        print("JWT Error:", str(e))
        return jsonify({"msg": "JWT processing error", "details": str(e)}), 401  # Unauthorized
    print("User:", user)
    print("Request Args:", request.args.to_dict(flat=False))

    symbols = request.args.to_dict(flat=False)["symbol"]

    data = get_stock_open_current_price(symbols)

    if data is None:
        return jsonify({"error": "Stock data not found"}), 404

    return data


@database_stock_list_blueprint.route("/stock-list-in-database")
def stock_listing():
    result = listing_stocks_in_database()
    
    if "error" in result:
        return jsonify(result), 500  # Internal Server Error
    
    return jsonify(result), 200  # Success