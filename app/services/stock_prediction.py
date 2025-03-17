# import numpy as np
# import pandas as pd
# from tensorflow.python.keras.models import Sequential, load_model
# from tensorflow.python.keras.layers import LSTM, Dense
# import yfinance as yf
# from sklearn.preprocessing import MinMaxScaler

# def predict_stock_price(symbol):
#     stock = yf.Ticker(symbol)
#     df = stock.history(period="1d", auto_adjust=True)

#     if df.empty:
#         print("No stock data found!")
#         return None
   
#     data_training = pd.DataFrame(df['Close'][0:int(len(df)*0.70)])
#     data_testing = pd.DataFrame(df['Close'][int(len(df)*0.70): int(len(df))])
    
#     scaler = MinMaxScaler(feature_range=(0,1))
#     data_training_array = scaler.fit_transform(data_training)

#     x_train = []
#     y_train = [] 

#     for i in range(100, data_training_array.shape[0]):
#         x_train.append(data_training_array[i-100: i])
#         y_train.append(data_training_array[i, 0])

#     x_train, y_train = np.array(x_train), np.array(y_train) 

#     model = load_model('stock_prediction_model.h5')

#     past_100_days = data_training.tail(100)
#     final_df = past_100_days.append(data_testing, ignore_index=True)
#     input_data = scaler.transform(final_df)

#     x_test = []
#     y_test = []
#     for i in range(100, input_data.shape[0]):
#         x_test.append(input_data[i-100: i])
#         y_test.append(input_data[i, 0])

#     x_test, y_test = np.array(x_test), np.array(y_test)
#     y_predicted = model.predict(x_test)

#     scaler.scale_
#     scale_factor = 1/scaler[0]
#     y_predicted = y_predicted * scale_factor
#     y_test = y_test * scale_factor

#     return y_predicted





# # Step 01 : uninstall the existing tensorflow with this instruction
# # !pip uninstall tensorflow

# # step 02 : install this version i hope you find what you need in this version with this instruction
# # !pip install tensorflow==2.7.0

# # you can change the version of tensorflow if 2.7.0 not good for your code
