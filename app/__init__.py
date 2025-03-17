from flask import Flask
from flask_jwt_extended import JWTManager
import config
from app.routes import stock_blueprint, database_stock_list_blueprint

# jwt = JWTManager()


def create_app():
    app = Flask(__name__)
    app.config.from_object(config)

    # Initialize JWT for authentication
    JWTManager(app)
    
    app.register_blueprint(stock_blueprint)
    app.register_blueprint(database_stock_list_blueprint)

    return app