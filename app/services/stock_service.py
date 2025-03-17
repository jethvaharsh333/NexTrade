import yfinance as yf
# from tensorflow.keras.models import Sequential
# from keras.models import Sequential, load_model
# from tensorflow.keras.models import load_model


def fetch_stock_price(symbol, period):
    stock = yf.Ticker(symbol)
    
    if period == "5d":
        interval = "5m"
    elif period == "1d":
        interval = "1m"
    else:
        interval = "1d"

    hist = stock.history(period=period, interval=interval, auto_adjust=True)

    if hist.empty:
        print("No stock data found!")
        return None    

    price_data = [
        {
            "date": row.name.strftime("%Y-%m-%d %H:%M:%S"),
            "open": float(row["Open"]),
            "high": float(row["High"]),
            "low": float(row["Low"]),
            "close": float(row["Close"]),
            "volume": int(row["Volume"]),
        }
        for _, row in hist.iterrows()
    ]

    print(price_data)
    return price_data

def get_stock_open_current_price(symbols):
    stock_data = []

    for i in symbols:
        stock = yf.Ticker(i)
        hist = stock.history(period="1d", auto_adjust=True)

        if hist.empty:
            print(f"No stock data found for {i}!")
            continue
        
        stock_data.append({
            "stockSymbol": i,
            "openPrice": float(hist["Open"].iloc[0]),
            "currentPrice": float(hist["Close"].iloc[-1])
        })

    return stock_data 

def fetch_stock_values(symbol):
    ticker = yf.Ticker(symbol)

    infox = ticker.info
    financialx = ticker.financials
    balance_sheetx = ticker.balance_sheet

    # if infox.empty or financialx.empty or bala:
    #     print("No stock data found!")
    #     return None    

    return {
        "GeneralInfo": {
            "companyName": infox.get("longName"),
            "exchange": infox.get("exchange"),
            "currency": infox.get("currency"),
            "marketCap": infox.get("marketCap"),
            "enterpriseValue": infox.get("enterpriseValue"),
            "beta": infox.get("beta"),
            "fiftyTwoWeekHigh": infox.get("fiftyTwoWeekHigh"),
            "fiftyTwoWeekLow": infox.get("fiftyTwoWeekLow"),
            "currentPrice": infox.get("currentPrice"),
            "previousClosePrice": infox.get("previousClose"),
            "openPrice": infox.get("open"),
            "dayHigh": infox.get("dayHigh"),
            "dayLow": infox.get("dayLow"),
            "averageVolume10Days": infox.get("averageVolume10days"),
            "sharesOutstanding": infox.get("sharesOutstanding"),
        },
        "IncomeStatement": {
            "totalRevenue": infox.get("totalRevenue"),
            "revenueGrowth": infox.get("revenueGrowth"),
            "grossProfit": infox.get("grossProfits"),
            "operatingIncome": financialx.loc["Operating Income"].iloc[0] if "Operating Income" in financialx.index else None,
            "ebitda": infox.get("ebitda"),
            "netIncome": financialx.loc["Net Income"].iloc[0] if "Net Income" in financialx.index else None,
            "profitMargins": infox.get("profitMargins"),
            "operatingMargins": infox.get("operatingMargins"),
            "ebitdaMargins": infox.get("ebitdaMargins"),
            "costOfRevenue": financialx.loc["Cost of Revenue"].iloc[0] if "Cost of Revenue" in financialx.index else None,
        },
        "BalanceSheet": {
            "totalAssets": balance_sheetx.loc["Total Assets"].iloc[0] if "Total Assets" in balance_sheetx.index else None,
            "totalLiabilities": balance_sheetx.loc["Total Liabilities"].iloc[0] if "Total Liabilities" in balance_sheetx.index else None,
            "totalDebt": infox.get("totalDebt"),
            "netDebt": balance_sheetx.loc["Net Debt"].iloc[0] if "Net Debt" in balance_sheetx.index else None,
            "debtToEquityRatio": infox.get("debtToEquity"),
            "cashAndCashEquivalents": infox.get("totalCash"),
            "otherShortTermInvestments": balance_sheetx.loc["Other Short Term Investments"].iloc[0] if "Other Short Term Investments" in balance_sheetx.index else None,
            "bookValuePerShare": infox.get("bookValue"),
        },
        "Valuation": {
            "trailingPERatio": infox.get("trailingPE"),
            "forwardPERatio": infox.get("forwardPE"),
            "priceToBookRatio": infox.get("priceToBook"),
            "priceToSalesRatio": infox.get("priceToSalesTrailing12Months"),
            "enterpriseValueToRevenue": infox.get("enterpriseToRevenue"),
            "enterpriseValueToEBITDA": infox.get("enterpriseToEbitda"),
        },
        "CashFlow": {
            "totalCashFlowFromOperations": financialx.loc["Total Cash From Operating Activities"].iloc[0] if "Total Cash From Operating Activities" in financialx.index else None,
            "capitalExpenditures": financialx.loc["Capital Expenditures"].iloc[0] if "Capital Expenditures" in financialx.index else None,
            "freeCashFlow": financialx.loc["Free Cash Flow"].iloc[0] if "Free Cash Flow" in financialx.index else None,
        },
        "RiskGovernance": {
            "overallRiskScore": infox.get("overallRisk"),
            "auditRisk": infox.get("auditRisk"),
            "boardRisk": infox.get("boardRisk"),
            "compensationRisk": infox.get("compensationRisk"),
            "shareholderRightsRisk": infox.get("shareHolderRightsRisk"),
        },
        "ShareholderHoldings": {
            "heldbyInsiders": infox.get("heldPercentInsiders"),
            "heldbyInstitutions": infox.get("heldPercentInstitutions"),
            "floatShares": infox.get("floatShares"),
            "treasurySharesNumber": balance_sheetx.loc["Treasury Shares Number"].iloc[0] if "Treasury Shares Number" in balance_sheetx.index else None,
        },
        "DividendsSplits": {
            "lastDividendPaid": infox.get("lastDividendValue"),
            "dividendDate": infox.get("lastDividendDate"),
            "lastStockSplitRatio": infox.get("lastSplitFactor"),
            "lastStockSplitDate": infox.get("lastSplitDate"),
        }
    }

def fetch_AI_Insights_From_BalanceSheet(symbol):
    ticker = yf.Ticker(symbol)

    info = ticker.info
    financials = ticker.financials
    balance_sheet = ticker.balance_sheet

    net_income = financials.loc["Net Income"].iloc[0] if "Net Income" in financials.index else None
    ebitda = info.get("ebitda", None)
    total_revenue = info.get("totalRevenue", None)
    total_debt = info.get("totalDebt", None)
    net_debt = balance_sheet.loc["Net Debt"].iloc[0] if "Net Debt" in balance_sheet.index else None
    cash_equivalents = info.get("totalCash", None)
    debt_to_equity = info.get("debtToEquity", None)
    revenue_growth = info.get("revenueGrowth", None)
    trailing_pe = info.get("trailingPE", None)
    price_to_book = info.get("priceToBook", None)
    price_to_sales = info.get("priceToSalesTrailing12Months", None)
    beta = info.get("beta", None)
    held_percent_insiders = info.get("heldPercentInsiders", None)
    held_percent_institutions = info.get("heldPercentInstitutions", None)

    insights = {}

    # 1️⃣ Profitability Check
    if net_income and net_income > 0 and ebitda and ebitda > 0:
        insights["profitabilityCheck"] = "The company is profitable."
    elif net_income and net_income < 0 and ebitda and ebitda > 0:
        insights["profitabilityCheck"] = "Core operations are profitable, but non-operational losses are high."
    else:
        insights["profitabilityCheck"] = "The company is not profitable."

    # 2️⃣ Revenue Growth Check
    if revenue_growth and revenue_growth > 0.05:
        insights["revenueGrowthCheck"] = "Strong revenue growth."
    elif revenue_growth and 0 < revenue_growth <= 0.05:
        insights["revenueGrowthCheck"] = "Moderate revenue growth."
    else:
        insights["revenueGrowthCheck"] = "Revenue is shrinking."

    # 3️⃣ Debt & Financial Risk Assessment
    if debt_to_equity and debt_to_equity < 1:
        insights["debtRiskCheck"] = "Low debt-to-equity, financially stable."
    elif debt_to_equity and 1 <= debt_to_equity <= 2:
        insights["debtRiskCheck"] = "Moderate debt, manageable."
    else:
        insights["debtRiskCheck"] = "High debt-to-equity ratio, potential risk."

    # 4️⃣ Liquidity Check
    if cash_equivalents and total_debt and cash_equivalents > total_debt * 0.1:
        insights["liquidityCheck"] = "Strong liquidity, can cover short-term liabilities."
    elif cash_equivalents and total_debt and cash_equivalents > total_debt * 0.05:
        insights["liquidityCheck"] = "Moderate liquidity."
    else:
        insights["liquidityCheck"] = "Low liquidity, risk of financial distress."

    # 5️⃣ Valuation (PE, PB, PS)
    if trailing_pe and trailing_pe < 10 and price_to_book and price_to_book < 1.5 and price_to_sales and price_to_sales < 2:
        insights["valuationCheck"] = "Stock appears undervalued, potential buying opportunity."
    elif trailing_pe and 10 <= trailing_pe <= 20:
        insights["valuationCheck"] = "Stock is fairly valued."
    else:
        insights["valuationCheck"] = "Overvalued stock, high risk."

    # 6️⃣ Risk & Volatility Check
    if beta and beta < 1:
        insights["volatilityCheck"] = "Low volatility, stable stock."
    elif beta and 1 <= beta <= 2:
        insights["volatilityCheck"] = "Moderate volatility."
    else:
        insights["volatilityCheck"] = "High volatility, risky stock."

    # 7️⃣ Institutional & Insider Holdings
    if held_percent_insiders and held_percent_insiders > 0.2 and held_percent_institutions and held_percent_institutions > 0.2:
        insights["investorConfidenceCheck"] = "Strong insider and institutional confidence."
    elif held_percent_insiders and held_percent_institutions and (held_percent_insiders > 0.1 or held_percent_institutions > 0.1):
        insights["investorConfidenceCheck"] = "Moderate investor confidence."
    else:
        insights["investorConfidenceCheck"] = "Low investor confidence, proceed with caution."

    # 📌 Final Investment Suggestion
    if (
        net_income and net_income > 0 and
        revenue_growth and revenue_growth > 0.05 and
        debt_to_equity and debt_to_equity < 1.5 and
        trailing_pe and trailing_pe < 15
    ):
        insights["investmentDecision"] = "BUY - Strong Financials & Valuation."
    elif (
        revenue_growth and revenue_growth > 0 and
        debt_to_equity and debt_to_equity < 2
    ):
        insights["investmentDecision"] = "HOLD - Some Risks Present."
    else:
        insights["investmentDecision"] = "SELL - Weak Financials or High Risk."

    return insights

def fetch_Indices_Data():
    indices = {
        "NIFTY50":"^NSEI",
        "USD/INR": "USDINR=X",
        "NIFTYNext50":"^NSENEXT50",
        "Gold": "GC=F",
        "Nifty MidCap 100": "^NSEMDCP50",
        "Nasdaq 100": "^NDX",
        "NIFTYBank":"^NSEBANK",
        "NIFTYIT":"^CNXIT",
        "NIFTYMidcap50":"^NSEMDCP50",
        "NIFTY100":"^CNX100",
        "NIFTY200":"^CNX200",
        "NIFTYAuto":"^CNXAUTO",
        "NIFTYFMCG":"^CNXFMCG",
        "NIFTYPharma":"^CNXPHARMA",
        "NIFTYRealty":"^CNXREALTY",
        "NIFTYMetal":"^CNXMETAL",
        "NIFTYEnergy":"^CNXENERGY",
        "NIFTYInfrastructure":"^CNXINFRA",
        "NIFTYMNC":"^CNXMNC",
        "NIFTYPSE":"^CNXPSE",
        "NIFTYServicesSector":"^CNXSERVICE",
        "NIFTYMedia":"^CNXMEDIA",
        "NIFTYPSUBank":"^CNXPSUBANK",
    }

    indices_data = []

    for name, ticker in indices.items():
        data = yf.Ticker(ticker).history(period="1d") 
        if not data.empty:
            open_price = data["Open"].iloc[0]
            close_price = data["Close"].iloc[-1]
            change = close_price - open_price
            percentage_change = (change / open_price) * 100
            
            indices_data.append({
                "indexName": name,
                "priceChange": round(change, 2),
                "percentageChange": round(percentage_change, 2)
            })
        else:
            indices_data.append({
                "indexName": name,
                "priceChange": None,
                "percentageChange": None
            })

    return indices_data

