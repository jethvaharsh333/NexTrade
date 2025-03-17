using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using NexTrade.Data;
using NexTrade.Dtos.Stock;
using NexTrade.Interfaces.Stock;
using NexTrade.Mappers;

namespace NexTrade.Controllers
{
    [Route("api/stock")]
    [ApiController]
    public class StockController : ControllerBase
    {
        private readonly ApplicationDBContext _context;
        private readonly IStockRepository _stockRepository;
        private readonly IStockService _stockService;
        public StockController(ApplicationDBContext context, IStockRepository stockRepository, IStockService stockService)
        {
            _stockRepository = stockRepository;
            _context = context;
            _stockService = stockService;
        }

        [HttpGet("get-all")]
        [Authorize]
        public async Task<IActionResult> GetAll([FromQuery] int page = 1, [FromQuery] int pageSize = 10)
        {
            if (page < 1 || pageSize < 1)
            {
                return BadRequest(new { message = "Invalid pagination parameters" });
            }
            var stocks = await _stockRepository.GetAllAsync(page, pageSize);
            var stockDto = stocks.Select(s => s.ToStockListDto()).ToList();
            return Ok(stockDto);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById([FromRoute] int id) 
        {
            var stock = await _stockRepository.GetByIDAsync(id);

            if(stock == null)
            {
                return NotFound();
            }

            return Ok(stock.ToStockDto());
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateStockRequestDto creatStockDto)
        {
            var stockModel = creatStockDto.ToStockFromRequestDto();
            await _stockRepository.CreateAsync(stockModel);

            return CreatedAtAction(nameof(GetById), new { id = stockModel.StockID }, stockModel.ToStockDto());
        }

        [HttpPut]
        [Route("{id}")]
        public async Task<IActionResult> Update([FromRoute] int id, [FromBody] UpdateStockRequestDto updateStockDto)
        {
            var stockModel = await _stockRepository.UpdateAsync(id, updateStockDto);

            if (stockModel == null)
            {
                return NotFound();
            }

            return Ok(stockModel.ToStockDto());
        }

        [HttpDelete]
        [Route("{id}")]
        public async Task<IActionResult> Delete([FromRoute] int id) 
        {
            var stockModel = await _stockRepository.DeleteAsync(id);

            if (stockModel == null) 
            {
                return NotFound();
            }

            return NoContent();

        }

        [HttpGet("price")]
        [Authorize]
        public async Task<IActionResult> GetStockPrice(string stockSymbol, string period = "1d")
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");

            var result = await _stockService.GetStockPriceAsync(token, stockSymbol, period);

            if (result == null)
                return NotFound(new { Message = "Periodic stock price data unavailable" });

            return Ok(result);
        }

        [HttpGet("financials")]
        [Authorize]
        public async Task<IActionResult> GetStockFinancials(string stockSymbol)
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            var result = await _stockService.GetStockFinancialAsync(token, stockSymbol);

            if (result == null)
                return NotFound(new { Message = "Financial data of stock unavailable" });

            return Ok(result);
        }

        [HttpGet("financialChecks/{stockSymbol}")]
        [Authorize]
        public async Task<IActionResult> GetStockFinancialChecks(string stockSymbol)
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            var result = await _stockService.GetStockFinancialCheckAsync(token, stockSymbol);

            if (result == null)
                return NotFound(new { Message = "Financial checks data of stock unavailable" });

            return Ok(result);
        }

        [HttpGet("indices")]
        [Authorize]

        public async Task<IActionResult> GetIndices()
        {
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            var result = await _stockService.GetStockIndicesAsync(token);
            if (result == null)
                return NotFound(new { Message = "Indices data unavailable" });

            Console.WriteLine(result);
            return Ok(result);
        }



    }
}

/*
--------
 GetAll
---------
[
  {
    //"stockID": 1,
    "stockName": "20 Microns Limited",
    "stockSymbol": "20MICRONS",
    //"dateOfListing": "2008-10-06T00:00:00",
    "faceValue": 5,
    "stockImage": null,
    "industry": null,
    //"comments": []
  },
]
----------------------------------------------
[
  {
    "stockName": "20 Microns Limited",
    "stockSymbol": "20MICRONS",
    "faceValue": 5,
    "stockImage": null,
    "industry": null
  },
]
-----------------------------------------------
 {
  "balanceSheet": {
    "bookValuePerShare": 35.831,
    "cashAndCashEquivalents": 8845899776,
    "debtToEquityRatio": 103.54,
    "netDebt": 183302600000,
    "otherShortTermInvestments": 365800000,
    "totalAssets": 437602600000,
    "totalDebt": 149028306944,
    "totalLiabilities": null
  },
  "cashFlow": {
    "capitalExpenditures": null,
    "freeCashFlow": null,
    "totalCashFlowFromOperations": null
  },
  "dividendsSplits": {
    "dividendDate": 1447891200,
    "lastDividendPaid": 1,
    "lastStockSplitDate": 1212105600,
    "lastStockSplitRatio": "8:5"
  },
  "generalInfo": {
    "averageVolume10Days": 20965890,
    "beta": 1.72,
    "companyName": "Reliance Power Limited",
    "currency": "INR",
    "currentPrice": 36.8,
    "dayHigh": 37.55,
    "dayLow": 36.7,
    "enterpriseValue": 292251140096,
    "exchange": "NSI",
    "fiftyTwoWeekHigh": 53.64,
    "fiftyTwoWeekLow": 19.4,
    "marketCap": 155854258176,
    "openPrice": 37.4,
    "previousClosePrice": 37.7,
    "sharesOutstanding": 4235170048
  },
  "incomeStatement": {
    "costOfRevenue": null,
    "ebitda": 20146900992,
    "ebitdaMargins": 0.26504,
    "grossProfit": 0,
    "netIncome": -20683800000,
    "operatingIncome": 0,
    "operatingMargins": 0.15513,
    "profitMargins": 0.31897,
    "revenueGrowth": 0,
    "totalRevenue": 0
  },
  "riskGovernance": {
    "auditRisk": 8,
    "boardRisk": 8,
    "compensationRisk": 1,
    "overallRiskScore": 7,
    "shareholderRightsRisk": 10
  },
  "shareholderHoldings": {
    "floatShares": 2869380000,
    "heldByInsiders": 0.28858,
    "heldByInstitutions": 0.10185,
    "treasurySharesNumber": 0
  },
  "valuation": {
    "enterpriseValueToEBITDA": 14.506,
    "enterpriseValueToRevenue": 3.845,
    "forwardPERatio": 8.159645,
    "priceToBookRatio": 1.0270436,
    "priceToSalesRatio": 2.0503013,
    "trailingPERatio": 6.3667817
  }
}
 */