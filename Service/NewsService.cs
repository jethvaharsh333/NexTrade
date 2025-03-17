using Microsoft.AspNetCore.WebUtilities;

namespace NexTrade.Service
{
    public class NewsService
    {
        private readonly HttpClient _httpClient;
        public NewsService(HttpClient httpClient) {
            _httpClient = httpClient;
        }

        public async Task<Object> GetNewsByStocksService(string stockSymbol)
        {
            try
            {
                string baseUrl = "https://api.marketaux.com/v1/news/all";
                var queryParams = new Dictionary<string, string>
                {
                    {"symbols", $"{stockSymbol}.NS"},
                    {"filter_entities","true"},
                    {"language","en" },
                    {"api_token", "gn5T7RfIPJteACH2dilxsDTVZ1DC4cFy0cZSQ9dq"},
                };

                string requestUrl = QueryHelpers.AddQueryString(baseUrl, queryParams);
                Console.WriteLine(requestUrl);
                HttpResponseMessage response = await _httpClient.GetAsync(requestUrl);
                if (!response.IsSuccessStatusCode)
                {
                    return null;
                }
                string content = await response.Content.ReadAsStringAsync();

                return content;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}


/*
 {
  "meta": {
    "found": 2506,
    "returned": 3,
    "limit": 3,
    "page": 1
  },
  "data": [
    {
      "uuid": "0b432ccb-ae0b-445b-9e2e-ba6cf89d6857",
      "title": "Negative Breakout on February 27: TechM, Reliance Power among 10 stocks that dropped below their 200 DMAs - Under Pressure",
      "description": "In the NSE list of stocks with market cap over Rs 10,000 crore, 10 stocks' close prices crossed below their 200 DMA (Daily Moving Averages) on February 27, according to stockedge.com's technical scan data. Trading below the 200 DMA is considered a negative signal because it indicates that the stock's price is below its long-term trend line. The 200 DMA is used as a key indicator by traders for determining the overall trend in a particular stock. Take a look: Under Pressure",
      "keywords": "Jubilant Ingrevia, Reliance Power, Piramal Pharma, 360 One Wam, Eris Lifesciences, Devyani International",
      "snippet": "In the NSE list of stocks with market cap over Rs 10,000 crore, 10 stocks' close prices crossed below their 200 DMA (Daily Moving Averages) on February 27, acco...",
      "url": "https://economictimes.indiatimes.com/markets/stocks/news/negative-breakout-on-february-27-techm-reliance-power-among-10-stocks-that-dropped-below-their-200-dmas/slideshow/118616529.cms",
      "image_url": "https://img.etimg.com/thumb/msid-118616529,width-1070,height-580,overlay-etmarkets/slideshow.jpg",
      "language": "en",
      "published_at": "2025-02-28T03:31:01.000000Z",
      "source": "economictimes.indiatimes.com",
      "relevance_score": null,
      "entities": [
        {
          "symbol": "RPOWER.NS",
          "name": "Reliance Power Limited",
          "exchange": null,
          "exchange_long": null,
          "country": "in",
          "type": "equity",
          "industry": "Utilities",
          "match_score": 46.8131,
          "sentiment_score": -0.7096,
          "highlights": [
            {
              "highlight": "Negative Breakout on February 27: TechM, <em>Reliance</em> <em>Power</em> among 10 stocks that dropped below their 200 DMAs - Under Pressure",
              "sentiment": -0.7096,
              "highlighted_in": "title"
            }
          ]
        }
      ],
      "similar": []
    },
    {
      "uuid": "a9f29f82-d922-4441-8ec1-0dac829423f7",
      "title": "Stock Market Sectors: Stock market update: Power stocks down as market rises",
      "description": "The 30-share BSE Sensex closed  up  10.31 points at 74612.43",
      "keywords": "Stock Market Sectors, Sectors in stock Market, India stock market sectors, Global Stock Market Sectors, S&P 500 Sectors, S&P Sectors",
      "snippet": "\n\n\n\n(You can now subscribe to our\n\n(You can now subscribe to our ETMarkets WhatsApp channel\n\nNEW DELHI: Power shares closed lower in the Thursday's session.Jyot...",
      "url": "https://economictimes.indiatimes.com/markets/stocks/stock-watch/stock-market-update-power-stocks-down-as-market-rises/articleshow/118604514.cms",
      "image_url": "https://img.etimg.com/thumb/msid-78620279,width-1200,height-630,imgsize-275381,overlay-etmarkets/articleshow.jpg",
      "language": "en",
      "published_at": "2025-02-27T11:51:58.000000Z",
      "source": "economictimes.indiatimes.com",
      "relevance_score": null,
      "entities": [
        {
          "symbol": "RPOWER.NS",
          "name": "Reliance Power Limited",
          "exchange": null,
          "exchange_long": null,
          "country": "in",
          "type": "equity",
          "industry": "Utilities",
          "match_score": 19.42528,
          "sentiment_score": -0.128,
          "highlights": [
            {
              "highlight": "(down 5.00%), <em>Reliance</em> <em>Powe[+322 characters]",
              "sentiment": -0.128,
              "highlighted_in": "main_text"
            }
          ]
        }
      ],
      "similar": []
    },
    {
      "uuid": "8c64b3a6-be6c-44c7-ab8a-688ee17f1fb4",
      "title": "Stock Market Sectors: Stock market update: Power stocks down as market falls",
      "description": "The 30-share BSE Sensex closed  down  199.76 points at 75939.21",
      "keywords": "Stock Market Sectors, Sectors in stock Market, India stock market sectors, Global Stock Market Sectors, S&P 500 Sectors, S&P Sectors",
      "snippet": "\n\n\n\n(You can now subscribe to our\n\n(You can now subscribe to our ETMarkets WhatsApp channel\n\nNEW DELHI: Power shares closed lower in the Friday's session.India ...",
      "url": "https://economictimes.indiatimes.com/markets/stocks/stock-watch/stock-market-update-power-stocks-down-as-market-falls/articleshow/118246272.cms",
      "image_url": "https://img.etimg.com/thumb/msid-83800143,width-1200,height-630,imgsize-287158,overlay-etmarkets/articleshow.jpg",
      "language": "en",
      "published_at": "2025-02-14T10:52:46.000000Z",
      "source": "economictimes.indiatimes.com",
      "relevance_score": null,
      "entities": [
        {
          "symbol": "RPOWER.NS",
          "name": "Reliance Power Limited",
          "exchange": null,
          "exchange_long": null,
          "country": "in",
          "type": "equity",
          "industry": "Utilities",
          "match_score": 19.758068,
          "sentiment_score": 0.1531,
          "highlights": [
            {
              "highlight": "(down 6.03%), <em>Reliance</em> <em>Powe[+323 characters]",
              "sentiment": 0.1531,
              "highlighted_in": "main_text"
            }
          ]
        }
      ],
      "similar": []
    }
  ]
}
 */