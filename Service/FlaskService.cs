//using Newtonsoft.Json;
//using NexTrade.Dtos.Stock;
//using System.Net.Http.Headers;

//namespace NexTrade.Service
//{
//    public class FlaskService
//    {
//        private readonly HttpClient _httpClient;
//        private readonly IConfiguration _configuration;

//        public FlaskService(HttpClient httpClient, IConfiguration configuration)
//        {
//            _httpClient = httpClient;
//            _configuration = configuration;
//        }

//        //public async Task<StockPriceDto> GetStockPriceFromFlaskAsync(string token, string stockSymbol)
//        //{
//        //    try
//        //    {
//        //        string flaskUrl = $"{_configuration["FlaskSettings:BaseUrl"]}/stock/{stockSymbol}";

//        //        _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

//        //        HttpResponseMessage response = await _httpClient.GetAsync(flaskUrl);

//        //        if (!response.IsSuccessStatusCode)
//        //            return null;

//        //        string responseData = await response.Content.ReadAsStringAsync();
//        //        return JsonConvert.DeserializeObject<StockPriceDto>(responseData);
//        //    }
//        //    catch (Exception)
//        //    {
//        //        return null;
//        //    }
//        //}


//        public async Task<StockPriceDto> GetStockPriceFromFlaskAsync(string token, string stockSymbol, string period)
//        {
//            try
//            {
//                string flaskUrl = $"{_configuration["FlaskSettings:BaseUrl"]}/stock/symbol/{stockSymbol}/period/{period}";
//                _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

//                HttpResponseMessage response = await _httpClient.GetAsync(flaskUrl);
//                string responseData = await response.Content.ReadAsStringAsync();

//                Console.WriteLine($"Flask Response: {response.StatusCode} - {responseData}");

//                if (!response.IsSuccessStatusCode)
//                    return null;

//                return JsonConvert.DeserializeObject<StockPriceDto>(responseData);
//            }
//            catch (Exception ex)
//            {
//                Console.WriteLine($"Error: {ex.Message}");
//                return null;
//            }
//        }

//    }
//}

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NexTrade.Dtos.Portfolio;
using NexTrade.Dtos.Stock;
using System.Net.Http.Headers;
using System.Text.Json;

namespace NexTrade.Service
{
    public class FlaskService
    {
        private readonly HttpClient _httpClient;
        private readonly IConfiguration _configuration;

        public FlaskService(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _configuration = configuration;
        }

        public async Task<List<StockPriceDto>> GetStockPriceFromFlaskAsync(string token, string stockSymbol, string period)
        {
            try
            {
                string flaskUrl = $"{_configuration["FlaskSettings:BaseUrl"]}//stock/symbol/{stockSymbol}/period/{period}";

                _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                HttpResponseMessage response = await _httpClient.GetAsync(flaskUrl);
                string responseData = await response.Content.ReadAsStringAsync();

                Console.WriteLine($"Flask PRICE Response: {response.StatusCode} - {responseData}");

                if (!response.IsSuccessStatusCode)
                    return null;

                return JsonConvert.DeserializeObject<List<StockPriceDto>>(responseData);
            }
            catch (Exception ex)    
            {
                Console.WriteLine($"Error: {ex.Message}");
                return null;
            }
        }

        public async Task<List<StockOpenCurrentPriceDto>> GetStockOpenCurrentPriceFromFlaskAsync(string token, List<string> stockSymbol)
        {
            try
            {
                string flaskUrl = $"{_configuration["FlaskSettings:BaseUrl"]}//stock/fetch-stock-open-current-price?" +string.Join("&", stockSymbol.Select(symbol => $"symbol={Uri.EscapeDataString(symbol)}"));
                
                _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                
                HttpResponseMessage response = await _httpClient.GetAsync(flaskUrl);
                string responseData = await response.Content.ReadAsStringAsync();

                Console.WriteLine($"Flask PRICE Response: {response.StatusCode} - {responseData}");

                if (!response.IsSuccessStatusCode)
                    return null;

                return JsonConvert.DeserializeObject<List<StockOpenCurrentPriceDto>>(responseData);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return null;
            }
        }


        public async Task<StockFinancialDto> GetStockFinancialFromFlaskAsync(string token, string stockSymbol)
        {
            try
            {
                string flaskUrl = $"{_configuration["FlaskSettings:BaseUrl"]}//stock/financials/symbol/{stockSymbol}";

                _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                HttpResponseMessage response = await _httpClient.GetAsync(flaskUrl);
                //string responseData = await response.Content.ReadAsStringAsync();

                

                if (!response.IsSuccessStatusCode)
                    return null;

                string responseData = await response.Content.ReadAsStringAsync();
                Console.WriteLine($"Flask FINANCIALS Response: {response.StatusCode} - {responseData}");

                //var settings = new JsonSerializerSettings
                //{
                //    FloatParseHandling = FloatParseHandling.Decimal, // Prevent NaN errors
                //    NullValueHandling = NullValueHandling.Include
                //};

                responseData = responseData.Replace(": NaN", ": null");

                //var parsedJson = JsonConvert.DeserializeObject<JObject>(responseData);
                //var dta = parsedJson.ToString();

                return JsonConvert.DeserializeObject<StockFinancialDto>(responseData);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return null;
            }
        }

        public async Task<StockFinancialChecksDto> GetStockFinancialChecksFromFlaskAsync(string token, string stockSymbol)
        {
            try
            {
                string flaskUrl = $"{_configuration["FlaskSettings:BaseUrl"]}//stock/ai-insights-balance-sheet/symbol/{stockSymbol}";

                _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

                HttpResponseMessage response = await _httpClient.GetAsync(flaskUrl);
                string responseData = await response.Content.ReadAsStringAsync();

                if (!response.IsSuccessStatusCode)
                    return null;

                return JsonConvert.DeserializeObject<StockFinancialChecksDto>(responseData);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return null;
            }
        }

        public async Task<List<StockIndex>> GetStockIndicesFromFlaskAsync(string token)
        {
            try
            {
                string flaskUrl = $"{_configuration["FlaskSettings:BaseUrl"]}//stock/indices";
                _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
                HttpResponseMessage response = await _httpClient.GetAsync(flaskUrl);

                string responseData = await response.Content.ReadAsStringAsync();

                if (!response.IsSuccessStatusCode)
                    return null;

                return JsonConvert.DeserializeObject<List<StockIndex>>(responseData);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return null;
            }
        }

    }
}

/*
 {
  "username": "harsh1",
  "password": "Harsh.j999999"
}


curl -X GET http://127.0.0.1:5000/stock/AAPL -H "Authorization: Bearer " 
 */